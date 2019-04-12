# Gramatyka języka oraz opis języka
Gramatykę swojego języka oraz opisy opieram na opisie dostępnym
na https://www.mimuw.edu.pl/~ben/Zajecia/Mrj2018/Latte/ ;
opis ten będę dalej określał "stroną o Latte"

(sidenote - ten plik powinien się ładniej wyświetlić,
gdy zostanie obsłużony jako plik formatu Markdown; nie byłem pewien czy wysłanie pliku
z rozszerzeniem `.md` będzie zgodne ze specyfikacją zadania)

Język będzie się zachowywać zgodnie z:
- opisem na stronie o Latte, 
- z konwencjami określonymi w C, 
- z komentarzami zaznaczonymi w treści gramatyki poniżej
- z określonymi w treści zadania wymaganiami.

Dla jednoznaczności zamieszczam opis poniżej, przy poszczególnych sekcjach definicji
naszej gramatyki - wobec uczynionych modyfikacji jest on więc też uzupełniony o kilka dopisków:

## Struktura programu
Program w moim języku jest listą definicji funkcji.
Na definicję funkcji składa się typ zwracanej wartości, nazwa, lista argumentów oraz ciało.
Funkcje muszą mieć unikalne nazwy.
W programie musi wystąpić funkcja o nazwie main zwracająca int i nie przyjmująca
argumentów (od niej zaczyna się wykonanie programu).
Funkcje o typie wyniku innym niż void muszą zwracać wartość za pomocą instrukcji return

Funkcje mogą być wzajemnie rekurencyjne; co za tym idzie mogą być definiowane
w dowolnej kolejności (użycie funkcji może występować przed jej definicją)

```
-- programs ------------------------------------------------

entrypoints Program ;

Program.   Program ::= [TopDef] ;

FnDef.     TopDef ::= Type Ident Args Block ;

Args.      Args ::= "(" [Arg] ")"

separator nonempty TopDef "" ;

Arg.       Arg ::= Type Ident;

separator  Arg "," ;

```
## Instrukcje
Instrukcje: pusta,złożona,if,while,return jak w C/Javie, for jak w zadaniu.
Dodatkowo instrukcjami są przypisanie, postinkrementacja, postdekrementacja
(w wersji podstawowej języka l-wartościami są tylko zmienne).
Deklaracje zmiennych mogą występować w dowolnym miejscu bloku,
jednak każda zmienna musi być zadeklarowana przed użyciem.
Jeśli zmienna nie jest jawnie inicjalizowana w momencie deklaracji,
jest inicjalizowana wartością domyślną (0 dla int, "" dla string, false dla bool).

Zmienne zadeklarowane w bloku nie są widoczne poza nim i przesłaniają zmienne
o tej samej nazwie spoza bloku.
W obrębie bloku zmienne muszą mieć unikalne nazwy.

```
-- statements ----------------------------------------------

Block.     Block ::= "{" [Stmt] "}" ;

separator  Stmt "" ;

Empty.     Stmt ::= ";" ;

BStmt.     Stmt ::= Block ;

Decl.      Stmt ::= Type [Item] ";" ;

-- 15pkt - 7b) - rzuca Runtime Exception przy próbie nadpisania;
-- tak jest najprościej, ale gdy okaże się, że będzie to dostatecznie łatwe do zrobienia,
-- to wrzucę tego consta po prostu do typów
ConstDecl. Stmt ::= "const" Type [Item] ";" ;

NoInit.    Item ::= Ident ; 

Init.      Item ::= Ident "=" Expr ;

separator nonempty Item "," ;

Ass.       Stmt ::= Ident "=" Expr  ";" ;

Incr.      Stmt ::= Ident "++"  ";" ;

Decr.      Stmt ::= Ident "--"  ";" ;

Ret.       Stmt ::= "return" Expr ";" ;

VRet.      Stmt ::= "return" ";" ;

Break.     Stmt ::= "break" ";" ;

Continue.  Stmt ::= "continue" ";" ;

Cond.      Stmt ::= "if" "(" Expr ")" Stmt  ;

CondElse.  Stmt ::= "if" "(" Expr ")" Stmt "else" Stmt  ;

While.     Stmt ::= "while" "(" Expr ")" Stmt ;

-- 15pkt - 7b)
For.       Stmt ::= "for" "(" Ident "in" Range ")" Stmt ;

SExp.      Stmt ::= Expr  ";" ;

-- 15pkt - 7b); zakres liczbowy (dla "( a : b )" jesli a > b, to od b do a, wpp od a do b)
Range.     Range ::= "(" Integer ":" Integer ")" ;

```
## Typy
Typy int,boolean,void jak w Javie; string odpowiada String.
Nie ma konwersji pomiedzy typami.
Wprowadzenie niejawnych konwersji (rzutowań) będzie traktowane jako błąd, nie zaś ulepszenie.
Wprowadzam również jawną składnie dla deklarowania typu funkcji,
m.in. dla tworzenia argumentów lambda w funkcjach oraz dla zwracania funkcji przez funkcje
```
-- Types ---------------------------------------------------

-- 15pkt - 1.
TInt.      Type ::= "int" ;

-- 15pkt - 1.
TStr.      Type ::= "string" ;

-- 15pkt - 1.
TBool.     Type ::= "boolean" ;

TVoid.     Type ::= "void" ;

-- 30pkt - lambdas
TFun.      Type ::= "(" [Type] ")" "=>" Type ;

separator  Type "," ;

```
## Wyrażenia
Podzbiór zbioru wyrażeń dostępnych w Javie, poszerzony o deklaracje lambd - podobnie do Javascript:
Wyrażenie logiczne zwracają typ boolean i są obliczane leniwie
(drugi argument nie jest wyliczany gdy pierwszy determinuje wartość wyrażenia).

```
-- Expressions ---------------------------------------------

-- 30pkt - lambdas
Lambda.    Lambda ::= Args "=>" Block ;

EVar.      Expr6 ::= Ident ;

-- 30pkt - lambdas
ELambda    Expr6 ::= Lambda ;

ELitInt.   Expr6 ::= Integer ;

ELitTrue.  Expr6 ::= "true" ;

ELitFalse. Expr6 ::= "false" ;

EApp.      Expr6 ::= Ident "(" [Expr] ")" ;

EString.   Expr6 ::= String ;

Neg.       Expr5 ::= "-" Expr6 ;

Not.       Expr5 ::= "!" Expr6 ;

EMul.      Expr4 ::= Expr4 MulOp Expr5 ;

EAdd.      Expr3 ::= Expr3 AddOp Expr4 ;

ERel.      Expr2 ::= Expr2 RelOp Expr3 ;

EAnd.      Expr1 ::= Expr2 "&&" Expr1 ;

EOr.       Expr ::= Expr1 "||" Expr ;

coercions  Expr 6 ;

separator  Expr "," ;
```
## Napisy
Napisy podobnie jak w Javie, czyli zmienne typu string zawierają referencję do napisu,
zaalokowanego na stercie.
Napisy moga występować jako: literały, wartości zmiennych, argumentów i wyników funkcji

Napisy mogą być użyte jako argumenty wbudowanej funkcji printString

Napisy mogą być konkatenowane przy pomocy operatora +.
Wynikiem tej operacji jest nowy napis będący konkatenacją argumentów

## Predefiniowane funkcje
Są dostępne predefiniowane funkcje:
```
void printInt(int)
void printString(string)
void error()
int readInt()
string readString()
```
Funkcja error wypisuje runtime error i kończy wykonywanie programu.

Funkcja readString wczytuje jedną linię z wejścia i daje ją jako wynik.
```

-- operators -----------------------------------------------

Plus.      AddOp ::= "+" ;

Minus.     AddOp ::= "-" ;

Times.     MulOp ::= "*" ;

Div.       MulOp ::= "/" ;

Mod.       MulOp ::= "%" ;

LTH.       RelOp ::= "<" ;

LE.        RelOp ::= "<=" ;

GTH.       RelOp ::= ">" ;

GE.        RelOp ::= ">=" ;

EQU.       RelOp ::= "==" ;

NE.        RelOp ::= "!=" ;

-- comments ------------------------------------------------

comment    "#" ;

comment    "//" ;

comment    "/*" "*/" ;
```


# Przykłady:
### (tutaj zrzynka ze strony o Latte: przykład z Hello world)
```
int main () {
  printString("hello world") ;
  return 0 ;
}
```

### (tutaj zrzynka ze strony o Latte: wypisz liczby parzyste do 10)
```
int main () {
  int i ;
  i = 0 ;
  while (i < 10){
    if (i % 2 == 0) printInt(i) ; 
    i++ ;
  }
  printInt(i) ;
  return 0 ;
}
```
### (tutaj zrzynka ze strony o Latte: silnia)
```
int main () {
  printInt(fact(7)) ;
  printInt(factr(7)) ;
  return 0 ;
}

int fact (int n) {
  int i,r ;
  i = 1 ;
  r = 1 ;
  while (i < n+1) {
    r = r * i ;
    i++ ;
  }
  return r ;
}

int factr (int n) {
  if (n < 2) 
    return 1 ;
  else 
    return (n * factr(n-1)) ; 
}
```

### 7b) - for expression - wypisanie liczb od 5 do 1
```
int main () {
  for (i in (5 : 1)) printInt(i) ;
}
```

# Zrealizowany zakres i punktacja
Planuję zrealizować następujące podpunkty:
- Cały podzbiór na 6pkt
- Cały podzbiór na 12pkt
- Cały podzbiór na 15pkt poza 7a) (7b. - patrz For.)
- Cały podzbiór na 20pkt
- Na 30pkt: 
  - statyczne typowanie
  - dowolnie zagnieżdżone definicje funkcji i statyczne wiązanie ich identykatorów
  - break i continue dla while
  - funkcje jako parametry i jako wyniki; closures, lambdas

Wobec tego, o ile zdołam bezbłędnie zaimplementować ten zakres,
spodziewam się otrzymać 30pkt za moje rozwiązanie.

