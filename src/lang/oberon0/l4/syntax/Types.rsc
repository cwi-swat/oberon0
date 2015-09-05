module lang::oberon0::l4::\syntax::Types

extend lang::oberon0::l1::\syntax::Types;
extend lang::oberon0::l1::\syntax::Layout;

syntax Type 
	= array: "ARRAY" Expression exp "OF" Type type
	| record: "RECORD" {Field ";"}* fields "END"
	;

syntax Field 
	= field: {Ident ","}+ names ":" Type type
	;

keyword Keywords
       = "ARRAY" 
       | "RECORD"
       | "OF"
       ;
