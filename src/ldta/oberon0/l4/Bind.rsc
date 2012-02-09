module ldta::oberon0::l4::Bind

import ldta::oberon0::l4::AST;
extend ldta::oberon0::l3::Bind;

import IO;

public Message invalidSelectorErr(loc l) = error("Invalid selector", l);
public Message undefFieldErr(loc l) = error("Undefined field", l);
public Message invalidAssignErr(loc l) = error("Invalid assignment", l);

public tuple[Type, set[Message]] bindType(t:array(e, t2), NEnv nenv, set[Message] errs) {
  <t.exp, errs> = bindExp(e, nenv, errs);
  <t.\type, errs> = bindType(t2, nenv, errs);
  //<c, errs> = evalConst(t.exp, nenv, errs);
  //errs += { notAConstErr(e@location) | nat(_) !:= c }
  //  + { boundErr(e@location) | nat(n) := c, n < 0 };
  return <t, errs>; 
}

public tuple[Type, set[Message]] bindType(t:record(fs), NEnv nenv, set[Message] errs) {
  done = {};
  t.fields = for (f <- fs) {
    if (f is empty) {
       continue;
    }
    f.names = for (n <- f.names) {
      errs += { dupErr(n@location) | n in done };
      done += {n};    
      append n;
    }      
    <f.\type, errs> = bindType(f.\type, nenv, errs);
    append f;
  }
  return <t, errs>;
}

public tuple[Statement, set[Message]] bindStat(s:assign(x, list[Selector] ss, e), NEnv nenv, set[Message] errs) {
  <s.var, errs> = bindId(x, nenv, errs);
  <s.exp, errs> = bindExp(e, nenv, errs);
  <s.selectors, errs, t> = bindSelectors(ss, nenv, errs, (s.var)@decl.\type);
  return <s, errs>;
}


public tuple[Expression, set[Message]] bindExp(e:lookup(x, list[Selector] ss), NEnv nenv, set[Message] errs) {
  <e.var, errs> = bindId(x, nenv, errs);
  // what if there is no .\type ?
  <e.selectors, errs, t> = bindSelectors(ss, nenv, errs, (e.var@decl).\type);
  return <e, errs>;
}


public tuple[list[Selector], set[Message], Type] bindSelectors(list[Selector] ss, NEnv nenv, set[Message] errs, Type t) {
  ss = for (s <- ss) {
    <s, errs, t> = bindSelector(s, nenv, errs, t);
    append s;
  }
  return <ss, errs, t>;
}	  

public tuple[Selector, set[Message], Type] bindSelector(s:Selector::field(x), NEnv nenv, set[Message] errs, Type t) {
  if (t is record) {
    if (f <- t.fields, x in f.names) {
      return <s, errs, f.\type>; // TODO: annotate selector with type?
    }
    return <s, errs + { undefFieldErr(s@location) }, INVALID()>; 
  }
  return  <s, errs + { invalidSelectorErr(s@location) }, INVALID()>;
}

public tuple[Selector, set[Message], Type] bindSelector(s:subscript(e), NEnv nenv, set[Message] errs, Type t) {
  if (t is array) {
    <s.exp, errs> = bindExp(e, nenv, errs);
    return <s, errs, t.\type>;
  }
  return <s, errs + { invalidSelectorErr(s@location) }, INVALID()>; 
}

//public Type evalType(a:array(e, t), NEnv nenv) {
//  <c, _> = evalConst(e, nenv, {}); 
//  return array(c, evalType(t, nenv))[@location=a@location];
//}
//
//
//// Flatten field lists.
//public Type evalType(r:record(fs), NEnv nenv) =
//  record([ field([n], evalType(t, nenv)) | field(ns, t) <- fs, n <- ns ])[@location=r@location];  
//  
