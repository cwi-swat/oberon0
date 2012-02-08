module ldta::oberon0::l1::Bind

import ldta::oberon0::l1::AST;
import ldta::oberon0::l1::Scope;
import IO;
import Message;

public Message dupErr(loc l) = error("Redeclared identifier", l);
public Message undefTypeErr(loc l) = error("Undefined type", l);
public Message undefIdErr(loc l) = error("Undefined identifier", l);
public Message undefVarErr(loc l) = error("Undefined variable", l);
public Message undefVarOrConstErr(loc l) = error("Undefined variable/constant", l);
public Message undefConstErr(loc l) = error("Undefined constant", l);
public Message idMismatchErr(loc l) = error("Identifier mismatch", l);

public tuple[Module, set[Message]] bindModule(m:Module::\mod(n1, ds, list[Statement] b, n2), NEnv nenv) {
  <m.decls, nenv, errs> = bindDecls(ds, nenv, {});
  <m.body, errs> = bindStats(b, nenv, errs);
  errs += { idMismatchErr(n2@location) | n1 != n2 };
  return <m, errs>;
}

// Declarations
public tuple[Declarations, NEnv, set[Message]] bindDecls(ds:decls(list[ConstDecl] cds, list[TypeDecl] tds, list[VarDecl] vds), NEnv nenv, set[Message] errs) {
  <ds.consts, nenv, errs> = bindConsts(cds, nenv, errs);
  <ds.types, nenv, errs> = bindTypes(tds, nenv, errs);
  <ds.vars, nenv, errs> = bindVars(vds, nenv, errs);
  return <ds, nenv, errs>;
}

public tuple[list[ConstDecl], NEnv, set[Message]] bindConsts(list[ConstDecl] cds, NEnv nenv, set[Message] errs) {
  cds = for (cd <- cds) {
    <cd, nenv, errs> = bindConstDecl(cd, nenv, errs);
    append cd;
  }
  return <cds, nenv, errs>;
}

public tuple[list[TypeDecl], NEnv, set[Message]] bindTypes(list[TypeDecl] tds, NEnv nenv, set[Message] errs) {
  tds = for (td <- tds) {
    <td, nenv, errs> = bindTypeDecl(td, nenv, errs);
    append td;
  }
  return <tds, nenv, errs>;
}

public tuple[list[VarDecl], NEnv, set[Message]] bindVars(list[VarDecl] vds, NEnv nenv, set[Message] errs) {
  vds = for (vd <- vds) {
    <vd, nenv, errs> = bindVarDecl(vd, nenv, errs);
    append vd;
  } 
  return <vds, nenv, errs>;
}
  
public tuple[NEnv, set[Message]] declare(Ident n, Decl b, NEnv nenv, set[Message] errs) {
  if (isDefined(nenv, n))
    return <nenv, errs + dupErr(b.location)>;
  return <define(nenv, n, b), errs>;
}

public tuple[ConstDecl, NEnv, set[Message]] bindConstDecl(cd:constDecl(n, e), NEnv nenv, set[Message] errs) {
  <cd.\value, errs> = bindExp(e, nenv, errs);
  <nenv, errs> = declare(n, const(cd@location, e), nenv, errs);
  return <cd, nenv, errs>;
}

public tuple[TypeDecl, NEnv, set[Message]] bindTypeDecl(td:typeDecl(n, t), NEnv nenv, set[Message] errs) {
  <td.\type, errs> = bindType(t, nenv, errs);
  <nenv, errs> = declare(n, \type(td@location, evalType(t, nenv)), nenv, errs);
  return <td, nenv, errs>;
}

public tuple[VarDecl, NEnv, set[Message]] bindVarDecl(vd:varDecl(ns, t), NEnv nenv, set[Message] errs) {
  <vd.\type, errs> = bindType(t, nenv, errs);
  for (n <- vd.names) {
    <nenv, errs> = declare(n, var(vd@location, evalType(t, nenv)), nenv, errs);
  }
  return <vd, nenv, errs>;
}

// Types

public tuple[Type, set[Message]] bindType(t:user(id("INTEGER")), NEnv nenv, set[Message] errs) = <t, errs>;
public tuple[Type, set[Message]] bindType(t:user(id("BOOLEAN")), NEnv nenv, set[Message] errs) = <t, errs>;
public default tuple[Type, set[Message]] bindType(t:user(x), NEnv nenv, set[Message] errs) {
  if (isVisible(nenv, x)) {
    d = getDef(nenv, x);
    t.name = x[@decl=d];
    return <t, errs>;
  }
  return <t, errs + { undefTypeErr(t@location) }>;
}

// Statements

public default tuple[list[Statement], set[Message]] bindStats(list[Statement] ss, NEnv nenv, set[Message] errs) {
  ss = for(s <- ss) {
    <s, errs> = bindStat(s, nenv, errs);
    append s;
  }
  return <ss, errs>;
}

// default: to be overridden in L4
public default tuple[Statement, set[Message]] bindStat(s:assign(x, e), NEnv nenv, set[Message] errs) {
  <s.exp, errs> = bindExp(e, nenv, errs);
  <s.var, errs> = bindId(x, nenv, errs);
  return <s, errs>;
}

public tuple[Statement, set[Message]] bindStat(s:ifThen(c, b, list[tuple[Expression condition, list[Statement] body]] eis, list[Statement] e), NEnv nenv, set[Message] errs) {
  <s.condition, errs> = bindExp(c, nenv, errs);
  <s.body, errs> = bindStats(b, nenv, errs);
  s.elseIfs = for (ei <- eis) {
    <ei.condition, errs> = bindExp(ei.condition, nenv, errs);
    <ei.body, errs> = bindStats(ei.body, nenv, errs);
    append ei;
  }
  <s.elsePart, errs> = bindStats(e, nenv, errs);
  return <s, errs>;
}

public tuple[Statement, set[Message]] bindStat(s:whileDo(c, b), NEnv nenv, set[Message] errs) {
  <s.condition, errs> = bindExp(c, nenv, errs);
  <s.body, errs> = bindStats(b, nenv, errs);
  return <s, errs>;
}

public tuple[Statement, set[Message]] bindStat(s:skip(), NEnv nenv, set[Message] errs) = <s, errs>;

public default tuple[Ident, set[Message]] bindId(Ident x, NEnv nenv, set[Message] errs) {
  if (x.name in {"TRUE", "FALSE"}) {
    x@decl=trueOrFalse(x.name == "TRUE");
    return <x, errs>; // no errors.
  }
  if (!isVisible(nenv, x)) {
    return <x, errs + { undefIdErr(x@location) }>;
  }
  d = getDef(nenv, x);
  return <x[@decl=d], errs>;
}

// Expressions (note the default :-(
public default tuple[Expression, set[Message]] bindExp(Expression e, NEnv nenv, set[Message] errs) {
  if (e has var) { 
    <e.var, errs> = bindId(e.var, nenv, errs);
    return <e, errs>;
  }
  return bindOperator(e, nenv, errs);
}

public tuple[Expression, set[Message]] bindOperator(Expression e, NEnv nenv, set[Message] errs) {
  if (e has exp) {
    <e.exp, errs> = bindExp(e.exp, nenv, errs);
    return <e, errs>;
  }
  if (e has lhs && e has rhs) {
    <e.lhs, errs> = bindExp(e.lhs, nenv, errs);
    <e.rhs, errs> = bindExp(e.rhs, nenv, errs);
    return <e, errs>;
  }
  return <e, errs>;
}

// partially evaluate a type.
public Type evalType(t:user(x), NEnv nenv) = 
  ( t | xt | isVisible(nenv, x), \type(_, xt) := getDef(nenv, x) ); 

public default Type evalType(Type t, NEnv nenv)  = t;

