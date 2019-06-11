{-# OPTIONS_GHC -w #-}
{-# OPTIONS_GHC -fno-warn-incomplete-patterns -fno-warn-overlapping-patterns #-}
module ParQwerty where
import AbsQwerty
import LexQwerty
import ErrM
import qualified Data.Array as Happy_Data_Array
import qualified Data.Bits as Bits
import Control.Applicative(Applicative(..))
import Control.Monad (ap)

-- parser produced by Happy Version 1.19.9

data HappyAbsSyn 
	= HappyTerminal (Token)
	| HappyErrorToken Int
	| HappyAbsSyn4 (Ident)
	| HappyAbsSyn5 (Integer)
	| HappyAbsSyn6 (String)
	| HappyAbsSyn7 (Program)
	| HappyAbsSyn8 (FnDef)
	| HappyAbsSyn9 (Args)
	| HappyAbsSyn10 ([FnDef])
	| HappyAbsSyn11 (Arg)
	| HappyAbsSyn12 ([Arg])
	| HappyAbsSyn13 (Block)
	| HappyAbsSyn14 ([Stmt])
	| HappyAbsSyn15 (Stmt)
	| HappyAbsSyn16 (Item)
	| HappyAbsSyn17 ([Item])
	| HappyAbsSyn18 (Type)
	| HappyAbsSyn19 ([Type])
	| HappyAbsSyn20 (Expr)
	| HappyAbsSyn28 ([Expr])
	| HappyAbsSyn29 (AddOp)
	| HappyAbsSyn30 (MulOp)
	| HappyAbsSyn31 (RelOp)

{- to allow type-synonyms as our monads (likely
 - with explicitly-specified bind and return)
 - in Haskell98, it seems that with
 - /type M a = .../, then /(HappyReduction M)/
 - is not allowed.  But Happy is a
 - code-generator that can just substitute it.
type HappyReduction m = 
	   Int 
	-> (Token)
	-> HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> m HappyAbsSyn)
	-> [HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> m HappyAbsSyn)] 
	-> HappyStk HappyAbsSyn 
	-> [(Token)] -> m HappyAbsSyn
-}

action_0,
 action_1,
 action_2,
 action_3,
 action_4,
 action_5,
 action_6,
 action_7,
 action_8,
 action_9,
 action_10,
 action_11,
 action_12,
 action_13,
 action_14,
 action_15,
 action_16,
 action_17,
 action_18,
 action_19,
 action_20,
 action_21,
 action_22,
 action_23,
 action_24,
 action_25,
 action_26,
 action_27,
 action_28,
 action_29,
 action_30,
 action_31,
 action_32,
 action_33,
 action_34,
 action_35,
 action_36,
 action_37,
 action_38,
 action_39,
 action_40,
 action_41,
 action_42,
 action_43,
 action_44,
 action_45,
 action_46,
 action_47,
 action_48,
 action_49,
 action_50,
 action_51,
 action_52,
 action_53,
 action_54,
 action_55,
 action_56,
 action_57,
 action_58,
 action_59,
 action_60,
 action_61,
 action_62,
 action_63,
 action_64,
 action_65,
 action_66,
 action_67,
 action_68,
 action_69,
 action_70,
 action_71,
 action_72,
 action_73,
 action_74,
 action_75,
 action_76,
 action_77,
 action_78,
 action_79,
 action_80,
 action_81,
 action_82,
 action_83,
 action_84,
 action_85,
 action_86,
 action_87,
 action_88,
 action_89,
 action_90,
 action_91,
 action_92,
 action_93,
 action_94,
 action_95,
 action_96,
 action_97,
 action_98,
 action_99,
 action_100,
 action_101,
 action_102,
 action_103,
 action_104,
 action_105,
 action_106,
 action_107,
 action_108,
 action_109,
 action_110,
 action_111,
 action_112,
 action_113,
 action_114,
 action_115,
 action_116,
 action_117,
 action_118,
 action_119,
 action_120,
 action_121,
 action_122,
 action_123,
 action_124,
 action_125,
 action_126,
 action_127,
 action_128 :: () => Int -> ({-HappyReduction (Err) = -}
	   Int 
	-> (Token)
	-> HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> (Err) HappyAbsSyn)
	-> [HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> (Err) HappyAbsSyn)] 
	-> HappyStk HappyAbsSyn 
	-> [(Token)] -> (Err) HappyAbsSyn)

happyReduce_1,
 happyReduce_2,
 happyReduce_3,
 happyReduce_4,
 happyReduce_5,
 happyReduce_6,
 happyReduce_7,
 happyReduce_8,
 happyReduce_9,
 happyReduce_10,
 happyReduce_11,
 happyReduce_12,
 happyReduce_13,
 happyReduce_14,
 happyReduce_15,
 happyReduce_16,
 happyReduce_17,
 happyReduce_18,
 happyReduce_19,
 happyReduce_20,
 happyReduce_21,
 happyReduce_22,
 happyReduce_23,
 happyReduce_24,
 happyReduce_25,
 happyReduce_26,
 happyReduce_27,
 happyReduce_28,
 happyReduce_29,
 happyReduce_30,
 happyReduce_31,
 happyReduce_32,
 happyReduce_33,
 happyReduce_34,
 happyReduce_35,
 happyReduce_36,
 happyReduce_37,
 happyReduce_38,
 happyReduce_39,
 happyReduce_40,
 happyReduce_41,
 happyReduce_42,
 happyReduce_43,
 happyReduce_44,
 happyReduce_45,
 happyReduce_46,
 happyReduce_47,
 happyReduce_48,
 happyReduce_49,
 happyReduce_50,
 happyReduce_51,
 happyReduce_52,
 happyReduce_53,
 happyReduce_54,
 happyReduce_55,
 happyReduce_56,
 happyReduce_57,
 happyReduce_58,
 happyReduce_59,
 happyReduce_60,
 happyReduce_61,
 happyReduce_62,
 happyReduce_63,
 happyReduce_64,
 happyReduce_65,
 happyReduce_66,
 happyReduce_67,
 happyReduce_68,
 happyReduce_69,
 happyReduce_70,
 happyReduce_71,
 happyReduce_72,
 happyReduce_73,
 happyReduce_74,
 happyReduce_75,
 happyReduce_76,
 happyReduce_77 :: () => ({-HappyReduction (Err) = -}
	   Int 
	-> (Token)
	-> HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> (Err) HappyAbsSyn)
	-> [HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> (Err) HappyAbsSyn)] 
	-> HappyStk HappyAbsSyn 
	-> [(Token)] -> (Err) HappyAbsSyn)

happyExpList :: Happy_Data_Array.Array Int Int
happyExpList = Happy_Data_Array.listArray (0,480) ([0,0,16,21568,0,0,0,0,1024,0,0,0,0,0,0,0,0,0,0,0,1,1348,0,0,0,0,0,0,0,0,8192,0,0,32,43136,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8192,0,0,0,0,1,0,0,0,32,0,0,0,0,0,0,0,0,0,0,1,0,2048,8192,42,0,0,0,1,0,0,512,34816,10,0,0,0,0,0,0,128,41472,2,0,0,8,0,0,0,64,0,0,0,0,0,2048,0,0,0,0,0,0,0,0,0,0,4096,1155,49132,7,0,0,0,0,0,0,0,0,0,0,64,20736,1,0,16384,0,0,0,0,0,0,0,0,0,0,0,0,0,16960,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4096,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4,0,512,0,0,0,0,0,0,0,0,0,0,0,0,4096,130,0,0,0,4608,0,0,0,2560,13696,0,0,0,0,0,2,0,0,16,0,0,0,2,2112,14,0,33552,43008,1806,0,32768,0,33296,3,0,0,0,0,0,8704,16,57476,0,0,0,0,0,0,2048,0,0,0,16384,4612,4224,28,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4352,8,28738,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,33040,8192,1796,0,0,512,0,0,0,0,0,0,0,32768,0,0,0,0,0,0,0,0,0,0,0,0,16384,516,4224,28,0,544,16385,3592,0,0,0,0,0,0,16520,4096,898,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8192,258,2112,14,0,0,0,0,0,0,0,0,0,0,8260,2048,449,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16384,516,4224,28,0,512,64,0,0,0,64,0,0,0,0,2,0,0,0,0,2048,0,0,32768,0,0,0,0,64,0,0,32768,1032,8448,56,0,0,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8192,0,0,2065,16896,112,0,0,2,0,0,0,16,0,0,0,0,0,0,0,16384,520,0,0,0,0,0,0,0,0,36,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4096,0,0,0,0,0,0,0,0,1024,0,0,0,34816,577,40950,3,0,8388,64257,463,0,0,0,0,0,0,2065,16896,112,0,0,0,0,0,0,32768,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,12544,49224,29694,0,0,0,0,0,0
	])

{-# NOINLINE happyExpListPerState #-}
happyExpListPerState st =
    token_strs_expected
  where token_strs = ["error","%dummy","%start_pProgram","Ident","Integer","String","Program","FnDef","Args","ListFnDef","Arg","ListArg","Block","ListStmt","Stmt","Item","ListItem","Type","ListType","Expr7","Expr6","Expr5","Expr4","Expr3","Expr2","Expr1","Expr","ListExpr","AddOp","MulOp","RelOp","'!'","'!='","'%'","'&&'","'('","'(('","')'","'*'","'+'","'++'","','","'-'","'--'","'/'","';'","'<'","'<='","'='","'=='","'=>'","'>'","'>='","'assert'","'boolean'","'else'","'false'","'if'","'int'","'return'","'string'","'true'","'void'","'while'","'{'","'||'","'}'","L_ident","L_integ","L_quoted","%eof"]
        bit_start = st * 71
        bit_end = (st + 1) * 71
        read_bit = readArrayBit happyExpList
        bits = map read_bit [bit_start..bit_end - 1]
        bits_indexed = zip bits [0..70]
        token_strs_expected = concatMap f bits_indexed
        f (False, _) = []
        f (True, nr) = [token_strs !! nr]

action_0 (37) = happyShift action_7
action_0 (55) = happyShift action_8
action_0 (59) = happyShift action_9
action_0 (61) = happyShift action_10
action_0 (63) = happyShift action_11
action_0 (7) = happyGoto action_3
action_0 (8) = happyGoto action_4
action_0 (10) = happyGoto action_5
action_0 (18) = happyGoto action_6
action_0 _ = happyFail (happyExpListPerState 0)

action_1 (68) = happyShift action_2
action_1 _ = happyFail (happyExpListPerState 1)

action_2 _ = happyReduce_1

action_3 (71) = happyAccept
action_3 _ = happyFail (happyExpListPerState 3)

action_4 (37) = happyShift action_7
action_4 (55) = happyShift action_8
action_4 (59) = happyShift action_9
action_4 (61) = happyShift action_10
action_4 (63) = happyShift action_11
action_4 (8) = happyGoto action_4
action_4 (10) = happyGoto action_15
action_4 (18) = happyGoto action_6
action_4 _ = happyReduce_7

action_5 _ = happyReduce_4

action_6 (68) = happyShift action_2
action_6 (4) = happyGoto action_14
action_6 _ = happyFail (happyExpListPerState 6)

action_7 (37) = happyShift action_7
action_7 (55) = happyShift action_8
action_7 (59) = happyShift action_9
action_7 (61) = happyShift action_10
action_7 (63) = happyShift action_11
action_7 (18) = happyGoto action_12
action_7 (19) = happyGoto action_13
action_7 _ = happyReduce_39

action_8 _ = happyReduce_36

action_9 _ = happyReduce_34

action_10 _ = happyReduce_35

action_11 _ = happyReduce_37

action_12 (42) = happyShift action_19
action_12 _ = happyReduce_40

action_13 (38) = happyShift action_18
action_13 _ = happyFail (happyExpListPerState 13)

action_14 (36) = happyShift action_17
action_14 (9) = happyGoto action_16
action_14 _ = happyFail (happyExpListPerState 14)

action_15 _ = happyReduce_8

action_16 (65) = happyShift action_26
action_16 (13) = happyGoto action_25
action_16 _ = happyFail (happyExpListPerState 16)

action_17 (37) = happyShift action_7
action_17 (55) = happyShift action_8
action_17 (59) = happyShift action_9
action_17 (61) = happyShift action_10
action_17 (63) = happyShift action_11
action_17 (11) = happyGoto action_22
action_17 (12) = happyGoto action_23
action_17 (18) = happyGoto action_24
action_17 _ = happyReduce_10

action_18 (51) = happyShift action_21
action_18 _ = happyFail (happyExpListPerState 18)

action_19 (37) = happyShift action_7
action_19 (55) = happyShift action_8
action_19 (59) = happyShift action_9
action_19 (61) = happyShift action_10
action_19 (63) = happyShift action_11
action_19 (18) = happyGoto action_12
action_19 (19) = happyGoto action_20
action_19 _ = happyReduce_39

action_20 _ = happyReduce_41

action_21 (37) = happyShift action_7
action_21 (55) = happyShift action_8
action_21 (59) = happyShift action_9
action_21 (61) = happyShift action_10
action_21 (63) = happyShift action_11
action_21 (18) = happyGoto action_31
action_21 _ = happyFail (happyExpListPerState 21)

action_22 (42) = happyShift action_30
action_22 _ = happyReduce_11

action_23 (38) = happyShift action_29
action_23 _ = happyFail (happyExpListPerState 23)

action_24 (68) = happyShift action_2
action_24 (4) = happyGoto action_28
action_24 _ = happyFail (happyExpListPerState 24)

action_25 _ = happyReduce_5

action_26 (14) = happyGoto action_27
action_26 _ = happyReduce_14

action_27 (32) = happyShift action_50
action_27 (36) = happyShift action_51
action_27 (37) = happyShift action_7
action_27 (43) = happyShift action_52
action_27 (46) = happyShift action_53
action_27 (54) = happyShift action_54
action_27 (55) = happyShift action_8
action_27 (57) = happyShift action_55
action_27 (58) = happyShift action_56
action_27 (59) = happyShift action_9
action_27 (60) = happyShift action_57
action_27 (61) = happyShift action_10
action_27 (62) = happyShift action_58
action_27 (63) = happyShift action_11
action_27 (64) = happyShift action_59
action_27 (65) = happyShift action_26
action_27 (67) = happyShift action_60
action_27 (68) = happyShift action_2
action_27 (69) = happyShift action_61
action_27 (70) = happyShift action_62
action_27 (4) = happyGoto action_34
action_27 (5) = happyGoto action_35
action_27 (6) = happyGoto action_36
action_27 (8) = happyGoto action_37
action_27 (9) = happyGoto action_38
action_27 (13) = happyGoto action_39
action_27 (15) = happyGoto action_40
action_27 (18) = happyGoto action_41
action_27 (20) = happyGoto action_42
action_27 (21) = happyGoto action_43
action_27 (22) = happyGoto action_44
action_27 (23) = happyGoto action_45
action_27 (24) = happyGoto action_46
action_27 (25) = happyGoto action_47
action_27 (26) = happyGoto action_48
action_27 (27) = happyGoto action_49
action_27 _ = happyFail (happyExpListPerState 27)

action_28 _ = happyReduce_9

action_29 _ = happyReduce_6

action_30 (37) = happyShift action_7
action_30 (55) = happyShift action_8
action_30 (59) = happyShift action_9
action_30 (61) = happyShift action_10
action_30 (63) = happyShift action_11
action_30 (11) = happyGoto action_22
action_30 (12) = happyGoto action_33
action_30 (18) = happyGoto action_24
action_30 _ = happyReduce_10

action_31 (38) = happyShift action_32
action_31 _ = happyFail (happyExpListPerState 31)

action_32 _ = happyReduce_38

action_33 _ = happyReduce_12

action_34 (41) = happyShift action_94
action_34 (44) = happyShift action_95
action_34 (49) = happyShift action_96
action_34 _ = happyReduce_42

action_35 _ = happyReduce_46

action_36 _ = happyReduce_49

action_37 _ = happyReduce_18

action_38 (51) = happyShift action_93
action_38 _ = happyFail (happyExpListPerState 38)

action_39 _ = happyReduce_17

action_40 _ = happyReduce_15

action_41 (68) = happyShift action_2
action_41 (4) = happyGoto action_90
action_41 (16) = happyGoto action_91
action_41 (17) = happyGoto action_92
action_41 _ = happyFail (happyExpListPerState 41)

action_42 (36) = happyShift action_89
action_42 _ = happyReduce_50

action_43 _ = happyReduce_53

action_44 _ = happyReduce_55

action_45 (34) = happyShift action_86
action_45 (39) = happyShift action_87
action_45 (45) = happyShift action_88
action_45 (30) = happyGoto action_85
action_45 _ = happyReduce_57

action_46 (40) = happyShift action_83
action_46 (43) = happyShift action_84
action_46 (29) = happyGoto action_82
action_46 _ = happyReduce_59

action_47 (33) = happyShift action_75
action_47 (35) = happyShift action_76
action_47 (47) = happyShift action_77
action_47 (48) = happyShift action_78
action_47 (50) = happyShift action_79
action_47 (52) = happyShift action_80
action_47 (53) = happyShift action_81
action_47 (31) = happyGoto action_74
action_47 _ = happyReduce_61

action_48 (66) = happyShift action_73
action_48 _ = happyReduce_63

action_49 (46) = happyShift action_72
action_49 _ = happyFail (happyExpListPerState 49)

action_50 (36) = happyShift action_51
action_50 (57) = happyShift action_55
action_50 (62) = happyShift action_58
action_50 (68) = happyShift action_2
action_50 (69) = happyShift action_61
action_50 (70) = happyShift action_62
action_50 (4) = happyGoto action_64
action_50 (5) = happyGoto action_35
action_50 (6) = happyGoto action_36
action_50 (9) = happyGoto action_38
action_50 (20) = happyGoto action_42
action_50 (21) = happyGoto action_71
action_50 _ = happyFail (happyExpListPerState 50)

action_51 (32) = happyShift action_50
action_51 (36) = happyShift action_51
action_51 (37) = happyShift action_7
action_51 (43) = happyShift action_52
action_51 (55) = happyShift action_8
action_51 (57) = happyShift action_55
action_51 (59) = happyShift action_9
action_51 (61) = happyShift action_10
action_51 (62) = happyShift action_58
action_51 (63) = happyShift action_11
action_51 (68) = happyShift action_2
action_51 (69) = happyShift action_61
action_51 (70) = happyShift action_62
action_51 (4) = happyGoto action_64
action_51 (5) = happyGoto action_35
action_51 (6) = happyGoto action_36
action_51 (9) = happyGoto action_38
action_51 (11) = happyGoto action_22
action_51 (12) = happyGoto action_23
action_51 (18) = happyGoto action_24
action_51 (20) = happyGoto action_42
action_51 (21) = happyGoto action_43
action_51 (22) = happyGoto action_44
action_51 (23) = happyGoto action_45
action_51 (24) = happyGoto action_46
action_51 (25) = happyGoto action_47
action_51 (26) = happyGoto action_48
action_51 (27) = happyGoto action_70
action_51 _ = happyReduce_10

action_52 (36) = happyShift action_51
action_52 (57) = happyShift action_55
action_52 (62) = happyShift action_58
action_52 (68) = happyShift action_2
action_52 (69) = happyShift action_61
action_52 (70) = happyShift action_62
action_52 (4) = happyGoto action_64
action_52 (5) = happyGoto action_35
action_52 (6) = happyGoto action_36
action_52 (9) = happyGoto action_38
action_52 (20) = happyGoto action_42
action_52 (21) = happyGoto action_69
action_52 _ = happyFail (happyExpListPerState 52)

action_53 _ = happyReduce_16

action_54 (32) = happyShift action_50
action_54 (36) = happyShift action_51
action_54 (43) = happyShift action_52
action_54 (57) = happyShift action_55
action_54 (62) = happyShift action_58
action_54 (68) = happyShift action_2
action_54 (69) = happyShift action_61
action_54 (70) = happyShift action_62
action_54 (4) = happyGoto action_64
action_54 (5) = happyGoto action_35
action_54 (6) = happyGoto action_36
action_54 (9) = happyGoto action_38
action_54 (20) = happyGoto action_42
action_54 (21) = happyGoto action_43
action_54 (22) = happyGoto action_44
action_54 (23) = happyGoto action_45
action_54 (24) = happyGoto action_46
action_54 (25) = happyGoto action_47
action_54 (26) = happyGoto action_48
action_54 (27) = happyGoto action_68
action_54 _ = happyFail (happyExpListPerState 54)

action_55 _ = happyReduce_48

action_56 (36) = happyShift action_67
action_56 _ = happyFail (happyExpListPerState 56)

action_57 (32) = happyShift action_50
action_57 (36) = happyShift action_51
action_57 (43) = happyShift action_52
action_57 (46) = happyShift action_66
action_57 (57) = happyShift action_55
action_57 (62) = happyShift action_58
action_57 (68) = happyShift action_2
action_57 (69) = happyShift action_61
action_57 (70) = happyShift action_62
action_57 (4) = happyGoto action_64
action_57 (5) = happyGoto action_35
action_57 (6) = happyGoto action_36
action_57 (9) = happyGoto action_38
action_57 (20) = happyGoto action_42
action_57 (21) = happyGoto action_43
action_57 (22) = happyGoto action_44
action_57 (23) = happyGoto action_45
action_57 (24) = happyGoto action_46
action_57 (25) = happyGoto action_47
action_57 (26) = happyGoto action_48
action_57 (27) = happyGoto action_65
action_57 _ = happyFail (happyExpListPerState 57)

action_58 _ = happyReduce_47

action_59 (36) = happyShift action_63
action_59 _ = happyFail (happyExpListPerState 59)

action_60 _ = happyReduce_13

action_61 _ = happyReduce_2

action_62 _ = happyReduce_3

action_63 (32) = happyShift action_50
action_63 (36) = happyShift action_51
action_63 (43) = happyShift action_52
action_63 (57) = happyShift action_55
action_63 (62) = happyShift action_58
action_63 (68) = happyShift action_2
action_63 (69) = happyShift action_61
action_63 (70) = happyShift action_62
action_63 (4) = happyGoto action_64
action_63 (5) = happyGoto action_35
action_63 (6) = happyGoto action_36
action_63 (9) = happyGoto action_38
action_63 (20) = happyGoto action_42
action_63 (21) = happyGoto action_43
action_63 (22) = happyGoto action_44
action_63 (23) = happyGoto action_45
action_63 (24) = happyGoto action_46
action_63 (25) = happyGoto action_47
action_63 (26) = happyGoto action_48
action_63 (27) = happyGoto action_115
action_63 _ = happyFail (happyExpListPerState 63)

action_64 _ = happyReduce_42

action_65 (46) = happyShift action_114
action_65 _ = happyFail (happyExpListPerState 65)

action_66 _ = happyReduce_25

action_67 (32) = happyShift action_50
action_67 (36) = happyShift action_51
action_67 (43) = happyShift action_52
action_67 (57) = happyShift action_55
action_67 (62) = happyShift action_58
action_67 (68) = happyShift action_2
action_67 (69) = happyShift action_61
action_67 (70) = happyShift action_62
action_67 (4) = happyGoto action_64
action_67 (5) = happyGoto action_35
action_67 (6) = happyGoto action_36
action_67 (9) = happyGoto action_38
action_67 (20) = happyGoto action_42
action_67 (21) = happyGoto action_43
action_67 (22) = happyGoto action_44
action_67 (23) = happyGoto action_45
action_67 (24) = happyGoto action_46
action_67 (25) = happyGoto action_47
action_67 (26) = happyGoto action_48
action_67 (27) = happyGoto action_113
action_67 _ = happyFail (happyExpListPerState 67)

action_68 (46) = happyShift action_112
action_68 _ = happyFail (happyExpListPerState 68)

action_69 _ = happyReduce_51

action_70 (38) = happyShift action_111
action_70 _ = happyFail (happyExpListPerState 70)

action_71 _ = happyReduce_52

action_72 _ = happyReduce_29

action_73 (32) = happyShift action_50
action_73 (36) = happyShift action_51
action_73 (43) = happyShift action_52
action_73 (57) = happyShift action_55
action_73 (62) = happyShift action_58
action_73 (68) = happyShift action_2
action_73 (69) = happyShift action_61
action_73 (70) = happyShift action_62
action_73 (4) = happyGoto action_64
action_73 (5) = happyGoto action_35
action_73 (6) = happyGoto action_36
action_73 (9) = happyGoto action_38
action_73 (20) = happyGoto action_42
action_73 (21) = happyGoto action_43
action_73 (22) = happyGoto action_44
action_73 (23) = happyGoto action_45
action_73 (24) = happyGoto action_46
action_73 (25) = happyGoto action_47
action_73 (26) = happyGoto action_48
action_73 (27) = happyGoto action_110
action_73 _ = happyFail (happyExpListPerState 73)

action_74 (32) = happyShift action_50
action_74 (36) = happyShift action_51
action_74 (43) = happyShift action_52
action_74 (57) = happyShift action_55
action_74 (62) = happyShift action_58
action_74 (68) = happyShift action_2
action_74 (69) = happyShift action_61
action_74 (70) = happyShift action_62
action_74 (4) = happyGoto action_64
action_74 (5) = happyGoto action_35
action_74 (6) = happyGoto action_36
action_74 (9) = happyGoto action_38
action_74 (20) = happyGoto action_42
action_74 (21) = happyGoto action_43
action_74 (22) = happyGoto action_44
action_74 (23) = happyGoto action_45
action_74 (24) = happyGoto action_109
action_74 _ = happyFail (happyExpListPerState 74)

action_75 _ = happyReduce_77

action_76 (32) = happyShift action_50
action_76 (36) = happyShift action_51
action_76 (43) = happyShift action_52
action_76 (57) = happyShift action_55
action_76 (62) = happyShift action_58
action_76 (68) = happyShift action_2
action_76 (69) = happyShift action_61
action_76 (70) = happyShift action_62
action_76 (4) = happyGoto action_64
action_76 (5) = happyGoto action_35
action_76 (6) = happyGoto action_36
action_76 (9) = happyGoto action_38
action_76 (20) = happyGoto action_42
action_76 (21) = happyGoto action_43
action_76 (22) = happyGoto action_44
action_76 (23) = happyGoto action_45
action_76 (24) = happyGoto action_46
action_76 (25) = happyGoto action_47
action_76 (26) = happyGoto action_108
action_76 _ = happyFail (happyExpListPerState 76)

action_77 _ = happyReduce_72

action_78 _ = happyReduce_73

action_79 _ = happyReduce_76

action_80 _ = happyReduce_74

action_81 _ = happyReduce_75

action_82 (32) = happyShift action_50
action_82 (36) = happyShift action_51
action_82 (43) = happyShift action_52
action_82 (57) = happyShift action_55
action_82 (62) = happyShift action_58
action_82 (68) = happyShift action_2
action_82 (69) = happyShift action_61
action_82 (70) = happyShift action_62
action_82 (4) = happyGoto action_64
action_82 (5) = happyGoto action_35
action_82 (6) = happyGoto action_36
action_82 (9) = happyGoto action_38
action_82 (20) = happyGoto action_42
action_82 (21) = happyGoto action_43
action_82 (22) = happyGoto action_44
action_82 (23) = happyGoto action_107
action_82 _ = happyFail (happyExpListPerState 82)

action_83 _ = happyReduce_67

action_84 _ = happyReduce_68

action_85 (32) = happyShift action_50
action_85 (36) = happyShift action_51
action_85 (43) = happyShift action_52
action_85 (57) = happyShift action_55
action_85 (62) = happyShift action_58
action_85 (68) = happyShift action_2
action_85 (69) = happyShift action_61
action_85 (70) = happyShift action_62
action_85 (4) = happyGoto action_64
action_85 (5) = happyGoto action_35
action_85 (6) = happyGoto action_36
action_85 (9) = happyGoto action_38
action_85 (20) = happyGoto action_42
action_85 (21) = happyGoto action_43
action_85 (22) = happyGoto action_106
action_85 _ = happyFail (happyExpListPerState 85)

action_86 _ = happyReduce_71

action_87 _ = happyReduce_69

action_88 _ = happyReduce_70

action_89 (32) = happyShift action_50
action_89 (36) = happyShift action_51
action_89 (43) = happyShift action_52
action_89 (57) = happyShift action_55
action_89 (62) = happyShift action_58
action_89 (68) = happyShift action_2
action_89 (69) = happyShift action_61
action_89 (70) = happyShift action_62
action_89 (4) = happyGoto action_64
action_89 (5) = happyGoto action_35
action_89 (6) = happyGoto action_36
action_89 (9) = happyGoto action_38
action_89 (20) = happyGoto action_42
action_89 (21) = happyGoto action_43
action_89 (22) = happyGoto action_44
action_89 (23) = happyGoto action_45
action_89 (24) = happyGoto action_46
action_89 (25) = happyGoto action_47
action_89 (26) = happyGoto action_48
action_89 (27) = happyGoto action_104
action_89 (28) = happyGoto action_105
action_89 _ = happyReduce_64

action_90 (36) = happyShift action_17
action_90 (49) = happyShift action_103
action_90 (9) = happyGoto action_16
action_90 _ = happyReduce_30

action_91 (42) = happyShift action_102
action_91 _ = happyReduce_32

action_92 (46) = happyShift action_101
action_92 _ = happyFail (happyExpListPerState 92)

action_93 (65) = happyShift action_26
action_93 (13) = happyGoto action_100
action_93 _ = happyFail (happyExpListPerState 93)

action_94 (46) = happyShift action_99
action_94 _ = happyFail (happyExpListPerState 94)

action_95 (46) = happyShift action_98
action_95 _ = happyFail (happyExpListPerState 95)

action_96 (32) = happyShift action_50
action_96 (36) = happyShift action_51
action_96 (43) = happyShift action_52
action_96 (57) = happyShift action_55
action_96 (62) = happyShift action_58
action_96 (68) = happyShift action_2
action_96 (69) = happyShift action_61
action_96 (70) = happyShift action_62
action_96 (4) = happyGoto action_64
action_96 (5) = happyGoto action_35
action_96 (6) = happyGoto action_36
action_96 (9) = happyGoto action_38
action_96 (20) = happyGoto action_42
action_96 (21) = happyGoto action_43
action_96 (22) = happyGoto action_44
action_96 (23) = happyGoto action_45
action_96 (24) = happyGoto action_46
action_96 (25) = happyGoto action_47
action_96 (26) = happyGoto action_48
action_96 (27) = happyGoto action_97
action_96 _ = happyFail (happyExpListPerState 96)

action_97 (46) = happyShift action_123
action_97 _ = happyFail (happyExpListPerState 97)

action_98 _ = happyReduce_22

action_99 _ = happyReduce_21

action_100 _ = happyReduce_45

action_101 _ = happyReduce_19

action_102 (68) = happyShift action_2
action_102 (4) = happyGoto action_121
action_102 (16) = happyGoto action_91
action_102 (17) = happyGoto action_122
action_102 _ = happyFail (happyExpListPerState 102)

action_103 (32) = happyShift action_50
action_103 (36) = happyShift action_51
action_103 (43) = happyShift action_52
action_103 (57) = happyShift action_55
action_103 (62) = happyShift action_58
action_103 (68) = happyShift action_2
action_103 (69) = happyShift action_61
action_103 (70) = happyShift action_62
action_103 (4) = happyGoto action_64
action_103 (5) = happyGoto action_35
action_103 (6) = happyGoto action_36
action_103 (9) = happyGoto action_38
action_103 (20) = happyGoto action_42
action_103 (21) = happyGoto action_43
action_103 (22) = happyGoto action_44
action_103 (23) = happyGoto action_45
action_103 (24) = happyGoto action_46
action_103 (25) = happyGoto action_47
action_103 (26) = happyGoto action_48
action_103 (27) = happyGoto action_120
action_103 _ = happyFail (happyExpListPerState 103)

action_104 (42) = happyShift action_119
action_104 _ = happyReduce_65

action_105 (38) = happyShift action_118
action_105 _ = happyFail (happyExpListPerState 105)

action_106 _ = happyReduce_54

action_107 (34) = happyShift action_86
action_107 (39) = happyShift action_87
action_107 (45) = happyShift action_88
action_107 (30) = happyGoto action_85
action_107 _ = happyReduce_56

action_108 _ = happyReduce_60

action_109 (40) = happyShift action_83
action_109 (43) = happyShift action_84
action_109 (29) = happyGoto action_82
action_109 _ = happyReduce_58

action_110 _ = happyReduce_62

action_111 _ = happyReduce_44

action_112 _ = happyReduce_23

action_113 (38) = happyShift action_117
action_113 _ = happyFail (happyExpListPerState 113)

action_114 _ = happyReduce_24

action_115 (38) = happyShift action_116
action_115 _ = happyFail (happyExpListPerState 115)

action_116 (32) = happyShift action_50
action_116 (36) = happyShift action_51
action_116 (37) = happyShift action_7
action_116 (43) = happyShift action_52
action_116 (46) = happyShift action_53
action_116 (54) = happyShift action_54
action_116 (55) = happyShift action_8
action_116 (57) = happyShift action_55
action_116 (58) = happyShift action_56
action_116 (59) = happyShift action_9
action_116 (60) = happyShift action_57
action_116 (61) = happyShift action_10
action_116 (62) = happyShift action_58
action_116 (63) = happyShift action_11
action_116 (64) = happyShift action_59
action_116 (65) = happyShift action_26
action_116 (68) = happyShift action_2
action_116 (69) = happyShift action_61
action_116 (70) = happyShift action_62
action_116 (4) = happyGoto action_34
action_116 (5) = happyGoto action_35
action_116 (6) = happyGoto action_36
action_116 (8) = happyGoto action_37
action_116 (9) = happyGoto action_38
action_116 (13) = happyGoto action_39
action_116 (15) = happyGoto action_126
action_116 (18) = happyGoto action_41
action_116 (20) = happyGoto action_42
action_116 (21) = happyGoto action_43
action_116 (22) = happyGoto action_44
action_116 (23) = happyGoto action_45
action_116 (24) = happyGoto action_46
action_116 (25) = happyGoto action_47
action_116 (26) = happyGoto action_48
action_116 (27) = happyGoto action_49
action_116 _ = happyFail (happyExpListPerState 116)

action_117 (32) = happyShift action_50
action_117 (36) = happyShift action_51
action_117 (37) = happyShift action_7
action_117 (43) = happyShift action_52
action_117 (46) = happyShift action_53
action_117 (54) = happyShift action_54
action_117 (55) = happyShift action_8
action_117 (57) = happyShift action_55
action_117 (58) = happyShift action_56
action_117 (59) = happyShift action_9
action_117 (60) = happyShift action_57
action_117 (61) = happyShift action_10
action_117 (62) = happyShift action_58
action_117 (63) = happyShift action_11
action_117 (64) = happyShift action_59
action_117 (65) = happyShift action_26
action_117 (68) = happyShift action_2
action_117 (69) = happyShift action_61
action_117 (70) = happyShift action_62
action_117 (4) = happyGoto action_34
action_117 (5) = happyGoto action_35
action_117 (6) = happyGoto action_36
action_117 (8) = happyGoto action_37
action_117 (9) = happyGoto action_38
action_117 (13) = happyGoto action_39
action_117 (15) = happyGoto action_125
action_117 (18) = happyGoto action_41
action_117 (20) = happyGoto action_42
action_117 (21) = happyGoto action_43
action_117 (22) = happyGoto action_44
action_117 (23) = happyGoto action_45
action_117 (24) = happyGoto action_46
action_117 (25) = happyGoto action_47
action_117 (26) = happyGoto action_48
action_117 (27) = happyGoto action_49
action_117 _ = happyFail (happyExpListPerState 117)

action_118 _ = happyReduce_43

action_119 (32) = happyShift action_50
action_119 (36) = happyShift action_51
action_119 (43) = happyShift action_52
action_119 (57) = happyShift action_55
action_119 (62) = happyShift action_58
action_119 (68) = happyShift action_2
action_119 (69) = happyShift action_61
action_119 (70) = happyShift action_62
action_119 (4) = happyGoto action_64
action_119 (5) = happyGoto action_35
action_119 (6) = happyGoto action_36
action_119 (9) = happyGoto action_38
action_119 (20) = happyGoto action_42
action_119 (21) = happyGoto action_43
action_119 (22) = happyGoto action_44
action_119 (23) = happyGoto action_45
action_119 (24) = happyGoto action_46
action_119 (25) = happyGoto action_47
action_119 (26) = happyGoto action_48
action_119 (27) = happyGoto action_104
action_119 (28) = happyGoto action_124
action_119 _ = happyReduce_64

action_120 _ = happyReduce_31

action_121 (49) = happyShift action_103
action_121 _ = happyReduce_30

action_122 _ = happyReduce_33

action_123 _ = happyReduce_20

action_124 _ = happyReduce_66

action_125 (56) = happyShift action_127
action_125 _ = happyReduce_26

action_126 _ = happyReduce_28

action_127 (32) = happyShift action_50
action_127 (36) = happyShift action_51
action_127 (37) = happyShift action_7
action_127 (43) = happyShift action_52
action_127 (46) = happyShift action_53
action_127 (54) = happyShift action_54
action_127 (55) = happyShift action_8
action_127 (57) = happyShift action_55
action_127 (58) = happyShift action_56
action_127 (59) = happyShift action_9
action_127 (60) = happyShift action_57
action_127 (61) = happyShift action_10
action_127 (62) = happyShift action_58
action_127 (63) = happyShift action_11
action_127 (64) = happyShift action_59
action_127 (65) = happyShift action_26
action_127 (68) = happyShift action_2
action_127 (69) = happyShift action_61
action_127 (70) = happyShift action_62
action_127 (4) = happyGoto action_34
action_127 (5) = happyGoto action_35
action_127 (6) = happyGoto action_36
action_127 (8) = happyGoto action_37
action_127 (9) = happyGoto action_38
action_127 (13) = happyGoto action_39
action_127 (15) = happyGoto action_128
action_127 (18) = happyGoto action_41
action_127 (20) = happyGoto action_42
action_127 (21) = happyGoto action_43
action_127 (22) = happyGoto action_44
action_127 (23) = happyGoto action_45
action_127 (24) = happyGoto action_46
action_127 (25) = happyGoto action_47
action_127 (26) = happyGoto action_48
action_127 (27) = happyGoto action_49
action_127 _ = happyFail (happyExpListPerState 127)

action_128 _ = happyReduce_27

happyReduce_1 = happySpecReduce_1  4 happyReduction_1
happyReduction_1 (HappyTerminal (PT _ (TV happy_var_1)))
	 =  HappyAbsSyn4
		 (Ident happy_var_1
	)
happyReduction_1 _  = notHappyAtAll 

happyReduce_2 = happySpecReduce_1  5 happyReduction_2
happyReduction_2 (HappyTerminal (PT _ (TI happy_var_1)))
	 =  HappyAbsSyn5
		 ((read ( happy_var_1)) :: Integer
	)
happyReduction_2 _  = notHappyAtAll 

happyReduce_3 = happySpecReduce_1  6 happyReduction_3
happyReduction_3 (HappyTerminal (PT _ (TL happy_var_1)))
	 =  HappyAbsSyn6
		 (happy_var_1
	)
happyReduction_3 _  = notHappyAtAll 

happyReduce_4 = happySpecReduce_1  7 happyReduction_4
happyReduction_4 (HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn7
		 (AbsQwerty.MainProg happy_var_1
	)
happyReduction_4 _  = notHappyAtAll 

happyReduce_5 = happyReduce 4 8 happyReduction_5
happyReduction_5 ((HappyAbsSyn13  happy_var_4) `HappyStk`
	(HappyAbsSyn9  happy_var_3) `HappyStk`
	(HappyAbsSyn4  happy_var_2) `HappyStk`
	(HappyAbsSyn18  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn8
		 (AbsQwerty.TopDef happy_var_1 happy_var_2 happy_var_3 happy_var_4
	) `HappyStk` happyRest

happyReduce_6 = happySpecReduce_3  9 happyReduction_6
happyReduction_6 _
	(HappyAbsSyn12  happy_var_2)
	_
	 =  HappyAbsSyn9
		 (AbsQwerty.FunArgs happy_var_2
	)
happyReduction_6 _ _ _  = notHappyAtAll 

happyReduce_7 = happySpecReduce_1  10 happyReduction_7
happyReduction_7 (HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn10
		 ((:[]) happy_var_1
	)
happyReduction_7 _  = notHappyAtAll 

happyReduce_8 = happySpecReduce_2  10 happyReduction_8
happyReduction_8 (HappyAbsSyn10  happy_var_2)
	(HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn10
		 ((:) happy_var_1 happy_var_2
	)
happyReduction_8 _ _  = notHappyAtAll 

happyReduce_9 = happySpecReduce_2  11 happyReduction_9
happyReduction_9 (HappyAbsSyn4  happy_var_2)
	(HappyAbsSyn18  happy_var_1)
	 =  HappyAbsSyn11
		 (AbsQwerty.FunArg happy_var_1 happy_var_2
	)
happyReduction_9 _ _  = notHappyAtAll 

happyReduce_10 = happySpecReduce_0  12 happyReduction_10
happyReduction_10  =  HappyAbsSyn12
		 ([]
	)

happyReduce_11 = happySpecReduce_1  12 happyReduction_11
happyReduction_11 (HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn12
		 ((:[]) happy_var_1
	)
happyReduction_11 _  = notHappyAtAll 

happyReduce_12 = happySpecReduce_3  12 happyReduction_12
happyReduction_12 (HappyAbsSyn12  happy_var_3)
	_
	(HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn12
		 ((:) happy_var_1 happy_var_3
	)
happyReduction_12 _ _ _  = notHappyAtAll 

happyReduce_13 = happySpecReduce_3  13 happyReduction_13
happyReduction_13 _
	(HappyAbsSyn14  happy_var_2)
	_
	 =  HappyAbsSyn13
		 (AbsQwerty.ScopeBlock (reverse happy_var_2)
	)
happyReduction_13 _ _ _  = notHappyAtAll 

happyReduce_14 = happySpecReduce_0  14 happyReduction_14
happyReduction_14  =  HappyAbsSyn14
		 ([]
	)

happyReduce_15 = happySpecReduce_2  14 happyReduction_15
happyReduction_15 (HappyAbsSyn15  happy_var_2)
	(HappyAbsSyn14  happy_var_1)
	 =  HappyAbsSyn14
		 (flip (:) happy_var_1 happy_var_2
	)
happyReduction_15 _ _  = notHappyAtAll 

happyReduce_16 = happySpecReduce_1  15 happyReduction_16
happyReduction_16 _
	 =  HappyAbsSyn15
		 (AbsQwerty.Empty
	)

happyReduce_17 = happySpecReduce_1  15 happyReduction_17
happyReduction_17 (HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn15
		 (AbsQwerty.BStmt happy_var_1
	)
happyReduction_17 _  = notHappyAtAll 

happyReduce_18 = happySpecReduce_1  15 happyReduction_18
happyReduction_18 (HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn15
		 (AbsQwerty.NestFunc happy_var_1
	)
happyReduction_18 _  = notHappyAtAll 

happyReduce_19 = happySpecReduce_3  15 happyReduction_19
happyReduction_19 _
	(HappyAbsSyn17  happy_var_2)
	(HappyAbsSyn18  happy_var_1)
	 =  HappyAbsSyn15
		 (AbsQwerty.Decl happy_var_1 happy_var_2
	)
happyReduction_19 _ _ _  = notHappyAtAll 

happyReduce_20 = happyReduce 4 15 happyReduction_20
happyReduction_20 (_ `HappyStk`
	(HappyAbsSyn20  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn4  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn15
		 (AbsQwerty.Ass happy_var_1 happy_var_3
	) `HappyStk` happyRest

happyReduce_21 = happySpecReduce_3  15 happyReduction_21
happyReduction_21 _
	_
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn15
		 (AbsQwerty.Incr happy_var_1
	)
happyReduction_21 _ _ _  = notHappyAtAll 

happyReduce_22 = happySpecReduce_3  15 happyReduction_22
happyReduction_22 _
	_
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn15
		 (AbsQwerty.Decr happy_var_1
	)
happyReduction_22 _ _ _  = notHappyAtAll 

happyReduce_23 = happySpecReduce_3  15 happyReduction_23
happyReduction_23 _
	(HappyAbsSyn20  happy_var_2)
	_
	 =  HappyAbsSyn15
		 (AbsQwerty.Assert happy_var_2
	)
happyReduction_23 _ _ _  = notHappyAtAll 

happyReduce_24 = happySpecReduce_3  15 happyReduction_24
happyReduction_24 _
	(HappyAbsSyn20  happy_var_2)
	_
	 =  HappyAbsSyn15
		 (AbsQwerty.Ret happy_var_2
	)
happyReduction_24 _ _ _  = notHappyAtAll 

happyReduce_25 = happySpecReduce_2  15 happyReduction_25
happyReduction_25 _
	_
	 =  HappyAbsSyn15
		 (AbsQwerty.VRet
	)

happyReduce_26 = happyReduce 5 15 happyReduction_26
happyReduction_26 ((HappyAbsSyn15  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn20  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn15
		 (AbsQwerty.Cond happy_var_3 happy_var_5
	) `HappyStk` happyRest

happyReduce_27 = happyReduce 7 15 happyReduction_27
happyReduction_27 ((HappyAbsSyn15  happy_var_7) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn15  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn20  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn15
		 (AbsQwerty.CondElse happy_var_3 happy_var_5 happy_var_7
	) `HappyStk` happyRest

happyReduce_28 = happyReduce 5 15 happyReduction_28
happyReduction_28 ((HappyAbsSyn15  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn20  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn15
		 (AbsQwerty.While happy_var_3 happy_var_5
	) `HappyStk` happyRest

happyReduce_29 = happySpecReduce_2  15 happyReduction_29
happyReduction_29 _
	(HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn15
		 (AbsQwerty.SExp happy_var_1
	)
happyReduction_29 _ _  = notHappyAtAll 

happyReduce_30 = happySpecReduce_1  16 happyReduction_30
happyReduction_30 (HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn16
		 (AbsQwerty.NoInit happy_var_1
	)
happyReduction_30 _  = notHappyAtAll 

happyReduce_31 = happySpecReduce_3  16 happyReduction_31
happyReduction_31 (HappyAbsSyn20  happy_var_3)
	_
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn16
		 (AbsQwerty.Init happy_var_1 happy_var_3
	)
happyReduction_31 _ _ _  = notHappyAtAll 

happyReduce_32 = happySpecReduce_1  17 happyReduction_32
happyReduction_32 (HappyAbsSyn16  happy_var_1)
	 =  HappyAbsSyn17
		 ((:[]) happy_var_1
	)
happyReduction_32 _  = notHappyAtAll 

happyReduce_33 = happySpecReduce_3  17 happyReduction_33
happyReduction_33 (HappyAbsSyn17  happy_var_3)
	_
	(HappyAbsSyn16  happy_var_1)
	 =  HappyAbsSyn17
		 ((:) happy_var_1 happy_var_3
	)
happyReduction_33 _ _ _  = notHappyAtAll 

happyReduce_34 = happySpecReduce_1  18 happyReduction_34
happyReduction_34 _
	 =  HappyAbsSyn18
		 (AbsQwerty.TInt
	)

happyReduce_35 = happySpecReduce_1  18 happyReduction_35
happyReduction_35 _
	 =  HappyAbsSyn18
		 (AbsQwerty.TStr
	)

happyReduce_36 = happySpecReduce_1  18 happyReduction_36
happyReduction_36 _
	 =  HappyAbsSyn18
		 (AbsQwerty.TBool
	)

happyReduce_37 = happySpecReduce_1  18 happyReduction_37
happyReduction_37 _
	 =  HappyAbsSyn18
		 (AbsQwerty.TVoid
	)

happyReduce_38 = happyReduce 6 18 happyReduction_38
happyReduction_38 (_ `HappyStk`
	(HappyAbsSyn18  happy_var_5) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn19  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn18
		 (AbsQwerty.TFun happy_var_2 happy_var_5
	) `HappyStk` happyRest

happyReduce_39 = happySpecReduce_0  19 happyReduction_39
happyReduction_39  =  HappyAbsSyn19
		 ([]
	)

happyReduce_40 = happySpecReduce_1  19 happyReduction_40
happyReduction_40 (HappyAbsSyn18  happy_var_1)
	 =  HappyAbsSyn19
		 ((:[]) happy_var_1
	)
happyReduction_40 _  = notHappyAtAll 

happyReduce_41 = happySpecReduce_3  19 happyReduction_41
happyReduction_41 (HappyAbsSyn19  happy_var_3)
	_
	(HappyAbsSyn18  happy_var_1)
	 =  HappyAbsSyn19
		 ((:) happy_var_1 happy_var_3
	)
happyReduction_41 _ _ _  = notHappyAtAll 

happyReduce_42 = happySpecReduce_1  20 happyReduction_42
happyReduction_42 (HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn20
		 (AbsQwerty.EVar happy_var_1
	)
happyReduction_42 _  = notHappyAtAll 

happyReduce_43 = happyReduce 4 20 happyReduction_43
happyReduction_43 (_ `HappyStk`
	(HappyAbsSyn28  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn20  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn20
		 (AbsQwerty.EApp happy_var_1 happy_var_3
	) `HappyStk` happyRest

happyReduce_44 = happySpecReduce_3  20 happyReduction_44
happyReduction_44 _
	(HappyAbsSyn20  happy_var_2)
	_
	 =  HappyAbsSyn20
		 (happy_var_2
	)
happyReduction_44 _ _ _  = notHappyAtAll 

happyReduce_45 = happySpecReduce_3  21 happyReduction_45
happyReduction_45 (HappyAbsSyn13  happy_var_3)
	_
	(HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn20
		 (AbsQwerty.ELambda happy_var_1 happy_var_3
	)
happyReduction_45 _ _ _  = notHappyAtAll 

happyReduce_46 = happySpecReduce_1  21 happyReduction_46
happyReduction_46 (HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn20
		 (AbsQwerty.ELitInt happy_var_1
	)
happyReduction_46 _  = notHappyAtAll 

happyReduce_47 = happySpecReduce_1  21 happyReduction_47
happyReduction_47 _
	 =  HappyAbsSyn20
		 (AbsQwerty.ELitTrue
	)

happyReduce_48 = happySpecReduce_1  21 happyReduction_48
happyReduction_48 _
	 =  HappyAbsSyn20
		 (AbsQwerty.ELitFalse
	)

happyReduce_49 = happySpecReduce_1  21 happyReduction_49
happyReduction_49 (HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn20
		 (AbsQwerty.EString happy_var_1
	)
happyReduction_49 _  = notHappyAtAll 

happyReduce_50 = happySpecReduce_1  21 happyReduction_50
happyReduction_50 (HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn20
		 (happy_var_1
	)
happyReduction_50 _  = notHappyAtAll 

happyReduce_51 = happySpecReduce_2  22 happyReduction_51
happyReduction_51 (HappyAbsSyn20  happy_var_2)
	_
	 =  HappyAbsSyn20
		 (AbsQwerty.Neg happy_var_2
	)
happyReduction_51 _ _  = notHappyAtAll 

happyReduce_52 = happySpecReduce_2  22 happyReduction_52
happyReduction_52 (HappyAbsSyn20  happy_var_2)
	_
	 =  HappyAbsSyn20
		 (AbsQwerty.Not happy_var_2
	)
happyReduction_52 _ _  = notHappyAtAll 

happyReduce_53 = happySpecReduce_1  22 happyReduction_53
happyReduction_53 (HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn20
		 (happy_var_1
	)
happyReduction_53 _  = notHappyAtAll 

happyReduce_54 = happySpecReduce_3  23 happyReduction_54
happyReduction_54 (HappyAbsSyn20  happy_var_3)
	(HappyAbsSyn30  happy_var_2)
	(HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn20
		 (AbsQwerty.EMul happy_var_1 happy_var_2 happy_var_3
	)
happyReduction_54 _ _ _  = notHappyAtAll 

happyReduce_55 = happySpecReduce_1  23 happyReduction_55
happyReduction_55 (HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn20
		 (happy_var_1
	)
happyReduction_55 _  = notHappyAtAll 

happyReduce_56 = happySpecReduce_3  24 happyReduction_56
happyReduction_56 (HappyAbsSyn20  happy_var_3)
	(HappyAbsSyn29  happy_var_2)
	(HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn20
		 (AbsQwerty.EAdd happy_var_1 happy_var_2 happy_var_3
	)
happyReduction_56 _ _ _  = notHappyAtAll 

happyReduce_57 = happySpecReduce_1  24 happyReduction_57
happyReduction_57 (HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn20
		 (happy_var_1
	)
happyReduction_57 _  = notHappyAtAll 

happyReduce_58 = happySpecReduce_3  25 happyReduction_58
happyReduction_58 (HappyAbsSyn20  happy_var_3)
	(HappyAbsSyn31  happy_var_2)
	(HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn20
		 (AbsQwerty.ERel happy_var_1 happy_var_2 happy_var_3
	)
happyReduction_58 _ _ _  = notHappyAtAll 

happyReduce_59 = happySpecReduce_1  25 happyReduction_59
happyReduction_59 (HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn20
		 (happy_var_1
	)
happyReduction_59 _  = notHappyAtAll 

happyReduce_60 = happySpecReduce_3  26 happyReduction_60
happyReduction_60 (HappyAbsSyn20  happy_var_3)
	_
	(HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn20
		 (AbsQwerty.EAnd happy_var_1 happy_var_3
	)
happyReduction_60 _ _ _  = notHappyAtAll 

happyReduce_61 = happySpecReduce_1  26 happyReduction_61
happyReduction_61 (HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn20
		 (happy_var_1
	)
happyReduction_61 _  = notHappyAtAll 

happyReduce_62 = happySpecReduce_3  27 happyReduction_62
happyReduction_62 (HappyAbsSyn20  happy_var_3)
	_
	(HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn20
		 (AbsQwerty.EOr happy_var_1 happy_var_3
	)
happyReduction_62 _ _ _  = notHappyAtAll 

happyReduce_63 = happySpecReduce_1  27 happyReduction_63
happyReduction_63 (HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn20
		 (happy_var_1
	)
happyReduction_63 _  = notHappyAtAll 

happyReduce_64 = happySpecReduce_0  28 happyReduction_64
happyReduction_64  =  HappyAbsSyn28
		 ([]
	)

happyReduce_65 = happySpecReduce_1  28 happyReduction_65
happyReduction_65 (HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn28
		 ((:[]) happy_var_1
	)
happyReduction_65 _  = notHappyAtAll 

happyReduce_66 = happySpecReduce_3  28 happyReduction_66
happyReduction_66 (HappyAbsSyn28  happy_var_3)
	_
	(HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn28
		 ((:) happy_var_1 happy_var_3
	)
happyReduction_66 _ _ _  = notHappyAtAll 

happyReduce_67 = happySpecReduce_1  29 happyReduction_67
happyReduction_67 _
	 =  HappyAbsSyn29
		 (AbsQwerty.Plus
	)

happyReduce_68 = happySpecReduce_1  29 happyReduction_68
happyReduction_68 _
	 =  HappyAbsSyn29
		 (AbsQwerty.Minus
	)

happyReduce_69 = happySpecReduce_1  30 happyReduction_69
happyReduction_69 _
	 =  HappyAbsSyn30
		 (AbsQwerty.Times
	)

happyReduce_70 = happySpecReduce_1  30 happyReduction_70
happyReduction_70 _
	 =  HappyAbsSyn30
		 (AbsQwerty.Div
	)

happyReduce_71 = happySpecReduce_1  30 happyReduction_71
happyReduction_71 _
	 =  HappyAbsSyn30
		 (AbsQwerty.Mod
	)

happyReduce_72 = happySpecReduce_1  31 happyReduction_72
happyReduction_72 _
	 =  HappyAbsSyn31
		 (AbsQwerty.LTH
	)

happyReduce_73 = happySpecReduce_1  31 happyReduction_73
happyReduction_73 _
	 =  HappyAbsSyn31
		 (AbsQwerty.LE
	)

happyReduce_74 = happySpecReduce_1  31 happyReduction_74
happyReduction_74 _
	 =  HappyAbsSyn31
		 (AbsQwerty.GTH
	)

happyReduce_75 = happySpecReduce_1  31 happyReduction_75
happyReduction_75 _
	 =  HappyAbsSyn31
		 (AbsQwerty.GE
	)

happyReduce_76 = happySpecReduce_1  31 happyReduction_76
happyReduction_76 _
	 =  HappyAbsSyn31
		 (AbsQwerty.EQU
	)

happyReduce_77 = happySpecReduce_1  31 happyReduction_77
happyReduction_77 _
	 =  HappyAbsSyn31
		 (AbsQwerty.NE
	)

happyNewToken action sts stk [] =
	action 71 71 notHappyAtAll (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	PT _ (TS _ 1) -> cont 32;
	PT _ (TS _ 2) -> cont 33;
	PT _ (TS _ 3) -> cont 34;
	PT _ (TS _ 4) -> cont 35;
	PT _ (TS _ 5) -> cont 36;
	PT _ (TS _ 6) -> cont 37;
	PT _ (TS _ 7) -> cont 38;
	PT _ (TS _ 8) -> cont 39;
	PT _ (TS _ 9) -> cont 40;
	PT _ (TS _ 10) -> cont 41;
	PT _ (TS _ 11) -> cont 42;
	PT _ (TS _ 12) -> cont 43;
	PT _ (TS _ 13) -> cont 44;
	PT _ (TS _ 14) -> cont 45;
	PT _ (TS _ 15) -> cont 46;
	PT _ (TS _ 16) -> cont 47;
	PT _ (TS _ 17) -> cont 48;
	PT _ (TS _ 18) -> cont 49;
	PT _ (TS _ 19) -> cont 50;
	PT _ (TS _ 20) -> cont 51;
	PT _ (TS _ 21) -> cont 52;
	PT _ (TS _ 22) -> cont 53;
	PT _ (TS _ 23) -> cont 54;
	PT _ (TS _ 24) -> cont 55;
	PT _ (TS _ 25) -> cont 56;
	PT _ (TS _ 26) -> cont 57;
	PT _ (TS _ 27) -> cont 58;
	PT _ (TS _ 28) -> cont 59;
	PT _ (TS _ 29) -> cont 60;
	PT _ (TS _ 30) -> cont 61;
	PT _ (TS _ 31) -> cont 62;
	PT _ (TS _ 32) -> cont 63;
	PT _ (TS _ 33) -> cont 64;
	PT _ (TS _ 34) -> cont 65;
	PT _ (TS _ 35) -> cont 66;
	PT _ (TS _ 36) -> cont 67;
	PT _ (TV happy_dollar_dollar) -> cont 68;
	PT _ (TI happy_dollar_dollar) -> cont 69;
	PT _ (TL happy_dollar_dollar) -> cont 70;
	_ -> happyError' ((tk:tks), [])
	}

happyError_ explist 71 tk tks = happyError' (tks, explist)
happyError_ explist _ tk tks = happyError' ((tk:tks), explist)

happyThen :: () => Err a -> (a -> Err b) -> Err b
happyThen = (thenM)
happyReturn :: () => a -> Err a
happyReturn = (returnM)
happyThen1 m k tks = (thenM) m (\a -> k a tks)
happyReturn1 :: () => a -> b -> Err a
happyReturn1 = \a tks -> (returnM) a
happyError' :: () => ([(Token)], [String]) -> Err a
happyError' = (\(tokens, _) -> happyError tokens)
pProgram tks = happySomeParser where
 happySomeParser = happyThen (happyParse action_0 tks) (\x -> case x of {HappyAbsSyn7 z -> happyReturn z; _other -> notHappyAtAll })

happySeq = happyDontSeq


returnM :: a -> Err a
returnM = return

thenM :: Err a -> (a -> Err b) -> Err b
thenM = (>>=)

happyError :: [Token] -> Err a
happyError ts =
  Bad $ "syntax error at " ++ tokenPos ts ++ 
  case ts of
    [] -> []
    [Err _] -> " due to lexer error"
    t:_ -> " before `" ++ id(prToken t) ++ "'"

myLexer = tokens
{-# LINE 1 "templates/GenericTemplate.hs" #-}
{-# LINE 1 "templates/GenericTemplate.hs" #-}
{-# LINE 1 "<built-in>" #-}
{-# LINE 1 "<command-line>" #-}







# 1 "/usr/include/stdc-predef.h" 1 3 4

# 17 "/usr/include/stdc-predef.h" 3 4











































{-# LINE 7 "<command-line>" #-}
{-# LINE 1 "/usr/lib/ghc-8.6.5/include/ghcversion.h" #-}















{-# LINE 7 "<command-line>" #-}
{-# LINE 1 "/tmp/ghc21681_0/ghc_2.h" #-}








































































































































































































































































































































































{-# LINE 7 "<command-line>" #-}
{-# LINE 1 "templates/GenericTemplate.hs" #-}
-- Id: GenericTemplate.hs,v 1.26 2005/01/14 14:47:22 simonmar Exp 









{-# LINE 43 "templates/GenericTemplate.hs" #-}

data Happy_IntList = HappyCons Int Happy_IntList







{-# LINE 65 "templates/GenericTemplate.hs" #-}

{-# LINE 75 "templates/GenericTemplate.hs" #-}

{-# LINE 84 "templates/GenericTemplate.hs" #-}

infixr 9 `HappyStk`
data HappyStk a = HappyStk a (HappyStk a)

-----------------------------------------------------------------------------
-- starting the parse

happyParse start_state = happyNewToken start_state notHappyAtAll notHappyAtAll

-----------------------------------------------------------------------------
-- Accepting the parse

-- If the current token is (1), it means we've just accepted a partial
-- parse (a %partial parser).  We must ignore the saved token on the top of
-- the stack in this case.
happyAccept (1) tk st sts (_ `HappyStk` ans `HappyStk` _) =
        happyReturn1 ans
happyAccept j tk st sts (HappyStk ans _) = 
         (happyReturn1 ans)

-----------------------------------------------------------------------------
-- Arrays only: do the next action

{-# LINE 137 "templates/GenericTemplate.hs" #-}

{-# LINE 147 "templates/GenericTemplate.hs" #-}
indexShortOffAddr arr off = arr Happy_Data_Array.! off


{-# INLINE happyLt #-}
happyLt x y = (x < y)






readArrayBit arr bit =
    Bits.testBit (indexShortOffAddr arr (bit `div` 16)) (bit `mod` 16)






-----------------------------------------------------------------------------
-- HappyState data type (not arrays)



newtype HappyState b c = HappyState
        (Int ->                    -- token number
         Int ->                    -- token number (yes, again)
         b ->                           -- token semantic value
         HappyState b c ->              -- current state
         [HappyState b c] ->            -- state stack
         c)



-----------------------------------------------------------------------------
-- Shifting a token

happyShift new_state (1) tk st sts stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--     trace "shifting the error token" $
     new_state i i tk (HappyState (new_state)) ((st):(sts)) (stk)

happyShift new_state i tk st sts stk =
     happyNewToken new_state ((st):(sts)) ((HappyTerminal (tk))`HappyStk`stk)

-- happyReduce is specialised for the common cases.

happySpecReduce_0 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_0 nt fn j tk st@((HappyState (action))) sts stk
     = action nt j tk st ((st):(sts)) (fn `HappyStk` stk)

happySpecReduce_1 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_1 nt fn j tk _ sts@(((st@(HappyState (action))):(_))) (v1`HappyStk`stk')
     = let r = fn v1 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_2 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_2 nt fn j tk _ ((_):(sts@(((st@(HappyState (action))):(_))))) (v1`HappyStk`v2`HappyStk`stk')
     = let r = fn v1 v2 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_3 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_3 nt fn j tk _ ((_):(((_):(sts@(((st@(HappyState (action))):(_))))))) (v1`HappyStk`v2`HappyStk`v3`HappyStk`stk')
     = let r = fn v1 v2 v3 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happyReduce k i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyReduce k nt fn j tk st sts stk
     = case happyDrop (k - ((1) :: Int)) sts of
         sts1@(((st1@(HappyState (action))):(_))) ->
                let r = fn stk in  -- it doesn't hurt to always seq here...
                happyDoSeq r (action nt j tk st1 sts1 r)

happyMonadReduce k nt fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyMonadReduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
          let drop_stk = happyDropStk k stk in
          happyThen1 (fn stk tk) (\r -> action nt j tk st1 sts1 (r `HappyStk` drop_stk))

happyMonad2Reduce k nt fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyMonad2Reduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
         let drop_stk = happyDropStk k stk





             _ = nt :: Int
             new_state = action

          in
          happyThen1 (fn stk tk) (\r -> happyNewToken new_state sts1 (r `HappyStk` drop_stk))

happyDrop (0) l = l
happyDrop n ((_):(t)) = happyDrop (n - ((1) :: Int)) t

happyDropStk (0) l = l
happyDropStk n (x `HappyStk` xs) = happyDropStk (n - ((1)::Int)) xs

-----------------------------------------------------------------------------
-- Moving to a new state after a reduction

{-# LINE 267 "templates/GenericTemplate.hs" #-}
happyGoto action j tk st = action j j tk (HappyState action)


-----------------------------------------------------------------------------
-- Error recovery ((1) is the error token)

-- parse error if we are in recovery and we fail again
happyFail explist (1) tk old_st _ stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--      trace "failing" $ 
        happyError_ explist i tk

{-  We don't need state discarding for our restricted implementation of
    "error".  In fact, it can cause some bogus parses, so I've disabled it
    for now --SDM

-- discard a state
happyFail  (1) tk old_st (((HappyState (action))):(sts)) 
                                                (saved_tok `HappyStk` _ `HappyStk` stk) =
--      trace ("discarding state, depth " ++ show (length stk))  $
        action (1) (1) tk (HappyState (action)) sts ((saved_tok`HappyStk`stk))
-}

-- Enter error recovery: generate an error token,
--                       save the old token and carry on.
happyFail explist i tk (HappyState (action)) sts stk =
--      trace "entering error recovery" $
        action (1) (1) tk (HappyState (action)) sts ( (HappyErrorToken (i)) `HappyStk` stk)

-- Internal happy errors:

notHappyAtAll :: a
notHappyAtAll = error "Internal Happy error\n"

-----------------------------------------------------------------------------
-- Hack to get the typechecker to accept our action functions







-----------------------------------------------------------------------------
-- Seq-ing.  If the --strict flag is given, then Happy emits 
--      happySeq = happyDoSeq
-- otherwise it emits
--      happySeq = happyDontSeq

happyDoSeq, happyDontSeq :: a -> b -> b
happyDoSeq   a b = a `seq` b
happyDontSeq a b = b

-----------------------------------------------------------------------------
-- Don't inline any functions from the template.  GHC has a nasty habit
-- of deciding to inline happyGoto everywhere, which increases the size of
-- the generated parser quite a bit.

{-# LINE 333 "templates/GenericTemplate.hs" #-}
{-# NOINLINE happyShift #-}
{-# NOINLINE happySpecReduce_0 #-}
{-# NOINLINE happySpecReduce_1 #-}
{-# NOINLINE happySpecReduce_2 #-}
{-# NOINLINE happySpecReduce_3 #-}
{-# NOINLINE happyReduce #-}
{-# NOINLINE happyMonadReduce #-}
{-# NOINLINE happyGoto #-}
{-# NOINLINE happyFail #-}

-- end of Happy Template.
