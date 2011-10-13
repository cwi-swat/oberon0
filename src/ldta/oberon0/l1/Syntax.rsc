module ldta::oberon0::l1::Syntax

start syntax Module = mod: "MODULE" Ident name ";" Declarations decls Body? body "END" Ident ".";

syntax Body = @Foldable "BEGIN" {Statement ";"}+;

keyword Keywords 
	= "MODULE"
	| "BEGIN"
	;

syntax Declarations 
	= decls: ConstSect? consts TypeSect? types VarSect? vars
	;

syntax ConstDecl 
	= constDecl: Ident name "=" Expression value ";"
	;
	
syntax ConstSect 
	= "CONST" ConstDecl* consts
	;

syntax TypeDecl 
	= typeDecl: Ident name "=" Type type ";"
	;

syntax TypeSect 
	= "TYPE" TypeDecl* types
	;

syntax VarDecl 
	= varDecl: {Ident ","}* names ":" Type type ";"
	;
	
syntax VarSect 
	= @Foldable "VAR" VarDecl* vars
	;

keyword Keywords 
	= "VAR" 
	| "TYPE" 
	| "CONST" 
	;
	
syntax Type = user: Ident name ;

syntax Statement 
	= assign: Ident var ":=" Expression exp
	
	| ifThen: "IF" Expression condition "THEN" 
					{Statement ";"}+ body 
					ElsIfPart* 
					ElsePart? 
	          "END"
	          
	| whileDo: "WHILE" Expression condition "DO" 
					{Statement ";"}+ body 
	           "END"
	| skip: 
	;


syntax ElsIfPart = "ELSIF" Expression condition "THEN" {Statement ";"}+ body ;

syntax ElsePart = "ELSE" {Statement ";"}+ body;

keyword Keywords 
	= "IF" 
	| "THEN" 
	| "ELSE" 
	| "ELSIF" 
	| "DO" 
	| "WHILE" 
	| "END" 
	;


syntax Expression 
	= nat: Natural value
	| \true: "TRUE"
	| \false: "FALSE"
	| lookup: Ident var 
	| bracket Bracket: "(" Expression exp ")"
	| not: "~" Expression exp
	> 
	left (
		mul: Expression lhs "*" Expression rhs
		| div: Expression lhs "DIV" Expression rhs
		| mod: Expression lhs "MOD" Expression rhs
		| amp: Expression lhs "&" Expression rhs
	) 
	>
	pos: "+" Expression exp
    | neg: "-" Expression exp
    >
    left (
		| add: Expression lhs "+" Expression rhs
		| sub: Expression lhs "-" Expression rhs
		| or: Expression lhs "OR" Expression rhs
	)
	> 
	non-assoc (
		eq: Expression lhs "=" Expression rhs
		| neq: Expression lhs "#" Expression rhs
		| lt: Expression lhs "\<" Expression rhs
		| leq: Expression lhs "\<=" Expression rhs
		| gt: Expression lhs "\>" Expression rhs
		| geq: Expression lhs "\>=" Expression rhs
	)
	;

keyword Keywords 
	= "DIV" 
	| "MOD" 
	| "OR" 
	| "TRUE" 
	| "FALSE"
	; 
	
lexical Ident = id: ([a-zA-Z] !<< [a-zA-Z][a-zA-Z0-9]*  !>> [A-Za-z0-9]) \ Keywords;

lexical Natural = [0-9]+ !>> [0-9] ;


lexical Layout 
	= whitespace: [\t-\n\r\ ] 
	| @category="Comment" Comment 
	;

layout Layouts = Layout* !>> [\t-\n \r \ ] !>> "(*" ;

lexical Comment =  "(*" CommentElt* "*)" ;

lexical CommentElt
   = CommentChar+
   | Comment
   ;

lexical CommentChar 
	= ![*(] 
	| [*] !>> [)]
	| [(] !>> [*] 
	;

