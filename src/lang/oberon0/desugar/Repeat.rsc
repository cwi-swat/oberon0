module lang::oberon0::desugar::Repeat

import lang::oberon0::syntax::Layout;
import lang::oberon0::syntax::Lexical;
import lang::oberon0::syntax::Expressions;
import lang::oberon0::syntax::Statements;

syntax Statement 
	= repeatUntil: "REPEAT" {Statement ";"}* body "UNTIL" Expression cond
	;



