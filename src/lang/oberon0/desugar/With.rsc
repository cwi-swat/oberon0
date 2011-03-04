module lang::oberon0::desugar::With

import lang::oberon0::syntax::Layout;
import lang::oberon0::syntax::Lexical;
import lang::oberon0::syntax::Expressions;
import lang::oberon0::syntax::Statements;


syntax Statement 
	= withDo: "WITH" Expression record "DO" {Statement ";"}* body "END"
	;



