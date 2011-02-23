module languages::oberon0::syntax::Statements

import languages::oberon0::syntax::Layout;
import languages::oberon0::syntax::Lexical;
import languages::oberon0::syntax::Expressions;


syntax Statement 
	= assign: Ident var Selector* selectors ":=" Expression exp
	| call: Ident name Actuals? actuals
	| ifThen: "IF" Expression condition "THEN" {Statement ";"}+ body ElsIfPart* ElsePart? "END"
	| whileDo: "WHILE" Expression condition "DO" {Statement ";"}+ body "END"
	;

syntax Actuals 
	= "(" {Expression ","}* expressions ")"
	;


syntax ElsIfPart 
	= "ELSIF" Expression condition "THEN" {Statement ";"}+ body 
	;

syntax ElsePart 
	= "ELSE" {Statement ";"}+ body
	;

