module ldta::oberon0::l2::Bind

import ldta::oberon0::l2::AST;
extend ldta::oberon0::l1::Bind;

// page 29 of Wirth's book shows an example where i is a declared variable used by For.
// We deduce from this that for-variables should be declared.
public tuple[Statement, set[Message]] bind(s:forDo(i, f, t, b, ss), NEnv nenv, set[Message] errs) {
  <s.name, errs> = bindVar(i, nenv, errs);
  <s.from, errs> = bind(f, nenv, errs);
  <s.to, errs> = bind(t, nenv, errs);
  if (e <- b) {
    <e, errs> = bind(e, nenv, errs);
    errs += checkConst(e, nenv);
    s.by = [e];
  }
  <s.body, errs> = bind(ss, nenv, errs);
  return <s, errs>;
}

public set[Message] checkConst(Expression e, NEnv nenv) = 
  { notAConstErr(e@location) | nat(_) !:= evalConst(e, nenv) };

public tuple[Statement, set[Message]] bind(s:caseOf(e, cs, es), NEnv nenv, set[Message] errs) {
  <s.exp, errs> = bind(e, nenv, errs);
  s.cases = for (c <- cs) {
    <c, errs> = bind(c, nenv, errs);
    append c;
  }
  <s.elsePart, errs> = bind(es, nenv, errs);
  return <s, errs>;
}

public tuple[Case, set[Message]] bind(g:guard(ls, b), NEnv nenv, set[Message] errs) {
  <g.labels, errs> = bind(ls, nenv, errs);
  <g.body, errs> = bind(b, nenv, errs);
  return <g, errs>;
}


public tuple[list[Label], set[Message]] bind(list[Label] ls, NEnv nenv, set[Message] errs) {
  ls = for (l <- ls) {
    <l, errs> = bind(l, nenv, errs);
    append l;
  }
  return <ls, errs>;
}

public tuple[Label, set[Message]] bind(l:expression(e), NEnv nenv, set[Message] errs) {
  <l.exp, errs> = bind(e, nenv, errs);
  return <l, errs>;
}

public tuple[Label, set[Message]] bind(l:range(e1, e2), NEnv nenv, set[Message] errs) {
  <l.from, errs> = bind(e1, nenv, errs);
  <l.to, errs> = bind(e2, nenv, errs);
  return <l, errs>;  
}

