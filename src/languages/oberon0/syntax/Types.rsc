module languages::oberon0::syntax::Types

import languages::oberon0::syntax::Expressions;
import languages::oberon0::syntax::Layout;
import languages::oberon0::syntax::Lexical;


syntax Type 
	= user: Ident name
	| array: "ARRAY" Expression exp "OF" Type type
	| record: "RECORD" {Field ";"}* fields "END"
	;

syntax Field 
	= field: {Ident ","}+ names ":" Type type
	;
