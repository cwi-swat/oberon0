module languages::oberon0::syntax::Oberon0

syntax Ident = lex [a-zA-Z][a-zA-Z0-9]* 
//       	     # [A-Za-z0-9]
//	     - Keywords
 ;

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

syntax Integer = lex [0-9]+ 
       	       # [0-9];

syntax Selector = Empty:
       		| Field: Selector selector "." Ident field
		| Subscript: Selector selector "[" Expression exp "]" ;

// Check this again for correctness.
syntax Expression = Num: Integer integer
                | Var: Ident var Selector selector
                | bracket Bracket: "(" Expression exp ")"
		| Not: "~" Expression exp
		>
		non-assoc (
		Mul: Expression lhs "*" Expression rhs
		| Div: Expression lhs "DIV" Expression rhs
		| Mod: Expression lhs "MOD" Expression rhs
		| Amp: Expression lhs "&" Expression rhs
		)
		>
		left (
		| Pos: "+" Expression exp
		| Neg: "-" Expression exp
		| Add: Expression lhs "+" Expression rhs
		| Sub: Expression lhs "-" Expression rhs
		| Or: Expression lhs "OR" Expression rhs
		)
		>
		non-assoc (
		Eq: Expression lhs "=" Expression rhs
		| NonEq: Expression lhs "#" Expression rhs
		| LT: Expression lhs "\<" Expression rhs
		| LEq: Expression lhs "\<=" Expression rhs
		| GT: Expression lhs "\>" Expression rhs
		| GEq: Expression lhs "\>=" Expression rhs
		);

syntax ActualParameters = Actuals: "(" {Expression ","}* expressions ")";

syntax Statement =
       		 Assignment: Ident Selector ":=" Expression
		 | ProcedureCall: Ident Selector ActualParameters?
		 | IfStatement: "IF" Expression condition "THEN"
		   		{Statement ";"}+ body
				ElsIfPart* ElsePart? "END"
		 | WhileStatement: "WHILE" Expression condition "DO"
		   		   {Statement ";"}+ body "END" ;

syntax ElsIfPart = "ELSIF" Expression condition "THEN" {Statement ";"}+ body ;

syntax ElsePart = "ELSE" {Statement ";"}+ body;

syntax ArrayType = Array: "ARRAY" Expression exp "OF" Type type;

syntax Field = Field: {Ident ","}+ names ":" Type type;

syntax RecordType = Record: "RECORD" {Field ";"}* fields "END";

syntax Type = User: Ident name 
	    | Array: ArrayType array 
	    | Record: RecordType record;

syntax FPSection = Formal: "VAR"? {Ident ","}+ params ":" Type type;

syntax FormalParameters = Formals: "(" {FPSection ";"}* fpsections ")";

syntax Body = Body: "BEGIN" {Statement ";"}+ statements;

syntax ProcedureDecl = Procedure: "PROCEDURE" Ident name FormalParameters? formals ";"
 			 			Declarations decls 
						Body? body 
					"END" Ident ";"; 


syntax ConstDecl = ConstDecl: Ident name "=" Expression value ";";
syntax ConstSect = ConstSect: "CONST" ConstDecl* consts;

syntax TypeDecl = TypeDecl: Ident name "=" Type type ";";
syntax TypeSect = TypeSect: "TYPE" TypeDecl* types;

syntax VarDecl = VarDecl: Ident name ":" Type type ";";
syntax VarSect = VarSect: "VAR" VarDecl* vars;

syntax Declarations = Decls: 
       		    ConstSect? consts
		    TypeSect? types
		    VarSect? vars
		    ProcedureDecl* procs;

start syntax Module = Module: "MODULE" Ident name ";" Declarations decls Body? body "END" Ident ".";

public int bla() {
 return 3;
}


public Module sample = (Module)`MODULE Sample;
PROCEDURE Multiply; VAR x, y, z: INTEGER;
BEGIN Read(x); Read(y); z := 0; WHILE x > 0 DO
IF x MOD 2 = 1 THEN z := z + y END ;
y := 2*y; x := x DIV 2 END ;
Write(x); Write(y); Write(z); WriteLn END Multiply;
PROCEDURE Divide; VAR x, y, r, q, w: INTEGER;
BEGIN Read(x); Read(y); r := x; q := 0; w := y; WHILE w <= r DO w := 2*w END ; WHILE w > y DO
q := 2*q; w := w DIV 2;
IF w <= r THEN r := r - w; q := q + 1 END END ;
Write(x); Write(y); Write(q); Write(r); WriteLn END Divide;
PROCEDURE BinSearch; VAR i, j, k, n, x: INTEGER;
a: ARRAY 32 OF INTEGER; BEGIN Read(n); k := 0;
WHILE k < n DO Read(a[k]); k := k + 1 END ; Read(x); i := 0; j := n; WHILE i < j DO
k := (i+j) DIV 2;
IF x < a[k] THEN j := k ELSE i := k+1 END END ;
Write(i); Write(j); Write(a[j]); WriteLn END BinSearch;
END Sample.

`;

