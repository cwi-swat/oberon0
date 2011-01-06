module languages::oberon0::syntax::Oberon0

import ParseTree;

syntax Ident = lex id: [a-zA-Z][a-zA-Z0-9]* - Keywords # [A-Za-z0-9] ;


syntax LAYOUT = lex whitespace: [\t-\n\r\ ] 
              | lex Comment ;

layout LAYOUTLIST = LAYOUT* 
	# [\t-\n \r \ ] 
	# "(*" ;

syntax Comment = lex @category="Comment"  "(*" CommentChar* "*)" ;

syntax CommentChar = lex ![*] | lex Asterisk ;

syntax Asterisk = lex [*] # [)] ;

syntax Keywords = "DIV" | "MOD" | "OR" | "IF" | "THEN" | "ELSE" | "ELSIF" | "OF" 
       		| "DO" | "WHILE" | "END" | "VAR" | "TYPE" | "CONST" | "MODULE" |
                | "ARRAY" | "RECORD" | "PROCEDURE" | "BEGIN";

syntax Natural = lex [0-9]+ 
       	       # [0-9];

syntax Selector = field: "." Ident field
		| subscript: "[" Expression exp "]" ;

syntax Actuals = "(" {Expression ","}* expressions ")";

syntax Statement =
       		 assign: Ident var Selector* selectors ":=" Expression exp
		 | call: Ident name Actuals? actuals
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
                | lookup: Ident var Selector* selectors
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

public Module parseOberon0Module(loc src) {
  return parse(#Module, src);
}

public Module sample() {
  return parseOberon0Module(|project://oberon0/src/sample.oberon0|);
}


