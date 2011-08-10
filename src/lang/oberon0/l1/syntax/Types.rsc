module lang::oberon0::l1::syntax::Types

import lang::oberon0::l1::syntax::Expressions;
import lang::oberon0::l1::syntax::Layout;
import lang::oberon0::l1::syntax::Lexical;


syntax Type 
	= user: Ident name
	;
