module lang::oberon0::l1::syntax::Lexical

syntax Ident 
	= lex id: [a-zA-Z][a-zA-Z0-9]* 
	- Keywords
	# [A-Za-z0-9] 
	;

syntax Natural 
	= lex [0-9]+ 
	# [0-9]
	;


