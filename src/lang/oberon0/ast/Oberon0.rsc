module lang::oberon0::ast::Oberon0

data Module = 
	mod(Ident name, Declarations decls, list[Statement] body, Ident endName)
	;

data Procedure 
	= proc(Ident name, list[Formal] formals, Declarations decls, list[Statement] body, Ident endName)
	;

data Formal 
	= formal(bool hasVar, list[Ident] names, Type \type)
	;


data Declarations 
	= decls(list[ConstDecl] consts, list[TypeDecl] types, list[VarDecl] vars, list[Procedure] procs)
	;

data ConstDecl 
	= constDecl(Ident name, Expression \value)
	;
	
data TypeDecl 
	= typeDecl(Ident name, Type \type)
	;
	
data VarDecl 
	= varDecl(list[Ident] names, Type \type)
	;

data Type 
	= user(Ident name)
	| array(Expression exp, Type \type)
	| record(list[Field] fields)
	;

data Field 
	= field(list[Ident] names, Type \type)
	;
	
data Statement 
	= assign(Ident var, list[Selector] selectors, Expression exp)
	| call(Ident proc, list[Expression] args)
	| ifThen(Expression condition, list[Statement] body, list[tuple[Expression condition, list[Statement] body]] elseIfs, list[Statement] elsePart)
	| whileDo(Expression condition, list[Statement] body)
	;

data Expression 
	= nat(int val)
	| lookup(Ident var, list[Selector] selectors)
	| neg(Expression exp)
	| pos(Expression exp)
	| not(Expression exp)
	| mul(Expression lhs, Expression rhs)
	| div(Expression lhs, Expression rhs)
	| mod(Expression lhs, Expression rhs)
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

data Selector 
	= field(Ident field)
	| subscript(Expression exp)
	;

data Ident 
	= id(str name)
	;


anno loc Ident@location;
anno loc Module@location;
anno loc VarDecl@location;
anno loc TypeDecl@location;
anno loc ConstDecl@location;
anno loc Declarations@location;
anno loc Procedure@location;
anno loc Formal@location;
anno loc Field@location;
anno loc Type@location;
anno loc Statement@location;
anno loc Expression@location;
anno loc Selector@location;
