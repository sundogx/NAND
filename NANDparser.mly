%{
open Nand

(* Global variable for whether constants are defined*)
let constDefined = ref false

(* Definition of constants as NAND AST *)
let constDef = [ Nand("notx_0", "x_0", "x_0");
                 Nand("one", "x_0", "notx_0");
                 Nand("zero", "one", "one")  ; ]
%}

/* Declaration of tokens */
%token          EOF
%token <string> ID
%token <string> FUNC_ID
%token          NAND
%token          ASG
%token <bool>   CONST
%token          DEF
%token          COMMA
%token          L_PAREN R_PAREN
%token          L_BRACKET R_BRACKET
%token <string> MACRO_START MACRO_END
%token <string> PL_TYPE
%token          TO
%token          COLON

%start input
%type <Nand.prog> input

%start preParse 
%type <SSfunctor.preParsedProg> preParse 

%%

input: nandProg EOF { $1 }

nandProg: nandCom nandProg {$1 @ $2}
     | nandCom {$1}
     | MACRO_START COLON PL_TYPE TO PL_TYPE  MACRO_END { [] }

nandCom:
  | ID ASG ID NAND ID { [Nand($1, $3, $5)] }
  
preParse: 
  | prog EOF { $1 } 

prog: 
  | ss prog { $1 :: $2 } 
  | noSS prog { SourceLangStr($1) }

noSS:
  | ID ASG ID op ID 
     { Printf.sprintf "%s := %s %s %s" $1 $3 $4 $5 } 
  
;
