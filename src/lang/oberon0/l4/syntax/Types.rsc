module lang::oberon0::l4::syntax::Types

import lang::oberon0::l1::syntax::Expressions;
import lang::oberon0::l1::syntax::Layout;
import lang::oberon0::l1::syntax::Lexical;
import lang::oberon0::l1::syntax::Types;


syntax Type 
	= array: "ARRAY" Expression exp "OF" Type type
	| record: "RECORD" {Field ";"}* fields "END"
	;

syntax Field 
	= field: {Ident ","}+ names ":" Type type
	;

syntax Keywords
       = "ARRAY" 
       | "RECORD"
       | "OF"
       ;

syntax "ARRAY" 
	= ... # [A-Za-z0-9] 
	;
	
syntax "RECORD" 
	= ... # [A-Za-z0-9]
	;

syntax "OF"
	= ... # [A-Za-z0-9] 
	;
	
