module ldta::oberon0::l4::Syntax

extend ldta::oberon0::l3::Syntax;

syntax Statement = assign: Ident var Selector+ selectors ":=" Expression exp;

syntax Expression = lookup: Ident var Selector+ selectors;

syntax Selector 
	  = field: "." Ident field
	  | subscript: "[" Expression exp "]" 
	  ;

syntax Type 
	  = array: "ARRAY" Expression exp "OF" Type type
	  | record: "RECORD" {Field ";"}* fields "END"
  	;

syntax Field = field: {Ident ","}+ names ":" Type type;

keyword Keywords
  = "ARRAY" 
  | "RECORD"
  | "OF"
  ;
	  