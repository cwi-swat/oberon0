module lang::oberon0::l3::ast::Oberon0

import lang::oberon0::l2::ast::Oberon0;

rule n1 decls(list[ConstDecl] consts, list[TypeDecl] types, list[VarDecl] vars) => decls(consts, types, vars, []);

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
