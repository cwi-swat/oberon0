module ldta::oberon0::l4::Bind

import ldta::oberon0::l4::AST;
extend ldta::oberon0::l3::Bind;

import IO;

public Message boundErr(loc l) = error("Invalid bound", l);

anno Type Type@ntype;

//public Statement assign(x, e) = assign(x, [], e);
//public Expression lookup(x) = lookup(x, []);

public tuple[Type, set[Message]] bind(t:array(e, t2), NEnv nenv, set[Message] errs) {
  <t.exp, errs> = bind(e, nenv, errs);
  <t.\type, errs> = bind(t2, nenv, errs);
  <c, errs> = evalConst(e, nenv, errs);
  errs += { notAConstErr(e@location) | nat(_) !:= c }
    + { boundErr(e@location) | nat(n) := c, n < 0 };
  return <t[@ntype=evalType(t, nenv)], errs>; 
}

public tuple[Type, set[Message]] bind(t:record(fs), NEnv nenv, set[Message] errs) {
  done = {};
  t.fields = for (f <- fs) {
    f.names = for (n <- f.names) {
      errs += { dupErr(n@location) | n in done };
      done += {n};
      append n;
    }      
    <f.\type, errs> = bind(f.\type, nenv, errs);
    append f;
  }
  return <t[@ntype=evalType(t, nenv)], errs>;
}


public tuple[Statement, set[Message]] bind(s:assign(x, list[Selector] ss, e), NEnv nenv, set[Message] errs) {
  <s.exp, errs> = bind(e, nenv, errs);
  <s.selectors, errs> = bind(ss, nenv, errs);
  if (isVisible(nenv, x)) {
    d = getDef(nenv, x);
    if (isWritable(d)) {
      s.var = x[@decl=d];
      return <s, errs>;
    }
    return <s, errs + { notAVarErr(x@location) }>;
  }
  return <s, errs + { undefVarErr(x@location) }>;
}


public tuple[Expression, set[Message]] bind(e:lookup(x, list[Selector] ss), NEnv nenv, set[Message] errs) {
  <e2, errs> = bind(lookup(x), nenv, errs);
  e.var = e2.var;
  <e.selectors, errs> = bind(ss, nenv, errs);
  return <e, errs>;
}


public tuple[list[Selector], set[Message]] bind(list[Selector] ss, NEnv nenv, set[Message] errs) {
  ss = for (s <- ss) {
    <s, errs> = bind(s, nenv, errs);
    append s;
  }
  return <ss, errs>;
}	  

public tuple[Selector, set[Message]] bind(s:Selector::field(x), NEnv nenv, set[Message] errs) = <s, errs>;
public tuple[Selector, set[Message]] bind(s:subscript(e), NEnv nenv, set[Message] errs) {
  <s.exp, errs> = bind(e, nenv, errs);
  return <s, errs>;
}

public Type evalType(a:array(e, t), NEnv nenv) {
  <c, _> = evalConst(e, nenv, {}); 
  return array(c, evalType(t, nenv))[@location=a@location];
}

// Flatten field lists.
public Type evalType(r:record(fs), NEnv nenv) =
  record([ field([n], evalType(t, nenv)) | field(ns, t) <- fs, n <- ns ])[@location=r@location];  
  
