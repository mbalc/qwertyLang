module Main where

import System.Environment (getArgs, getProgName)
import System.Exit (exitFailure, exitSuccess)

import qualified Data.Map as Map

import Control.Monad.Trans
import Control.Monad.Trans.Maybe
import Control.Monad.Trans.State

import AbsQwerty
import ParQwerty

import ErrM

type QwertyExe a = StateT AppStore IO a

type AppStore = (AppState, Locs, Loc)

type AppState = Map.Map Loc Memo

data Memo
  = IntMem Integer
  | BoolMem Bool
  | StringMem String
  | FuncMem Func
  | VoidMem -- TODO return types

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
typecheck p = print "ok (todo)"

push :: Ident -> Memo -> QwertyExe ()
push k v = do
  (m, ls, l) <- get
  put (Map.insert l v m, Map.insert k l ls, l + 1)

pull :: Ident -> QwertyExe Memo
pull t = do
  (s, ls, p) <- get
  let Just l = Map.lookup t ls
  let Just v = Map.lookup l s
  return v

addOperator :: AddOp -> Integer -> Integer -> Integer
addOperator op =
  case op of
    Plus -> (+)
    Minus -> (-)

mulOperator :: MulOp -> Integer -> Integer -> Integer
mulOperator op =
  case op of
    Times -> (*)
    Div -> quot
    Mod -> mod

relOperator :: RelOp -> Bool -> Bool -> Bool
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
  eval (EVar i) = pull i
        --   eval ELambda Lambda
  eval (ELitInt i) = return $ IntMem i
  eval ELitTrue = return $ BoolMem True
  eval ELitFalse = return $ BoolMem False
  eval (EApp i l) = do
    FuncMem f <- pull i
    f l
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
    BoolMem p <- eval a
    BoolMem q <- eval b
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
matchFuncArg (Arg t id, v) = do
  n <- eval v -- TODO low priority - dynamically typecheck because why not
  push id n

instance Interpret FnDef where
  interpret (FnDef t i (Args a) b) =
    push i $
    FuncMem $ \args -> do
      mapM_ matchFuncArg $ zip a args
      interpret b

instance Interpret Program where
  interpret (Program defs) = do
    push (Ident "print") (FuncMem printer)
    mapM_ interpret defs
    FuncMem f <- pull $ Ident "main"
    f []

run :: QwertyExe () -> IO ()
run prog = do
  runStateT prog (Map.empty, Map.empty, 0)
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
