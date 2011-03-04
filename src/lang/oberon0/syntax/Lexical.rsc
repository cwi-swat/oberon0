module lang::oberon0::syntax::Lexical

syntax Ident 
	= lex id: [a-zA-Z][a-zA-Z0-9]* 
	- Keywords
	# [A-Za-z0-9] 
	;

syntax Natural 
	= lex [0-9]+ 
	# [0-9]
	;


syntax Keywords 
	= "DIV" 
	| "MOD" 
	| "OR" 
	| "IF" 
	| "THEN" 
	| "ELSE" 
	| "ELSIF" 
	| "OF" 
	| "DO" 
	| "WHILE" 
	| "END" 
	| "VAR" 
	| "TYPE" 
	| "CONST" 
	| "MODULE"
	| "ARRAY" 
	| "RECORD" 
	| "PROCEDURE" 
	| "BEGIN"
	;
	
syntax "DIV" 
	= ... # [A-Za-z0-9] 
	;
	
syntax "MOD" 
	= ... # [A-Za-z0-9] 
	;
	
syntax "OR" 
	= ... # [A-Za-z0-9] 
	;
	
syntax "IF" 
	= ... # [A-Za-z0-9] 
	;
	
syntax "THEN" 
	= ... # [A-Za-z0-9] 
	;
	
syntax "ELSE" 
	= ... # [A-Za-z0-9] 
	;
	
syntax "ELSIF" 
	= ... # [A-Za-z0-9] 
	;
	
syntax "OF"
	= ... # [A-Za-z0-9] 
	;
	
syntax "DO" 
	= ... # [A-Za-z0-9] 
	;
	
syntax "WHILE" 
	= ... # [A-Za-z0-9] 
	;
	
syntax "END" 
	= ... # [A-Za-z0-9] 
	;
	
syntax "VAR" 
	= ... # [A-Za-z0-9] 
	;
	
syntax "TYPE" 
	= ... # [A-Za-z0-9] 
	;
	
syntax "CONST" 
	= ... # [A-Za-z0-9] 
	;
	
syntax "MODULE" 
	= ... # [A-Za-z0-9] 
	;
	
syntax "ARRAY" 
	= ... # [A-Za-z0-9] 
	;
	
syntax "RECORD" 
	= ... # [A-Za-z0-9]
	;
	
syntax "PROCEDURE" 
	= ... # [A-Za-z0-9] 
	;
	
syntax "BEGIN" 
	= ... # [A-Za-z0-9] 
	;
	

