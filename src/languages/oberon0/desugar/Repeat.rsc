module languages::oberon0::desugar::Repeat

import languages::oberon0::syntax::Layout;
import languages::oberon0::syntax::Lexical;
import languages::oberon0::syntax::Expressions;
import languages::oberon0::syntax::Statements;

syntax Statement 
	= repeatUntil: "REPEAT" {Statement ";"}* body "UNTIL" Expression cond
	;



