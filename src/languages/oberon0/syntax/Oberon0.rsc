module languages::oberon0::syntax::Oberon0

import ParseTree;

syntax Ident = lex [a-zA-Z][a-zA-Z0-9]* - Keywords # [A-Za-z0-9] ;


syntax LAYOUT = lex whitespace: [\t-\n\r\ ] 
              | lex Comment ;

layout LAYOUTLIST = LAYOUT* 
	# [\t-\n \r \ ] 
	# "(*" ;

syntax Comment = lex "(*" CommentChar* "*)" ;

syntax CommentChar = lex ![*] | lex Asterisk ;

syntax Asterisk = lex [*] # [)] ;

syntax Keywords = "DIV" | "MOD" | "OR" | "IF" | "THEN" | "ELSE" | "ELSIF" | "OF" 
       		| "DO" | "WHILE" | "END" | "VAR" | "TYPE" | "CONST" | "MODULE" |
                | "ARRAY" | "RECORD" | "PROCEDURE" | "BEGIN";

syntax Natural = lex [0-9]+ 
       	       # [0-9];

syntax Selector = field: "." Ident field
		| subscript: "[" Expression exp "]" ;

syntax Variable = var: Ident name Selector* selectors;

syntax Actuals = "(" {Expression ","}* expressions ")";

syntax Statement =
       		 assign: Variable var ":=" Expression exp
		 | call: Variable var Actuals? actuals
		 | ifThen: "IF" Expression condition "THEN"
		   		{Statement ";"}+ body
				ElsIfPart* ElsePart? "END"
		 | whileDo: "WHILE" Expression condition "DO"
		   		   {Statement ";"}+ body "END" ;

syntax ElsIfPart = "ELSIF" Expression condition "THEN" {Statement ";"}+ body ;

syntax ElsePart = "ELSE" {Statement ";"}+ body;

syntax Field = field: {Ident ","}+ names ":" Type type;

// Check this again for correctness.
syntax Expression = nat: Natural value
                | lookup: Variable var
                | bracket Bracket: "(" Expression exp ")"
		| not: "~" Expression exp
		>
		non-assoc (
		mul: Expression lhs "*" Expression rhs
		| div: Expression lhs "DIV" Expression rhs
		| mod: Expression lhs "MOD" Expression rhs
		| amp: Expression lhs "&" Expression rhs
		)
		>
		left (
		| pos: "+" Expression exp
		| neg: "-" Expression exp
		| add: Expression lhs "+" Expression rhs
		| sub: Expression lhs "-" Expression rhs
		| or: Expression lhs "OR" Expression rhs
		)
		>
		non-assoc (
		eq: Expression lhs "=" Expression rhs
		| noneq: Expression lhs "#" Expression rhs
		| lt: Expression lhs "\<" Expression rhs
		| leq: Expression lhs "\<=" Expression rhs
		| gt: Expression lhs "\>" Expression rhs
		| geq: Expression lhs "\>=" Expression rhs
		);


syntax Type = user: Ident name
	    | array: "ARRAY" Expression exp "OF" Type type
	    | record: "RECORD" {Field ";"}* fields "END";

//	    | integer: "INTEGER";

syntax Formal = formal: "VAR"? hasVar {Ident ","}+ params ":" Type type;

syntax Formals = "(" {Formal ";"}* formals ")";

syntax Body = "BEGIN" {Statement ";"}+ statements;

syntax ProcedureDecl = proc: "PROCEDURE" Ident name Formals? formals ";"
 			 			Declarations decls 
						Body? body 
					"END" Ident ";"; 

syntax ConstDecl = constDecl: Ident name "=" Expression value ";";
syntax ConstSect = "CONST" ConstDecl* consts;

syntax TypeDecl = typeDecl: Ident name "=" Type type ";";
syntax TypeSect = "TYPE" TypeDecl* types;

syntax VarDecl = varDecl: {Ident ","}* names ":" Type type ";";
syntax VarSect = "VAR" VarDecl* vars;

syntax Declarations = decls: 
       		    ConstSect? consts
		    TypeSect? types
		    VarSect? vars
		    ProcedureDecl* procs;

start syntax Module = mod: "MODULE" Ident name ";" Declarations decls Body? body "END" Ident ".";


public Module parseOberon0Module(str src) {
  return parse(#Module, src);
}

public str oberon0Sample = "MODULE Sample;
PROCEDURE Multiply; VAR x, y, z: INTEGER;
BEGIN Read(x); Read(y); z := 0; WHILE x \> 0 DO
IF x MOD 2 = 1 THEN z := z + y END ;
y := 2*y; x := x DIV 2 END ;
Write(x); Write(y); Write(z); WriteLn END Multiply;
PROCEDURE Divide; VAR x, y, r, q, w: INTEGER;
BEGIN Read(x); Read(y); r := x; q := 0; w := y; WHILE w \<= r DO w :=
2*w END ; WHILE w \> y DO
q := 2*q; w := w DIV 2;
IF w \<= r THEN r := r - w; q := q + 1 END END ;
Write(x); Write(y); Write(q); Write(r); WriteLn END Divide;
PROCEDURE BinSearch; VAR i, j, k, n, x: INTEGER;
a: ARRAY 32 OF INTEGER; BEGIN Read(n); k := 0;
WHILE k \< n DO Read(a[k]); k := k + 1 END ; Read(x); i := 0; j := n;
WHILE i \< j DO
k := (i+j) DIV 2;
IF x \< a[k] THEN j := k ELSE i := k+1 END END ;
Write(i); Write(j); Write(a[j]); WriteLn END BinSearch;
END Sample.";


public int bla() {
 return 3;
}

