module lang::oberon0::l2::ast::Oberon0

extend lang::oberon0::l1::ast::Oberon0;

data Statement 
	= forDo(Ident name, Expression from, Expression to, list[Expression] by, list[Statement] body)
	| caseOf(Expression exp, list[Case] cases, list[Statement] elsePart)
	;

data Case
	= guard(Expression guard, list[Statement] body)
	;
