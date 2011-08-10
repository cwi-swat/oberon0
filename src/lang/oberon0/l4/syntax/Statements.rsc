module lang::oberon0::l4::syntax::Statements

extend lang::oberon0::l4::syntax::Expressions;
import lang::oberon0::l2::syntax::Statements;

syntax Statement 
       // NB: plus list for selectors
	= assign: Ident var Selector+ selectors ":=" Expression exp
	;

