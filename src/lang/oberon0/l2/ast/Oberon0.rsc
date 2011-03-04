module lang::oberon0::l2::ast::Oberon0

import lang::oberon0::l1::ast::Oberon0;

data Statement 
	= forDo(Ident name, Expression from, Expression to, list[Statement] body)
	| repeatUntil(list[Statement] body, Expression cond)
	;
