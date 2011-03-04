module lang::oberon0::l2::syntax::Statements

import lang::oberon0::l1::syntax::Statements;
import lang::oberon0::l1::syntax::Layout;
import lang::oberon0::l1::syntax::Lexical;
import lang::oberon0::l1::syntax::Expressions;

// TODO: case

syntax Statement 
	= forDo: "FOR" Ident name ":=" Expression from "TO" Expression to "DO" {Statement ";"}* body "END"
	| repeatUntil: "REPEAT" {Statement ";"}* body "UNTIL" Expression cond
	;


