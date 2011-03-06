module lang::oberon0::l4::ast::Oberon0

extend lang::oberon0::l3::ast::Oberon0;

rule n1 assign(Ident v, Expression e) => assign(v, [], e);
rule n2 lookup(Ident v) => lookup(v, []);

data Type 
	= array(Expression exp, Type \type)
	| record(list[Field] fields)
	;

data Field 
	= field(list[Ident] names, Type \type)
	;
	
data Statement 
	= assign(Ident var, list[Selector] selectors, Expression exp)
	;

data Expression 
	= lookup(Ident var, list[Selector] selectors)
	;

data Selector 
	= field(Ident field)
	| subscript(Expression exp)
	;


