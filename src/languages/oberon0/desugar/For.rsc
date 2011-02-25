module languages::oberon0::desugar::For

import languages::oberon0::syntax::Layout;
import languages::oberon0::syntax::Lexical;
import languages::oberon0::syntax::Expressions;
import languages::oberon0::syntax::Statements;


syntax Statement 
	= forLoop: "FOR" Ident name ":=" Expression from "TO" Expression to "DO" {Statement ";"}* body "END"
	;



