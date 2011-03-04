module lang::oberon0::l4::syntax::Statements

import lang::oberon0::l4::syntax::Expressions;
import lang::oberon0::l1::syntax::Layout;
import lang::oberon0::l1::syntax::Lexical;

syntax Statement 
       // NB: plus list for selectors
	= assign: Ident var Selector+ selectors ":=" Expression exp
	;

