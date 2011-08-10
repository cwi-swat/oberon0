module lang::oberon0::l1::syntax::Lexical

lexical Ident 
	= id: ([A-Za-z] !<< [a-zA-Z][a-zA-Z0-9]* !>> [A-Za-z0-9]) \ Keywords 
	;
	
lexical Natural 
	= [0-9]+  !>> [0-9]
	;


