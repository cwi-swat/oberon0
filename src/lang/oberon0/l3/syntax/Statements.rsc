module lang::oberon0::l3::\syntax::Statements

extend lang::oberon0::l2::\syntax::Statements;

syntax Statement
       = call: Ident name Actuals? actuals
       ;

syntax Actuals 
	= "(" {Expression ","}* expressions ")"
	;


