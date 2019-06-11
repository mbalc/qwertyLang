--  Still a number of features missing (commented out from syntax) but base skeleton done
--  Main features that work:
--  - printing (polymorphic)
--  - Hiding of labels in store; blocks
--  Main problems to fix:
--  - Code should be better, more modular
--  - More syntax should be in denotational style
--  - Missing major features like loops&control, function results, typechecking
--  - Some smaller features missing - left to do because it'd be better if I do
--    - denotational refactor first, haven't managed to do it all and I wanted to rather
--    - focus on features
--  I see that after writing this code I understand the idea much better already,
--    it's not a leap in the dark to write sth like this anymore and I'm really looking
--    forward to finishing this project
module Main where

import System.Environment (getArgs, getProgName)
import System.Exit (ExitCode(..), exitFailure, exitSuccess, exitWith)

import qualified Data.Map as Map

import Debug.Trace

import Control.Monad
import Control.Monad.Trans

import Control.Monad.Trans.Maybe
import Control.Monad.Trans.Except
import Control.Monad.Trans.State

import AbsQwerty
import ParQwerty

import ErrM

type Returned = Maybe Memo
type Result = ExceptT QwertyError IO
type QwertyExe = StateT AppStore Result

type QwertyError = String

data Memo
  = IntMem Integer
  | BoolMem Bool
  | StringMem String
  | FuncMem ScopeType Func
  | VoidMem

type Func = [Memo] -> QwertyExe Returned

instance Show ScopeType where
  show DynamicS = "dynamically-binded"
  show (StaticS _) = "statically-binded"

instance Show Memo where
  show (IntMem i) = show i
  show (BoolMem b) = show b
  show (StringMem s) = s
  show (FuncMem scopetype _) = show scopetype ++ "func"
  show VoidMem = "void"

typecheck :: Program -> IO ()
typecheck p = return () -- print "ok (todo)"

-- debug a = liftIO $ traceStack a $ putStrLn ""
debug a = return ()

-- store management
-- decided not to use ReaderT - very little boilerplate to adapt StateT, not worth refactoring, easier debug, more control
type AppStore = (AppState, Locs, Loc)
type AppState = Map.Map Loc Memo

type Locs = Map.Map Ident Loc
type Loc = Integer

data ScopeType = DynamicS | StaticS Locs

mapLookup :: Ord a => QwertyError -> a -> Map.Map a b -> Result b
mapLookup e k m = case Map.lookup k m of
  Just a -> return a
  Nothing -> throwE e

storeDeclare :: Ident -> QwertyExe Returned
storeDeclare k = do
  debug ("new declaration for " ++ show k)
  (m, ls, l) <- get
  put (m, Map.insert k l ls, l + 1); return Nothing

storePut :: Ident -> Memo -> QwertyExe Memo
storePut k v = do
  debug ("assigning to " ++ show k ++ show v)
  (m, ls, l) <- get
  case Map.lookup k ls of Just l1 -> do put (Map.insert l1 v m, ls, l); return v
                          Nothing -> storeDeclare k >> storePut k v

storeGet :: Ident -> QwertyExe Memo
storeGet (Ident k) = do
  (s, ls, p) <- get
  debug $ "attempting to look up " ++ show k ++ " in " ++ show ls
  l <- lift $ mapLookup ("variable " ++ k ++ " not declared") (Ident k) ls
  lift $ mapLookup ("variable " ++ k ++ " declared but not defined") l s

runFuncLocal :: ScopeType -> QwertyExe m -> QwertyExe m
runFuncLocal scope future = do
  (mem, oldLs, loc) <- get
  let newScope = case scope of DynamicS -> oldLs
                               StaticS locs -> locs
                            in put (mem, newScope, loc)
  result <- future
  (newMem, _, newL) <- get
  put (newMem, oldLs, newL)
  return result


-- expr evaluation - common boilerplate
operatorError :: String -> [Memo] -> Result Memo
operatorError disp ms = throwE $ "attempted to use " ++ disp ++ " on incompatible types: " ++ (unwords $ map show ms)

evalAddOperator :: AddOp -> Memo -> Memo -> Result Memo
evalAddOperator Plus (IntMem x) (IntMem y) = return $ IntMem $ x + y
evalAddOperator Plus (StringMem x) (StringMem y) = return $ StringMem $ x ++ y
evalAddOperator Minus (IntMem x) (IntMem y) = return $ IntMem $ x - y
evalAddOperator op x y = operatorError (show op) [x, y]

evalMulOperator :: MulOp -> Memo -> Memo -> Result Memo
evalMulOperator Times (IntMem x) (IntMem y) = return $ IntMem $ x * y
evalMulOperator Div (IntMem x) (IntMem 0) = throwE "division by zero attempt"
evalMulOperator Div (IntMem x) (IntMem y) = return $ IntMem $ div x y
evalMulOperator Mod (IntMem x) (IntMem 0) = throwE "modulo by zero attempt"
evalMulOperator Mod (IntMem x) (IntMem y) = return $ IntMem $ mod x y
evalMulOperator op x y = operatorError (show op) [x, y]

evalBoolOperator :: (Bool -> Bool -> Bool) -> Expr -> Expr -> QwertyError -> QwertyExe Memo
evalBoolOperator op a b opErrTxt = do
    p <- eval a
    q <- eval b
    case (p, q) of (BoolMem x, BoolMem y) -> return $ BoolMem $ op x y
                   _ -> lift $ operatorError opErrTxt [p, q]

relOperator :: Ord a => RelOp -> a -> a -> Bool
relOperator op =
  case op of LTH -> (<)
             LE -> (<=)
             GTH -> (>)
             GE -> (>=)
             EQU -> (==)
             NE -> (/=)

-- main evaluation
class Eval a where
  eval :: a -> QwertyExe Memo

predeclareArgs = mapM_ (\(FunArg t id) -> storeDeclare id)

instance Eval Expr where
  eval (EVar identifier) = storeGet identifier
  eval (ELitInt integer) = return $ IntMem integer
  eval (ELambda (FunArgs argdecls) block) = do
    (_, ls, _) <- get
    runFuncLocal (StaticS ls) $ do
      predeclareArgs argdecls

      (_, newLs, _) <- get
      return $ FuncMem (StaticS newLs) $
        \argdefs -> do
            mapM_ matchFuncArg $ zip argdecls argdefs
            debug $ "calling a lambda function with (" ++ show (zip argdecls argdefs) ++ ") in " ++ show newLs ++ " compared to " ++ show ls
            interpret block
  eval ELitTrue = return $ BoolMem True
  eval ELitFalse = return $ BoolMem False
  eval (EApp expression arglist) = do
    storedfunc <- eval expression
    (_, ls, _) <- get
    debug ("call func application " ++ show expression ++ " with " ++ show arglist ++ " in " ++ show ls)
    case storedfunc of FuncMem scopetype func -> do
                          args <- mapM eval arglist
                          result <- runFuncLocal scopetype $ func args
                          case result of Nothing -> lift $ throwE $ "Missing return in " ++ show expression
                                         Just out -> return out
                       m -> lift $ throwE $ "Attempted to call " ++ show m ++ " which is not a function"
  eval (EString s) = return $ StringMem s
  eval (Neg e) = do
    n <- eval e
    case n of IntMem x -> return $ IntMem $ negate x
              _ -> lift $ operatorError (show (Neg e)) [n]
  eval (Not e) = do
    b <- eval e
    case b of BoolMem x -> return $ BoolMem $ not x
              _ -> lift $ operatorError (show (Not e)) [b]
  eval (EMul a op b) = do
    p <- eval a
    q <- eval b
    lift $ evalMulOperator op p q
  eval (EAdd a op b) = do
    p <- eval a
    q <- eval b
    lift $ evalAddOperator op p q
  eval (ERel a op b) = do
      p <- eval a
      q <- eval b
      case (p, q) of (StringMem x, StringMem y) -> return $ BoolMem $ relOperator op x y
                     (IntMem x, IntMem y) -> return $ BoolMem $ relOperator op x y
                     (BoolMem x, BoolMem y) -> return $ BoolMem $ relOperator op x y
                     _ -> lift $ operatorError (show op) [p, q]
  eval (EAnd a b) = evalBoolOperator (&&) a b (show $ EAnd a b)
  eval (EOr a b) = evalBoolOperator (||) a b (show $ EOr a b)

printer :: Func
printer outs = do
  liftIO $ putStrLn $ unwords $ map show outs
  return $ Just VoidMem -- we specify that a function always has to return something

matchFuncArg :: (Arg, Memo) -> QwertyExe Memo
matchFuncArg (FunArg t id, v) = storePut id v

declare :: Maybe Memo -> Item -> QwertyExe Returned
declare Nothing (NoInit i) = do debug "a noinitlift here" ; storeDeclare i
declare (Just defaultDef) (NoInit i) = do debug "a noinitlift here" ; storePut i defaultDef; return $ Just defaultDef
declare _ (Init i e) = do -- TODO what about type mismatch here?
  debug "a lift here"
  v <- eval e
  result <- storeDeclare i >> storePut i v
  return $ Just result 


class Interpret a where
  interpret :: a -> QwertyExe Returned

instance Interpret Stmt where
  interpret Empty = return Nothing
  interpret (BStmt b) = do
    (_, ls, _) <- get
    runFuncLocal (StaticS ls) $ interpret b
  interpret (Ass i e) = do
    v <- eval e
    storePut i v
    return Nothing
  interpret (Ret e) = do
    st <- eval e
    return $ Just st
  interpret VRet = return $ Just VoidMem
  interpret (Decl tp defs) = do
    case tp of TInt -> mapM_ (declare $ Just $ IntMem 0) defs
               TStr -> mapM_ (declare Nothing) defs
               TBool -> mapM_ (declare (Just $ BoolMem False)) defs
               TVoid -> mapM_ (declare $ Just VoidMem) defs
               TFun argtypes rettype -> mapM_ (declare Nothing) defs
    return Nothing
  interpret (Incr i) = interpret (Ass i (EAdd (EVar i) Plus (ELitInt 1)))
  interpret (Decr i) = interpret (Ass i (EAdd (EVar i) Minus (ELitInt 1)))
  interpret (Assert e) = do
    v <- eval e
    case v of BoolMem True -> return Nothing
              _ -> lift $ throwE "Assertion failure"
  interpret (SExp expression) = do eval expression; return Nothing  -- 'dangling' expression
  interpret (Cond e s) = interpret (CondElse e s Empty)
  interpret (CondElse e s1 s2) = do
    v <- eval e
    (_, ls, _) <- get
    runFuncLocal (StaticS ls) $ case v of BoolMem True -> interpret s1
                                          BoolMem False -> interpret s2
                                          _ -> lift $ throwE "Bad expression type in `if` condition"
  interpret (While e s) = do
    v <- eval e
    (_, ls, _) <- get
    runFuncLocal (StaticS ls) $ case v of BoolMem True -> runFuncLocal (StaticS ls) $ interpret s `myMPlus` interpret (While e s)
                                          BoolMem False -> return Nothing
                                          _ -> lift $ throwE "Bad expression type in `while` condition"

  interpret (NestFunc topdef) = interpret topdef
  interpret (ConstDecl tp defs) =
--   interpret Break = 
--   interpret Continue = 
--   interpret (For Ident Range Stmt) =
instance Interpret FnDef where
  interpret (TopDef t i args block) = do
    debug "udpap"
    storeDeclare i
    func <- eval $ ELambda args block
    storePut i func
    return Nothing

-- had problems adapting regular mplus
myMPlus m1 m2 = do
  v1 <- m1
  case v1 of Just n -> return $ Just n
             _ -> m2
    

instance Interpret Block where
  interpret (ScopeBlock []) = return Nothing
  interpret (ScopeBlock (s:ss)) = interpret s `myMPlus` interpret (ScopeBlock ss)

  -- interpret (ScopeBlock (s:ss)) = let u = interpret s in do
  --   out <- interpret s `myMPlus` (interpret (ScopeBlock ss))
  --   w <- interpret s
  --   debug (show w ++ "nextplx")
  --   return out

  -- interpret (ScopeBlock (s:ss)) = do
  --   u <- interpret s
  --   debug (show u ++ "nextplx")
  --   case u of
  --     Just n -> return $ Just n
  --     _ -> (interpret $ ScopeBlock ss)

instance Interpret Program where
  interpret (MainProg defs) = do
    mapM_ interpret defs
    (m, ls, _) <- get

    storemain <- storeGet $ Ident "main"
    debug $ "Launching `main`!, state " ++ show ls ++ show m
    case storemain of FuncMem _ f -> runFuncLocal DynamicS $ f [] -- ignore saved locs and use newest ones instead - so all topdefs are there
                      _ -> lift $ throwE "`main` is not a function"

startingState = let (m, ls, ln) = (Map.empty, Map.empty, 0)
  in (Map.insert ln (FuncMem DynamicS printer) m, Map.insert (Ident "print") ln ls, ln + 1)

run :: QwertyExe Returned -> IO ()
run prog = do
  returnValue <- liftIO $ runExceptT $ runStateT prog startingState
  debug $ show returnValue
  case returnValue of Right (Just (IntMem 0), _) -> exitSuccess
                      Right (Just (IntMem n), _) -> ioError $ userError $ "Status " ++ show n ++ " returned from `main`"
                      Right (Nothing, _) -> ioError $ userError "Missing return in `main`"
                      Left err -> ioError $ userError err
                      _ -> ioError $ userError "wrong `main` function type"

parseFile :: String -> IO ()
parseFile file = do
  s <- readFile file
  let ts = myLexer s in
    case pProgram ts of Bad s -> do
                          putStrLn "Parse failed\n"
                          putStrLn s
                          exitFailure
                        Ok tree -> do
                          typecheck tree
                          debug $ show tree
                          run $ interpret tree

main :: IO ()
main = do
  args <- getArgs
  prog <- getProgName
  case args of [] -> do
                 putStrLn
                   ("Interpreter mode not supported\nUsage: " ++ prog ++ " <program>")
                 exitFailure
               [file] -> parseFile file
               files -> do
                 putStrLn "Please provide only one file"
                 exitFailure
