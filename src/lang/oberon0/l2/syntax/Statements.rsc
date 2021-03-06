module lang::oberon0::l2::\syntax::Statements

extend lang::oberon0::l1::\syntax::Statements;

syntax Statement 
	= forDo: "FOR" Ident name ":=" Expression from "TO" Expression to
	            ("BY" Expression)? "DO" {Statement ";"}* body "END"
	| caseOf: "CASE" Expression exp "OF" {Case "|"}* cases ElsePart? elsePart "END"
	;

syntax Case
	= guard: Expression guard ":" {Statement ";"}* body
	;

keyword Keywords
	= "FOR"
	| "TO"
	| "REPEAT"
	| "UNTIL"
	| "CASE"
	| "OF"
	;
