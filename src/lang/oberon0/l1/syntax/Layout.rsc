module lang::oberon0::l1::\syntax::Layout

lexical Layout 
	= whitespace: [\t-\n\r\ ] 
	| Comment 
	;

layout Layouts = Layout* 
	!>> [\t-\n \r \ ] 
	!>> "(*" 
	;

lexical Comment 
	= @category="Comment"  "(*" CommentChar* "*)" 
	;

lexical CommentChar 
	= ![*] 
	| [*] !>> [)] 
	;

