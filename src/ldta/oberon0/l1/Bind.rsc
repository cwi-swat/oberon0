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




public tuple[Module, set[Message]] bind(m:Module::\mod(n1, ds, list[Statement] b, n2), NEnv nenv) {
  <m.decls, nenv, errs> = bind(ds, nenv, {});
  <m.body, errs> = bind(b, nenv, errs);
  errs += { idMismatchErr(n2@location) | n1 != n2 };
  return <m, errs>;
}

// Declarations
public tuple[Declarations, NEnv, set[Message]] bind(ds:decls(list[ConstDecl] cds, list[TypeDecl] tds, list[VarDecl] vds), NEnv nenv, set[Message] errs) {
  <ds.consts, nenv, errs> = bind(cds, nenv, errs);
  <ds.types, nenv, errs> = bind(tds, nenv, errs);
  <ds.vars, nenv, errs> = bind(vds, nenv, errs);
  return <ds, nenv, errs>;
}

public tuple[list[ConstDecl], NEnv, set[Message]] bind(list[ConstDecl] cds, NEnv nenv, set[Message] errs) {
  cds = for (cd <- cds) {
    <cd, nenv, errs> = bind(cd, nenv, errs);
    append cd;
  }
  return <cds, nenv, errs>;
}

public tuple[list[TypeDecl], NEnv, set[Message]] bind(list[TypeDecl] tds, NEnv nenv, set[Message] errs) {
  list[TypeDecl] tds2;
  tds2 = for (td <- tds) {
    <td, nenv, errs> = bind(td, nenv, errs);
    append td;
  }
  return <tds2, nenv, errs>;
}

public tuple[list[VarDecl], NEnv, set[Message]] bind(list[VarDecl] vds, NEnv nenv, set[Message] errs) {
  vds = for (vd <- vds) {
    <vd, nenv, errs> = bind(vd, nenv, errs);
    append vd;
  } 
  return <vds, nenv, errs>;
}
  
public tuple[NEnv, set[Message]] declare(Ident n, Decl b, NEnv nenv, set[Message] errs) {
  if (isDefined(nenv, n))
    return <nenv, errs + dupErr(b.location)>;
  return <define(nenv, n, b), errs>;
}

public tuple[ConstDecl, NEnv, set[Message]] bind(cd:constDecl(n, e), NEnv nenv, set[Message] errs) {
  <cd.\value, errs> = bindConst(e, nenv, errs);
  <evc, errs> = evalConst(e, nenv, errs);
  <nenv, errs> = declare(n, const(cd@location, evc), nenv, errs);
  return <cd, nenv, errs>;
}

public tuple[TypeDecl, NEnv, set[Message]] bind(td:typeDecl(n, t), NEnv nenv, set[Message] errs) {
  <td.\type, errs> = bind(t, nenv, errs);
  <nenv, errs> = declare(n, \type(td@location, evalType(t, nenv)), nenv, errs);
  return <td, nenv, errs>;
}

public tuple[VarDecl, NEnv, set[Message]] bind(vd:varDecl(ns, t), NEnv nenv, set[Message] errs) {
  <vd.\type, errs> = bind(t, nenv, errs);
  for (n <- vd.names) {
    <nenv, errs> = declare(n, var(vd@location, evalType(t, nenv)), nenv, errs);
  }
  return <vd, nenv, errs>;
}

// Types

public tuple[Type, set[Message]] bind(t:user(id("INTEGER")), NEnv nenv, set[Message] errs) = <t, errs>;
public tuple[Type, set[Message]] bind(t:user(id("BOOLEAN")), NEnv nenv, set[Message] errs) = <t, errs>;
public default tuple[Type, set[Message]] bind(t:user(x), NEnv nenv, set[Message] errs) {
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

public tuple[list[Statement], set[Message]] bind(list[Statement] ss, NEnv nenv, set[Message] errs) {
  ss = for(s <- ss) {
    <s, errs> = bind(s, nenv, errs);
    append s;
  }
  return <ss, errs>;
}

public tuple[Statement, set[Message]] bind(s:assign(x, e), NEnv nenv, set[Message] errs) {
  <s.exp, errs> = bind(e, nenv, errs);
  <s.var, errs> = bindVar(x, nenv, errs);
  return <s, errs>;
}

public tuple[Ident, set[Message]] bindVar(Ident x, NEnv nenv, set[Message] errs) {
  if (isVisible(nenv, x)) {
    d = getDef(nenv, x);
    if (isWritable(d)) {
      return <x[@decl=d], errs>;
    }
    return <x, errs + { notAVarErr(x@location) }>;
  }
  return <x, errs + { undefVarErr(x@location) }>;
}

public tuple[Statement, set[Message]] bind(s:ifThen(c, b, list[tuple[Expression condition, list[Statement] body]] eis, list[Statement] e), NEnv nenv, set[Message] errs) {
  <s.condition, errs> = bind(c, nenv, errs);
  <s.body, errs> = bind(b, nenv, errs);
  s.elseIfs = for (ei <- eis) {
    <ei.condition, errs> = bind(ei.condition, nenv, errs);
    <ei.body, errs> = bind(ei.body, nenv, errs);
    append ei;
  }
  <s.elsePart, errs> = bind(e, nenv, errs);
  return <s, errs>;
}

public tuple[Statement, set[Message]] bind(s:whileDo(c, b), NEnv nenv, set[Message] errs) {
  <s.condition, errs> = bind(c, nenv, errs);
  <s.body, errs> = bind(b, nenv, errs);
  return <s, errs>;
}

public tuple[Statement, set[Message]] bind(s:skip(), NEnv nenv, set[Message] errs) = <s, errs>;

// Expressions (note the default :-(
public default tuple[Expression, set[Message]] bind(Expression e, NEnv nenv, set[Message] errs) {
  if (e has var) {
    x = e.var;
    if (isVisible(nenv, x)) {
      d = getDef(nenv, x);
      if (isReadable(d)) {
         e.var = x[@decl=d];
         return <e, errs>;
      }
      return <e, errs + { notAVarOrConstErr(x@location) }>;
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
         return <e, errs>;
      }
      return <e, errs + { notAConstErr(e@location) }>;
    }
    return <e, errs + { undefConstErr(e@location) }>;
  }
  return bindConstOperator(e, nenv, errs);
}

// TODO: factor bind vs. bindConst out of here...
public tuple[Expression, set[Message]] bindOperator(Expression e, NEnv nenv, set[Message] errs) {
  if (e has exp) {
    <e.exp, errs> = bind(e.exp, nenv, errs);
    return <e, errs>;
  }
  if (e has lhs && e has rhs) {
    <e.lhs, errs> = bind(e.lhs, nenv, errs);
    <e.rhs, errs> = bind(e.rhs, nenv, errs);
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
  e = innermost visit (e) {
    case pos(nat(a)) => nat(a)
    case neg(nat(a)) => nat(- a)
    case add(nat(a), nat(b)) => nat(a + b)
    case sub(nat(a), nat(b)) => nat(a - b)
    case mul(nat(a), nat(b)) => nat(a * b)
    case div(nat(a), nat(0)): return <e, errs + {divZeroErr(e@location)}>;
    case div(nat(a), nat(b)) => nat(a / b)
    case \mod(nat(a), nat(b)) => nat(a % b)
    case a:lookup(x) => xe when isVisible(nenv, x), const(_, xe) := getDef(nenv, x)
  }
  return <e, errs>;
}

// partially evaluate a type.
public Type evalType(t:user(x), NEnv nenv) {
  if (isVisible(nenv, x), \type(_, xt) := getDef(nenv, x)) {
    return xt;
  }
  return t;
}

public default Type evalType(Type t, NEnv nenv)  = t;

