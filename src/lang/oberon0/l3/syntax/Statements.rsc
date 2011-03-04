module lang::oberon0::l3::syntax::Statements

import lang::oberon0::l2::syntax::Statements;
import lang::oberon0::l1::syntax::Layout;
import lang::oberon0::l1::syntax::Lexical;
import lang::oberon0::l1::syntax::Expressions;


syntax Statement
       = call: Ident name Actuals? actuals
       ;

syntax Actuals 
	= "(" {Expression ","}* expressions ")"
	;


