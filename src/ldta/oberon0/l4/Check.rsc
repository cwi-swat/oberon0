module ldta::oberon0::l4::Check

import ldta::oberon0::l4::AST;
extend ldta::oberon0::l3::Check;
import ldta::oberon0::l3::Scope;
import ldta::oberon0::l4::Bind; // for evalType

import List;
import IO;

public Message selectorErr(loc l) = error("Invalid selector", l);
public Message missingVarKeyword(loc l) = error("Missing VAR keyword", l);
public Message outOfBoundsErr(loc l) = error("Index out of bounds", l);
public Message boundErr(loc l) = error("Invalid bound", l);


public bool isLValue(lookup(x, _)) = isWritable(x@decl);
public bool isComplex(Expression e) = isComplex(typeOf(e));

public bool isComplex(Type t) = (t is array) || (t is record);

//// ignoring selectors here...
//public tuple[Expression, set[Message]] extendEvalConst(e:lookup(x, _), NEnv nenv, set[Message] errs) 
//  = <xe, errs> when isVisible(nenv, x), const(_, xe) := getDef(nenv, x);


public bool typeEq(Type t1, Type t2) = (t1@location) == (t2@location) 
   when (t1 is record && t2 is record) || (t1 is array && t2 is array);


// Override
public set[Message] checkFormals(list[Formal] fs) = 
  { missingVarKeyword(f@location)  | f <- fs, !f.hasVar, n <- f.names, isComplex((n@decl).\type) };   


// bprintln("<(a@location).begin.line> t1: <typeOf(lookup(x, ss))>, \n  t2= <typeOf(e)>")
public set[Message] check(a:assign(x, ss, e)) = check(e) + check(lookup(x,ss)) +
  { assignErr(a@location) |  isWritable(x@decl), !typeEq(typeOf(lookup(x, ss)), typeOf(e)) } +
  { notAVar(x@location) | !isWritable(x@decl) } +
  { invalidAssignErr(a@location) | isComplex(lookup(x, ss)) };

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

public set[Message] check(array(b, _), s:subscript(e)) = 
    { err | neg(nat(_)) := e  } +
    { err | nat(n) := e, nat(n2) := b, n >= n2  } +
    { err | lookup(x, []) := e, x@decl is const, nat(n) := x@decl.exp, nat(n2) := b, n >= n2 } +
    { err | lookup(x) := e, x@decl is const, nat(n) := x@decl.exp, nat(n2) := b, n >= n2  }       
  when err := outOfBoundsErr(s@location);

public default set[Message] check(Type _, Selector s) = { selectorErr(s@location) };

public set[Message] check(Selector::field(_)) = {}; 

public set[Message] check(s:subscript(e)) = check(e) + { intErr(e@location) | !isInt(typeOf(e)) };

public Type typeOf(lookup(x, ss)) = ( typeOf(lookup(x)) | typeOf(it, s) | s <- ss );

public Type typeOf(record(fs), s:Selector::field(x)) = f.\type
   when f <- fs, x in f.name;

public Type typeOf(array(e, t), subscript(_)) = t;

public default Type typeOf(Type _, Selector _) = INVALID();

