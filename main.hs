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

import Control.Monad.Trans

import Control.Monad.Trans.Maybe
import Control.Monad.Trans.Except
import Control.Monad.Trans.State

import AbsQwerty
import ParQwerty

import ErrM

type Result = ExceptT QwertyError IO
type QwertyExe = StateT AppStore Result

type QwertyError = String

type AppStore = (AppState, Locs, Loc)

type AppState = Map.Map Loc Memo

data Memo
  = IntMem Integer
  | BoolMem Bool
  | StringMem String
  | FuncMem Func
  | VoidMem

type Func = [Expr] -> QwertyExe Memo

type Locs = Map.Map Ident Loc

type Loc = Integer

instance Show Memo where
  show (IntMem i) = show i
  show (BoolMem b) = show b
  show (StringMem s) = s
  show (FuncMem _) = show "func"
  show VoidMem = show "void"

typecheck :: Program -> IO ()
typecheck p = return () -- print "ok (todo)"

mapLookup :: Ord a => QwertyError -> a -> Map.Map a b -> Result b
mapLookup e k m = case Map.lookup k m of
  Just a -> return a
  Nothing -> throwE e

-- store modification
storePut :: Ident -> Memo -> QwertyExe Memo
storePut k v = do
  liftIO $ putStrLn $ "assigning to " ++ show k ++ show v
  (m, ls, l) <- get
  case Map.lookup k ls of
    Just l1 -> do put (Map.insert l1 v m, ls, l); return v
    Nothing -> do put (Map.insert l v m, Map.insert k l ls, l + 1); return v

storeGet :: Ident -> QwertyExe Memo
storeGet (Ident k) = do
  (s, ls, p) <- get
  l <- lift $ mapLookup ("variable " ++ k ++ " not declared") (Ident k) ls
  lift $ mapLookup ("value of variable " ++ k ++ " not defined (this should never happen - we always pass default values)") l s

evalAddOperator :: AddOp -> Memo -> Memo -> Result Memo
evalAddOperator Plus (IntMem x) (IntMem y) = return $ IntMem $ x + y
evalAddOperator Plus (StringMem x) (StringMem y) = return $ StringMem $ x ++ y
evalAddOperator Minus (IntMem x) (IntMem y) = return $ IntMem $ x - y
evalAddOperator op x y = operatorError (show op) x y

operatorError :: String -> Memo -> Memo -> Result Memo
operatorError disp x y = throwE $ "attempted to use " ++ disp ++ " on incompatible types: " ++ show x ++ " and " ++ show y

evalMulOperator :: MulOp -> Memo -> Memo -> Result Memo
evalMulOperator Times (IntMem x) (IntMem y) = return $ IntMem $ x * y
evalMulOperator Div (IntMem x) (IntMem 0) = throwE "division by zero attempt"
evalMulOperator Div (IntMem x) (IntMem y) = return $ IntMem $ div x y
evalMulOperator Mod (IntMem x) (IntMem 0) = throwE "modulo by zero attempt"
evalMulOperator Mod (IntMem x) (IntMem y) = return $ IntMem $ mod x y
evalMulOperator op x y = operatorError (show op) x y

relOperator :: Ord a => RelOp -> a -> a -> Bool
relOperator op =
  case op of
    LTH -> (<)
    LE -> (<=)
    GTH -> (>)
    GE -> (>=)
    EQU -> (==)
    NE -> (/=)

class Eval a where
  eval :: a -> QwertyExe Memo

runFuncLocal :: QwertyExe Memo -> QwertyExe Memo
runFuncLocal future = do
  (mem, oldLs, loc) <- get
  result <- future
  (newMem, _, newL) <- get
  put (newMem, oldLs, newL)
  return result

instance Eval Expr where
  eval (EVar identifier) = storeGet identifier
  eval (ELitInt integer) = return $ IntMem integer
  eval (ELambda argdecls block) = return $ FuncMem $
    \argdefs -> runFuncLocal $ do
        liftIO $ putStrLn "call lambda"
        -- TODO assign vars to args
        interpret block
  eval ELitTrue = return $ BoolMem True
  eval ELitFalse = return $ BoolMem False
  eval (EApp identifier arglist) = do
    FuncMem func <- storeGet identifier -- TODO TODO
    liftIO $ putStrLn $ "call func application" ++ show identifier
    runFuncLocal $ func arglist
  eval (EString s) = return $ StringMem s
  eval (Neg e) = do
    IntMem n <- eval e -- TODO TODO
    return $ IntMem $ negate n
  eval (Not e) = do
    BoolMem b <- eval e -- TODO TODO
    return $ BoolMem $ not b
  eval (EMul a op b) = do
    p <- eval a
    q <- eval b
    lift $ evalMulOperator op p q
  eval (EAdd a op b) = do
    p <- eval a
    q <- eval b
    lift $ evalAddOperator op p q
  eval (ERel a op b) = do
      x <- eval a
      y <- eval b
      case (x, y) of
        (StringMem p, StringMem q) -> return $ BoolMem $ (relOperator op) p q
        (IntMem p, IntMem q) -> return $ BoolMem $ (relOperator op) p q
        (BoolMem p, BoolMem q) -> return $ BoolMem $ (relOperator op) p q
        _ -> lift $ operatorError (show op) x y
  eval (EAnd a b) = do
    BoolMem p <- eval a -- TODO TODO
    BoolMem q <- eval b -- TODO TODO
    return $ BoolMem (p && q)
  eval (EOr a b) = do
    BoolMem p <- eval a -- TODO TODO
    BoolMem q <- eval b -- TODO TODO
    return $ BoolMem (p || q)

printer :: Func
printer es = do
  outs <- mapM eval es
  liftIO $ putStrLn $ unwords $ map show outs
  return VoidMem

matchFuncArg :: (Arg, Expr) -> QwertyExe Memo
matchFuncArg (FunArg t id, v) = do
  n <- eval v -- TODO low priority - dynamically typecheck because why not
  storePut id n

declare :: Memo -> Item -> QwertyExe Memo
declare defaultDef (NoInit i) = storePut i defaultDef
declare _ (Init i e) = do -- TODO what about type mismatch here?
  v <- eval e
  storePut i v

class Interpret a where
  interpret :: a -> QwertyExe Memo

instance Interpret Stmt where
  interpret Empty = return VoidMem
  interpret (BStmt b) = runFuncLocal $ interpret b
  interpret (Ass i e) = do
    v <- eval e
    storePut i v
  interpret (Ret e) = do
    st <- eval e
    liftIO exitSuccess
  interpret (Decl t isInitialized) =
    case t of
      TInt -> last <$> mapM (declare $ IntMem 0) isInitialized
      TStr -> last <$> mapM (declare (StringMem "")) isInitialized
      TBool -> last <$> mapM (declare (BoolMem False)) isInitialized
      TVoid -> last <$> mapM (declare VoidMem) isInitialized
      -- TFun argtypes rettype -> last <$> mapM (declare VoidMem) isInitialized
  interpret (Incr i) = do
    IntMem v <- storeGet i -- TODO TODO
    storePut i $ IntMem (v + 1)
  interpret (Decr i) = do
    IntMem v <- storeGet i -- TODO TODO
    storePut i $ IntMem (v - 1)
  interpret (Assert e) = do
    v <- eval e
    case v of
      BoolMem True -> return $ BoolMem True
      _ -> lift $ throwE "Assertion failure"
  interpret (SExp e) = eval e
  interpret (Cond e s) = interpret (CondElse e s Empty)
  interpret (CondElse e s1 s2) = do
    BoolMem v <- eval e -- TODO TODO
    runFuncLocal $ if v
      then interpret s1
      else interpret s2
  interpret (While e s) = do
    BoolMem v <- eval e -- TODO TODO
    if v
      then do runFuncLocal $ interpret s; interpret (While e s)
      else return $ BoolMem v

  interpret (NestFunc topdef) = interpret topdef
--   interpret (ConstDecl Type [Item]) =
--   interpret VRet = 
--   interpret Break = 
--   interpret Continue = 
--   interpret (For Ident Range Stmt) =
instance Interpret FnDef where
  interpret (TopDef t i (FunArgs a) b) =
    -- lift (putStrLn "udpap") >>
    storePut i $
    FuncMem $ \args -> runFuncLocal $ do
      mapM_ matchFuncArg $ zip a args
      interpret b

instance Interpret Block where
  interpret (ScopeBlock ss) = runFuncLocal $ last <$> mapM interpret ss

instance Interpret Program where
  interpret (MainProg defs) = do
    storePut (Ident "print") (FuncMem printer)
    mapM_ interpret defs
    FuncMem f <- storeGet $ Ident "main" -- TODO TODO
    result <- f []
    liftIO exitSuccess
      -- TODO prog statuses - code below but needs functions to return anything
      -- IntMem 0 -> liftIO exitSuccess
      -- IntMem n -> liftIO $ exitWith $ ExitFailure $ fromIntegral n
      -- _ -> liftIO $ exitWith $ ExitFailure (-42) -- TODO custom runtime error

startingState = (Map.empty, Map.empty, 0)

run :: QwertyExe Memo -> IO ()
run prog = do
  returnValue <- liftIO $ runExceptT $ runStateT prog startingState
  case returnValue of
    Right (IntMem 0, _) -> exitSuccess
    Right (IntMem n, _) -> ioError $ userError $ "Status " ++ show n ++ " returned from `main`"
    Left err -> ioError $ userError err
    _ -> ioError $ userError "wrong `main` function type"

parseFile :: String -> IO ()
parseFile file = do
  s <- readFile file
  let ts = myLexer s in
    case pProgram ts of
       Bad s -> do
         putStrLn "Parse failed\n"
        --  putStrLn "Tokens:"
        --  print ts
         putStrLn s
         exitFailure
       Ok tree -> do
         typecheck tree
         run $ interpret tree

main :: IO ()
main = do
  args <- getArgs
  prog <- getProgName
  case args of
    [] -> do
      putStrLn
        ("Interpreter mode not supported\nUsage: " ++ prog ++ " <program>")
      exitFailure
    [file] -> parseFile file
    files -> do
      putStrLn "Please provide only one file"
      exitFailure
