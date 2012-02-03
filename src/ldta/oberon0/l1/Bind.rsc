module ldta::oberon0::l1::Bind

import ldta::oberon0::l1::AST;
import ldta::oberon0::l1::Scope;
import IO;
import Message;

public Message dupErr(loc l) = error("Redeclared identifier", l);
public Message undefTypeErr(loc l) = error("Undefined type", l);
public Message undefVarErr(loc l) = error("Undefined variable", l);
public Message undefVarOrConstErr(loc l) = error("Undefined variable/constant", l);
public Message undefConstErr(loc l) = error("Undefined constant", l);
public Message notATypeErr(loc l) = error("Not a type", l);
public Message notAVarErr(loc l) = error("Not a variable", l);
public Message notAVarOrConstErr(loc l) = error("Not a variable/constant", l);
public Message notAConstErr(loc l) = error("Not a constant", l);
public Message idMismatchErr(loc l) = error("Identifier mismatch", l);
public Message divZeroErr(loc l) = error("Division by zero", l);

public bool isWritable(var(_, _)) = true;
public default bool isWritable(Decl _) = false;

public bool isReadable(var(_, _)) = true;
public bool isReadable(const(_, _)) = true;
public default bool isReadable(Decl _) = false;




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
  <cd.\value, errs> = bindConst(e, nenv, errs);
  <evc, errs> = evalConst(e, nenv, errs);
  <nenv, errs> = declare(n, const(cd@location, evc), nenv, errs);
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
    if (d is \type) {
      t.name = x[@decl=d];
      return <t, errs>;
    }
    return <t, errs + { notATypeErr(t@location) }>;
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
  <s.var, errs> = bindVar(x, nenv, errs);
  return <s, errs>;
}

// default: to be overridden in L3
public default tuple[Ident, set[Message]] bindVar(Ident x, NEnv nenv, set[Message] errs) {
  if (!isVisible(nenv, x)) {
    return <x, errs + { undefVarErr(x@location) }>;
  }
  d = getDef(nenv, x);
  if (!isWritable(d)) {
    return <x, errs + { notAVarErr(x@location) }>;
  }
  return <x[@decl=d], errs>;
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

// Expressions (note the default :-(
// NB: this shares too much with bindVar and bindConst
public default tuple[Expression, set[Message]] bindExp(Expression e, NEnv nenv, set[Message] errs) {
  // Propagate constants
  <evc, errs> = evalConst(e, nenv, errs);
  e@propagated = evc;
  if (e has var) { // lookup expressions
    x = e.var;
    if (isVisible(nenv, x)) {
      d = getDef(nenv, x);
      if (isReadable(d)) {
         e.var = x[@decl=d];
         return <e, errs>;
      }
      return <e, errs + { notAVarOrConstErr(x@location) }>;
    }
    if (x.name in {"TRUE", "FALSE"}) {
      e.var = x[@decl=trueOrFalse(x.name == "TRUE")];
      return <e, errs>; // no errors.
    }
    return <e, errs + { undefVarOrConstErr(x@location) }>;
  }
  
  return bindOperator(e, nenv, errs);
}

public tuple[Expression, set[Message]] bindConst(Expression e, NEnv nenv, set[Message] errs) {  
  if (e has var) {
    x = e.var;
    if (isVisible(nenv, x)) {
      b = getDef(nenv, x);
      if (b is const) {
         e.var = x[@decl=b];
         e@propagated = b.exp;
         return <e, errs>;
      }
      return <e, errs + { notAConstErr(e@location) }>;
    }
    if (x.name in {"TRUE", "FALSE"}) {
      e.var = x[@decl=trueOrFalse(x.name == "TRUE")];
      return <e, errs>; // no errors
    } 
    return <e, errs + { undefConstErr(e@location) }>;
  }
  return bindConstOperator(e, nenv, errs);
}

// TODO: factor bind vs. bindConst out of here...
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

public tuple[Expression, set[Message]] bindConstOperator(Expression e, NEnv nenv, set[Message] errs) {
  if (e has exp) {
    <e.exp, errs> = bindConst(e.exp, nenv, errs);
    return <e, errs>;
  }
  if (e has lhs && e has rhs) {
    <e.lhs, errs> = bindConst(e.lhs, nenv, errs);
    <e.rhs, errs> = bindConst(e.rhs, nenv, errs);
    return <e, errs>;
  }
  return <e, errs>;
}
  
// Partially evaluate const exp
public tuple[Expression,set[Message]] evalConst(Expression e, NEnv nenv, set[Message] errs) {
  solve (e) {
    e = visit (e) {
      case pos(nat(a)) => nat(a)
      case neg(nat(a)) => nat(- a)
      case add(nat(a), nat(b)) => nat(a + b)
      case sub(nat(a), nat(b)) => nat(a - b)
      case mul(nat(a), nat(b)) => nat(a * b)
      case div(nat(a), nat(0)): return <e, errs + {divZeroErr(e@location)}>;
      case div(nat(a), nat(b)) => nat(a / b)
      case \mod(nat(a), nat(0)): return <e, errs + {divZeroErr(e@location)}>;
      case \mod(nat(a), nat(b)) => nat(a mod b)
      case a:lookup(x) => xe when isVisible(nenv, x), const(_, xe) := getDef(nenv, x)
      case Expression x: {
         <x, errs> =  extendEvalConst(x, nenv, errs); // UGH
         insert x;
      }
    }
  }
  return <e, errs>;
}

public default tuple[Expression, set[Message]] extendEvalConst(Expression e, NEnv nenv, set[Message] errs)
  = <e, errs>;

// partially evaluate a type.
public Type evalType(t:user(x), NEnv nenv) {
  if (isVisible(nenv, x), \type(_, xt) := getDef(nenv, x)) {
    return xt;
  }
  return t;
}

public default Type evalType(Type t, NEnv nenv)  = t;

