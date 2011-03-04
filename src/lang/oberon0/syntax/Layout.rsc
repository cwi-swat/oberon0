module lang::oberon0::syntax::Layout

syntax Layout 
	= lex whitespace: [\t-\n\r\ ] 
	| lex Comment 
	;

layout Layouts = Layout* 
	# [\t-\n \r \ ] 
	# "(*" 
	;

syntax Comment 
	= lex @category="Comment"  "(*" CommentChar* "*)" 
	;

syntax CommentChar 
	= lex ![*] 
	| lex Asterisk 
	;

syntax Asterisk 
	= lex [*] # [)] 
	;