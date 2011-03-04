module lang::oberon0::l4::syntax::Expressions

import lang::oberon0::l1::syntax::Expressions;
import lang::oberon0::l1::syntax::Layout;
import lang::oberon0::l1::syntax::Lexical;


syntax Expression
       // NB: plus list for selectors
       = lookup: Ident var Selector+ selectors
       ;

syntax Selector 
	= field: "." Ident field
	| subscript: "[" Expression exp "]" 
	;
