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

type QwertyExe = StateT AppStore (ExceptT QwertyError IO)

type QwertyError = String

type AppStore = (AppState, Locs, Loc)

type AppState = Map.Map Loc Memo

data Memo
  = IntMem Integer
  | BoolMem Bool
  | StringMem String
  | FuncMem Func
  | VoidMem

type Func = [Expr] -> QwertyExe ()

type Locs = Map.Map Ident Loc

type Loc = Integer

instance Show Memo where
  show (IntMem i) = show i
  show (BoolMem b) = show b
  show (StringMem s) = show s
  show (FuncMem _) = show "func"
  show VoidMem = show "void"

typecheck :: Program -> IO ()
typecheck p = return () -- print "ok (todo)"

mapLookup :: Ord a => QwertyError -> a -> Map.Map a b -> ExceptT QwertyError IO b
mapLookup e k m = case Map.lookup k m of
    Just a -> return a
    Nothing -> throwE e

-- store modification
storePut :: Ident -> Memo -> QwertyExe ()
storePut k v = do
  (m, ls, l) <- get
  case Map.lookup k ls of
    Just l1 -> put (Map.insert l1 v m, ls, l)
    Nothing -> put (Map.insert l v m, Map.insert k l ls, l + 1)

storeGet :: Ident -> QwertyExe Memo
storeGet (Ident k) = do
  (s, ls, p) <- get
  l <- lift $ mapLookup ("variable " ++ k ++ " not declared") (Ident k) ls
  lift $ mapLookup "dupa2" l s

addOperator :: AddOp -> Integer -> Integer -> Integer
addOperator op =
  case op of
    Plus -> (+)
    Minus -> (-)

mulOperator :: MulOp -> Integer -> Integer -> Integer
mulOperator op =
  case op of
    Times -> (*)
    Div -> div
    Mod -> rem

relOperator :: RelOp -> Integer -> Integer -> Bool
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

instance Eval Expr where
  eval (EVar i) = storeGet i
        --   eval ELambda Lambda
  eval (ELitInt i) = return $ IntMem i
  eval ELitTrue = return $ BoolMem True
  eval ELitFalse = return $ BoolMem False
  eval (EApp i l) = do
    FuncMem f <- storeGet i
    (mem, oldLs, loc) <- get
    f l
    (newMem, _, newL) <- get
    put (newMem, oldLs, newL)
    return VoidMem
  eval (EString s) = return $ StringMem s
  eval (Neg e) = do
    IntMem n <- eval e
    return $ IntMem $ negate n
  eval (Not e) = do
    BoolMem b <- eval e
    return $ BoolMem $ not b
  eval (EMul a op b) = do
    IntMem p <- eval a
    IntMem q <- eval b
    return $ IntMem $ mulOperator op p q
  eval (EAdd a op b) = do
    IntMem p <- eval a
    IntMem q <- eval b
    return $ IntMem $ addOperator op p q
  eval (ERel a op b) = do
    IntMem p <- eval a
    IntMem q <- eval b
    return $ BoolMem $ relOperator op p q
  eval (EAnd a b) = do
    BoolMem p <- eval a
    BoolMem q <- eval b
    return $ BoolMem (p && q)
  eval (EOr a b) = do
    BoolMem p <- eval a
    BoolMem q <- eval b
    return $ BoolMem (p || q)

printer :: Func
printer es = do
  outs <- mapM eval es
  liftIO $ putStrLn $ concatMap show outs

class Interpret a where
  interpret :: a -> QwertyExe ()

matchFuncArg :: (Arg, Expr) -> QwertyExe ()
matchFuncArg (FunArg t id, v) = do
  n <- eval v -- TODO low priority - dynamically typecheck because why not
  storePut id n

declare :: Memo -> Item -> QwertyExe ()
declare def (NoInit i) = storePut i def
declare _ (Init i e) = do
  v <- eval e
  storePut i v

instance Interpret Stmt where
  interpret Empty = return ()
  interpret (BStmt b) = interpret b
  interpret (Ass i e) = do
    v <- eval e
    storePut i v
  interpret (Ret e) = do
    st <- eval e
    liftIO exitSuccess
  interpret (Decl t is) =
    case t of
      TInt -> mapM_ (declare $ IntMem 0) is
      TStr -> mapM_ (declare (StringMem "")) is
      TBool -> mapM_ (declare (BoolMem False)) is
      TVoid -> mapM_ (declare VoidMem) is
  interpret (Incr i) = do
    IntMem v <- storeGet i
    storePut i $ IntMem (v + 1)
  interpret (Decr i) = do
    IntMem v <- storeGet i
    storePut i $ IntMem (v - 1)
  interpret (SExp e) = do
    eval e
    return ()
  interpret (Cond e s) = interpret (CondElse e s Empty)
  interpret (CondElse e s1 s2) = do
    BoolMem v <- eval e
    (mem, oldLs, l) <- get
    if v
      then interpret s1
      else interpret s2
    (newMem, _, newL) <- get
    put (newMem, oldLs, newL)
  interpret (While e s) = do
    BoolMem v <- eval e
    (mem, oldLs, l) <- get
    if v then do
      interpret s
      (newMem, _, newL) <- get
      put (newMem, oldLs, newL)
      interpret (While e s)
    else do
      (newMem, _, newL) <- get
      put (newMem, oldLs, newL)

--   interpret (NestFunc FnDef) =
--   interpret (ConstDecl Type [Item]) =
--   interpret VRet = 
--   interpret Break = 
--   interpret Continue = 
--   interpret (For Ident Range Stmt) =
instance Interpret FnDef where
  interpret (TopDef t i (FunArgs a) b) =
    storePut i $
    FuncMem $ \args -> do
      mapM_ matchFuncArg $ zip a args
      interpret b

instance Interpret Block where
  interpret (ScopeBlock ss) = do
    (mem, oldLs, l) <- get
    mapM_ interpret ss
    (newMem, _, newL) <- get
    put (newMem, oldLs, newL)

instance Interpret Program where
  interpret (MainProg defs) = do
    storePut (Ident "print") (FuncMem printer)
    mapM_ interpret defs
    FuncMem f <- storeGet $ Ident "main"
    result <- f []
    liftIO exitSuccess
      -- TODO prog statuses - code below but needs functions to return anything
      -- IntMem 0 -> liftIO exitSuccess
      -- IntMem n -> liftIO $ exitWith $ ExitFailure $ fromIntegral n
      -- _ -> liftIO $ exitWith $ ExitFailure (-42) -- TODO custom runtime error

startingState () = (Map.empty, Map.empty, 0)

run :: QwertyExe () -> IO ()
run prog = do
  runExceptT $ runStateT prog (startingState ())
  exitSuccess

parseFile :: String -> IO ()
parseFile file = do
  s <- readFile file
  let ts = myLexer s in
    case pProgram ts of
       Bad s -> do
         putStrLn "\nParse              Failed...\n"
         putStrLn "Tokens:"
         print ts
         putStrLn s
         exitFailure
       Ok tree -> do
         typecheck tree
         run $ interpret tree
         exitSuccess

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
