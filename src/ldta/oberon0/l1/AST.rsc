module ldta::oberon0::l1::AST

data Module = \mod(Ident name, Declarations decls, list[Statement] body, Ident endName);

data Declarations = decls(list[ConstDecl] consts, list[TypeDecl] types, list[VarDecl] vars);

data ConstDecl = constDecl(Ident name, Expression \value);
	
data TypeDecl = typeDecl(Ident name, Type \type);
	
data VarDecl = varDecl(list[Ident] names, Type \type);

data Type = user(Ident name);
	
alias ElseIf = tuple[Expression condition, list[Statement] body];

data Statement 
	= assign(Ident var, Expression exp)
	| ifThen(Expression condition, list[Statement] body, list[ElseIf] elseIfs, list[Statement] elsePart)
	| whileDo(Expression condition, list[Statement] body)
	| skip()
	;

data Expression 
	= nat(int val)
	| lookup(Ident var)
	| neg(Expression exp)
	| pos(Expression exp)
	| not(Expression exp)
	| mul(Expression lhs, Expression rhs)
	| div(Expression lhs, Expression rhs)
	| \mod(Expression lhs, Expression rhs)
	| amp(Expression lhs, Expression rhs)
	| add(Expression lhs, Expression rhs)
	| sub(Expression lhs, Expression rhs)
	| or(Expression lhs, Expression rhs)
	| eq(Expression lhs, Expression rhs)
	| neq(Expression lhs, Expression rhs)
	| lt(Expression lhs, Expression rhs)
	| gt(Expression lhs, Expression rhs)
	| leq(Expression lhs, Expression rhs)
	| geq(Expression lhs, Expression rhs)
	;

data Ident = id(str name);

anno loc Ident@location;
anno loc Module@location;
anno loc VarDecl@location;
anno loc TypeDecl@location;
anno loc ConstDecl@location;
anno loc Declarations@location;
anno loc Type@location;
anno loc Statement@location;
anno loc Expression@location;

anno Expression Expression@propagated;

