module ldta::oberon0::l3::Bind

import ldta::oberon0::l3::AST;
import ldta::oberon0::l3::Scope;
extend ldta::oberon0::l2::Bind;

import IO;
import Type;

public NEnv GLOBALS() = nest((), scope((
  id("Write"): proc(|file://-|,[
     formal(false, [id("x")[
        @decl=param(|file://-|, user(id("INTEGER")), false)
     ]], user(id("INTEGER")))
  ]),
  id("Read"): proc(|file://-|,[
     formal(true, [id("x")[
        @decl=param(|file://-|, user(id("INTEGER")), true)
     ]], user(id("INTEGER")))
  ]),
  id("WriteLn"): proc(|file://-|,[])
)));

public Message undefProcErr(loc l) = error("Undefined procedure", l);
public Message notAProcErr(loc l) = error("Not a procedure", l);

public bool isCallable(Decl::proc(_, _)) = true;
public default bool isCallable(Decl _) = false;


public bool isReadable(param(_, _, _)) = true;
public bool isWritable(param(_, _, _)) = true;

public tuple[Declarations, NEnv, set[Message]] bindDecls(ds:decls(list[ConstDecl] cds, list[TypeDecl] tds, list[VarDecl] vds, list[Procedure] pds), NEnv nenv, set[Message] errs) {
  <ds.consts, nenv, errs> = bindConsts(cds, nenv, errs);
  <ds.types, nenv, errs> = bindTypes(tds, nenv, errs);
  <ds.vars, nenv, errs> = bindVars(vds, nenv, errs);
  <ds.procs, nenv, errs> = bindProcs(pds, nenv, errs);
  return <ds, nenv, errs>;
}

public default tuple[list[Procedure], NEnv, set[Message]] bindProcs(list[Procedure] ps, NEnv nenv, set[Message] errs) {
  ps = for (p <- ps) {
    <p, nenv, errs> = bindProc(p, nenv, errs);
    append p;
  }
  return <ps, nenv, errs>;
}

//// Global scope = nest((), scope((...builtins...)))
public NEnv globalScope(s:nest(_, scope(_))) = s;
public default NEnv globalScope(nest(_, p)) = globalScope(p);

public NEnv builtinScope(s:scope(_)) = s;
public NEnv builtinScope(nest(_, p)) = builtinScope(p);

public NEnv parentScope(nest(_, s)) = s; 

public tuple[Procedure, NEnv, set[Message]] bindProc(p:Procedure::proc(f, list[Formal] fs, ds, b, f1), NEnv nenv, set[Message] errs) {
  if (isDefined(nenv, f)) {
    return <p, nenv, errs + { dupErr(f@location) }>;
  }
  
  // create new scope
  NEnv inner = nest((), nenv);
  
  // Declare the formal params in them
  <p.formals, inner, errs> = bindFormals(fs, inner, errs);
  
  // Define a forward reference to this proc
  inner = define(inner, f, proc(f@location, p.formals));
  
  // Declare the decls
  <p.decls, inner, errs> = bindDecls(ds, inner, errs);
  
  // Bind the body of the procedure in the inner scope
  <p.body, errs> = bindStats(b, inner, errs);
  
  // Make the proc visible to the outside.
  nenv = define(nenv, f, proc(f@location, p.formals));
  
  // Check the end keyword.
  errs += { idMismatchErr(f@location) | f1 != f };
 
  // Annotate the proc with its inner scope. 
  return <p[@scope=inner], nenv, errs>;
}

public tuple[list[Formal], NEnv, set[Message]] bindFormals(list[Formal] fs, NEnv nenv, set[Message] errs) {
  fs = for (f <- fs) {
    <f.\type, errs> = bindType(f.\type, nenv, errs);
    f.names = for (n <- f.names) {
      if (isDefined(nenv, n)) {  // always a param
        errs += { dupErr(n@location) };
      }
      else {
        ann = param(n@location, f.\type, f.hasVar);
        nenv = define(nenv, n, ann);
        n@decl = ann;
      }
      append n;
    }
    append f;
  }
  return <fs, nenv, errs>;
}


// overriding from L1
public tuple[Ident, set[Message]] bindId(Ident x, NEnv nenv, set[Message] errs) {
  if (isVisible(nenv, x)) {
    d = getDef(nenv, x);
    if (d is var && !(isDefined(nenv, x) || isDefined(globalScope(nenv), x))) {
      return <x, errs + { undefVarErr(x@location) }>;
    }
    return <x[@decl=getDef(nenv, x)], errs>;
  }
  if (x.name in {"TRUE", "FALSE"}) {
    return <x[@decl=trueOrFalse(x.name == "TRUE")], errs>;
  }
  return <x, errs + { undefIdErr(x@location) }>;
}

public tuple[Statement, set[Message]] bindStat(s:call(f, as), NEnv nenv, set[Message] errs) {
  s.args = for (a <- as) {
    <a, errs> = bindExp(a, nenv, errs);
    append a;
  }
  if (!isVisible(nenv, f)) {
    return <s, errs + { undefProcErr(f@location) }>;
  }
  if (isDefined(nenv, f) || isDefined(globalScope(nenv), f) || isDefined(builtinScope(nenv), f)) {
    d = getDef(nenv, f);
    if (!isCallable(d)) {
      return <s, errs + { notAProcErr(f@location) }>;
    }
    s.proc = f[@decl=d];
    return <s, errs>;
  }
  return <s, errs + { notAProcErr(f@location) }>;
}

