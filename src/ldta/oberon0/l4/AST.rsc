module ldta::oberon0::l4::AST

extend ldta::oberon0::l3::AST;

data Type 
	  = array(Expression exp, Type \type)
	  | record(list[Field] fields)
	  ;

data Field = field(list[Ident] names, Type \type);
	
data Statement = assign(Ident var, list[Selector] selectors, Expression exp);

data Expression = lookup(Ident var, list[Selector] selectors);

data Selector 
  = field(Ident field) 
  | subscript(Expression exp)
  ;

anno loc Selector@location;
