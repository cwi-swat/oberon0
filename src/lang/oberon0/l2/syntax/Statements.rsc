module lang::oberon0::l2::syntax::Statements

import lang::oberon0::l1::syntax::Statements;
import lang::oberon0::l1::syntax::Layout;
import lang::oberon0::l1::syntax::Lexical;
import lang::oberon0::l1::syntax::Expressions;

// TODO: case

syntax Statement 
	= forDo: "FOR" Ident name ":=" Expression from "TO" Expression to "DO" {Statement ";"}* body "END"
	| repeatUntil: "REPEAT" {Statement ";"}* body "UNTIL" Expression cond
	| caseOf: "CASE" Expression exp "OF" Case* cases ElsePart? elsePart "END"
	;

syntax Case
	= guard: Expression guard ":" {Statement ";"}* body
	;

syntax Keywords
	= "FOR"
	| "TO"
	| "REPEAT"
	| "UNTIL"
	| "CASE"
	| "OF"
	;

syntax "FOR" 
	= ... # [A-Za-z0-9] 
	;
	
syntax "TO" 
	= ... # [A-Za-z0-9] 
	;
	
syntax "REPEAT" 
	= ... # [A-Za-z0-9] 
	;
	
syntax "UNTIL" 
	= ... # [A-Za-z0-9] 
	;

syntax "CASE" 
	= ... # [A-Za-z0-9] 
	;

syntax "OF" 
	= ... # [A-Za-z0-9] 
	;
