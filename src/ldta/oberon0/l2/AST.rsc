module ldta::oberon0::l2::AST

extend ldta::oberon0::l1::AST;

data Statement 
	  = forDo(Ident name, Expression from, Expression to, list[Expression] by, list[Statement] body)
	  | caseOf(Expression exp, list[Case] cases, list[Statement] elsePart)
	  ;

data Case
	  = guard(list[Label] labels, list[Statement] body)
	  ;
	  
	  
	data Label
	  = expression(Expression exp)
	  | range(Expression from, Expression to)
	  ;

anno loc Label@location;
anno loc Case@location;
	  