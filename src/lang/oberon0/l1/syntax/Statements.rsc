module lang::oberon0::l1::syntax::Statements

import lang::oberon0::l1::syntax::Layout;
import lang::oberon0::l1::syntax::Lexical;
import lang::oberon0::l1::syntax::Expressions;


syntax Statement 
	= assign: Ident var ":=" Expression exp
	| ifThen: "IF" Expression condition "THEN" {Statement ";"}+ body ElsIfPart* ElsePart? "END"
	| whileDo: "WHILE" Expression condition "DO" {Statement ";"}+ body "END"
	;


syntax ElsIfPart 
	= "ELSIF" Expression condition "THEN" {Statement ";"}+ body 
	;

syntax ElsePart 
	= "ELSE" {Statement ";"}+ body
	;

