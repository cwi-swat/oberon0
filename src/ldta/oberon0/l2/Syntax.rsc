module ldta::oberon0::l2::Syntax

extend ldta::oberon0::l1::Syntax;

syntax Statement 
	  = forDo: "FOR" Ident name ":=" Expression from "TO" Expression to
	            ("BY" Expression)? "DO" {Statement ";"}+ body "END"
	  | caseOf: "CASE" Expression exp "OF" {Case "|"}+ cases ElsePart? elsePart "END"
	  ;

syntax Case
	  = guard: {Label ","}+ ":" {Statement ";"}+ body
	  ;

syntax Label
  = expression: Expression exp
  | range: Expression from ".." Expression to
  ;
  
keyword Keywords
	  = "FOR"
	  | "TO"
	  | "REPEAT"
	  | "UNTIL"
	  | "CASE"
	  | "OF"
	  | "BY"
	  ;
