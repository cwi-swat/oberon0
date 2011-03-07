module lang::oberon0::l1::resolve::Types

import lang::oberon0::l1::ast::Oberon0;

import List;

data OType =
	  Integer()
	| Boolean()
	| User(Ident typeName)
	| Invalid()
	;
	
public str prettyPrint(Integer()) = "INTEGER";
public str prettyPrint(Boolean()) = "INTEGER";
public str prettyPrint(User(r)) = n.name;
public str prettyPrint(Invalid()) = "INVALID TYPE";

