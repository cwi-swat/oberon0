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

private tuple[Case, set[Message]] bind(g:guard(e, b), NEnv nenv, set[Message] errs) {
  <g.guard, errs> = bind(e, nenv, errs);
  <g.body, errs> = bind(b, nenv, errs);
  return <g, errs>;
}