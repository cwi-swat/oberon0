module ldta::oberon0::l3::AST

extend ldta::oberon0::l2::AST;

data Declarations 
	= decls(list[ConstDecl] consts, list[TypeDecl] types, list[VarDecl] vars, list[Procedure] procs)
	;

data Procedure 
	= proc(Ident name, list[Formal] formals, Declarations decls, list[Statement] body, Ident endName)
	;

data Formal 
	= formal(bool hasVar, list[Ident] names, Type \type)
	;


data Statement 
	= call(Ident proc, list[Expression] args)
	;

anno loc Procedure@location;
anno loc Formal@location;
