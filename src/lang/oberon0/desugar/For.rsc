module lang::oberon0::desugar::For

import lang::oberon0::syntax::Layout;
import lang::oberon0::syntax::Lexical;
import lang::oberon0::syntax::Expressions;
import lang::oberon0::syntax::Statements;


syntax Statement 
	= forDo: "FOR" Ident name ":=" Expression from "TO" Expression to "DO" {Statement ";"}* body "END"
	;



