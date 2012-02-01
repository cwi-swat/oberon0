module ldta::oberon0::l4::Check

import ldta::oberon0::l4::AST;
extend ldta::oberon0::l3::Check;
import ldta::oberon0::l3::Scope;
import ldta::oberon0::l4::Bind; // for evalType

import List;
import IO;

// Currently the checker assume structural type equivalence for all types.

public Message selectorErr(loc l) = error("Invalid selector", l);
public Message undefFieldErr(loc l) = error("Undefined field", l);
public Message invalidAssignErr(loc l) = error("Invalid assignment", l);

public bool isLValue(lookup(x, _)) = !((x@decl) is const);
public bool isComplex(Expression e) = (typeOf(e) is array) || (typeOf(e) is record);

public set[Message] check(assign(x, ss, e)) = check(e) + check(lookup(x,ss)) +
  { assignErr(x@location) | typeOf(lookup(x, ss)) != typeOf(e) } +
  { invalidAssignErr(x@location) | isComplex(lookup(x, ss)) };
  

public set[Message] check(lookup(x, ss)) = check(typeOf(lookup(x)), ss);
  
public set[Message] check(Type t, list[Selector] ss) {
  errs = ( {} | it + check(s) | s <- ss );
  for (s <- ss) {
    errs += check(t, s);
    t = typeOf(t, s);
  } 
  return errs;
}
  
public set[Message] check(record(fs), s:Selector::field(x)) =
  { undefFieldErr(s@location) | !any(f <- fs, x in f.names) };

public set[Message] check(array(b, _), subscript(e)) = {};

public default set[Message] check(Type _, Selector s) = { selectorErr(s@location) };

public set[Message] check(Selector::field(_)) = {}; 

public set[Message] check(s:subscript(e)) = check(e) + { intErr(e@location) | !isInt(typeOf(e)) };

public Type typeOf(lookup(x, ss)) = ( typeOf(lookup(x)) | typeOf(it, s) | s <- ss );

public Type typeOf(record(fs), s:Selector::field(x)) {
  if (f <- fs, x in f.names) 
     return f.\type;
  return INVALID();
}

public Type typeOf(array(e, t), subscript(_)) = t;

public Type typeOf(Type _, Selector _) = INVALID();

