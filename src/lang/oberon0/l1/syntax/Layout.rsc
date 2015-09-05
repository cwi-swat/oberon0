module lang::oberon0::l1::\syntax::Layout

lexical Layout = whitespace: [\t-\n\r\ ] | @category="Comment" Comment ;

layout Layouts = Layout* !>> [\t-\n \r \ ] !>> "(*" ;

lexical Comment = "(*" CommentElt* "*)" ;
lexical CommentElt = CommentChar+ !>> ![*(] | Comment ;
lexical CommentChar 
    = ![*(] 
    | [*] !>> [)]
    | [(] !>> [*] 
    ;


