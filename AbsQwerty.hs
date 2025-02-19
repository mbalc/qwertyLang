-- Haskell data types for the abstract syntax.
-- Generated by the BNF converter.

module AbsQwerty where

newtype Ident = Ident String
  deriving (Eq, Ord, Show, Read)

data Program = MainProg [FnDef]
  deriving (Eq, Ord, Show, Read)

data FnDef = TopDef Type Ident Args Block
  deriving (Eq, Ord, Show, Read)

data Args = FunArgs [Arg]
  deriving (Eq, Ord, Show, Read)

data Arg = FunArg Type Ident
  deriving (Eq, Ord, Show, Read)

data Block = ScopeBlock [Stmt]
  deriving (Eq, Ord, Show, Read)

data Stmt
    = Empty
    | BStmt Block
    | NestFunc FnDef
    | Decl Type [Item]
    | Ass Ident Expr
    | Incr Ident
    | Decr Ident
    | Assert Expr
    | Ret Expr
    | VRet
    | Cond Expr Stmt
    | CondElse Expr Stmt Stmt
    | While Expr Stmt
    | SExp Expr
  deriving (Eq, Ord, Show, Read)

data Item = NoInit Ident | Init Ident Expr
  deriving (Eq, Ord, Show, Read)

data Type = TInt | TStr | TBool | TVoid | TFun [Type] Type
  deriving (Eq, Ord, Show, Read)

data Expr
    = EVar Ident
    | EApp Expr [Expr]
    | ELambda Args Block
    | ELitInt Integer
    | ELitTrue
    | ELitFalse
    | EString String
    | Neg Expr
    | Not Expr
    | EMul Expr MulOp Expr
    | EAdd Expr AddOp Expr
    | ERel Expr RelOp Expr
    | EAnd Expr Expr
    | EOr Expr Expr
  deriving (Eq, Ord, Show, Read)

data AddOp = Plus | Minus
  deriving (Eq, Ord, Show, Read)

data MulOp = Times | Div | Mod
  deriving (Eq, Ord, Show, Read)

data RelOp = LTH | LE | GTH | GE | EQU | NE
  deriving (Eq, Ord, Show, Read)

