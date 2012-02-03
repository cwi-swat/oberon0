module ldta::oberon0::l2::Bind

import ldta::oberon0::l2::AST;
extend ldta::oberon0::l1::Bind;

// page 29 of Wirth's book shows an example where i is a declared variable used by For.
// We deduce from this that for-variables should be declared.
public tuple[Statement, set[Message]] bindStat(s:forDo(i, f, t, b, ss), NEnv nenv, set[Message] errs) {
  <s.name, errs> = bindVar(i, nenv, errs);
  <s.from, errs> = bindExp(f, nenv, errs);
  <s.to, errs> = bindExp(t, nenv, errs);
  if (e <- b) {
    <e, errs> = bindExp(e, nenv, errs); // TODO: bindConst?
    errs = checkConst(e, nenv, errs);
    s.by = [e];
  }
  <s.body, errs> = bindStats(ss, nenv, errs);
  return <s, errs>;
}

public set[Message] checkConst(Expression e, NEnv nenv, set[Message] errs) {
  <c, errs> = evalConst(e, nenv, errs); 
  e@propagated = c;
  return errs + { notAConstErr(e@location) | nat(_) !:= c };
}

public tuple[Statement, set[Message]] bindStat(s:caseOf(e, cs, es), NEnv nenv, set[Message] errs) {
  <s.exp, errs> = bindExp(e, nenv, errs);
  s.cases = for (c <- cs) {
    <c, errs> = bindCase(c, nenv, errs);
    append c;
  }
  <s.elsePart, errs> = bindStats(es, nenv, errs);
  return <s, errs>;
}

public tuple[Case, set[Message]] bindCase(g:guard(ls, b), NEnv nenv, set[Message] errs) {
  <g.labels, errs> = bindLabels(ls, nenv, errs);
  <g.body, errs> = bindStats(b, nenv, errs);
  return <g, errs>;
}

public tuple[list[Label], set[Message]] bindLabels(list[Label] ls, NEnv nenv, set[Message] errs) {
  ls = for (l <- ls) {
    <l, errs> = bindLabel(l, nenv, errs);
    append l;
  }
  return <ls, errs>;
}

public tuple[Label, set[Message]] bindLabel(l:expression(e), NEnv nenv, set[Message] errs) {
  <l.exp, errs> = bindExp(e, nenv, errs);
  errs = checkConst(e, nenv, errs);
  return <l, errs>;
}

public tuple[Label, set[Message]] bindLabel(l:range(e1, e2), NEnv nenv, set[Message] errs) {
  <l.from, errs> = bindExp(e1, nenv, errs);
  <l.to, errs> = bindExp(e2, nenv, errs);
  errs = checkConst(e1, nenv, errs);
  errs = checkConst(e2, nenv, errs);
  return <l, errs>;  
}

