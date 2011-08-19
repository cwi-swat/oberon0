module ldta::oberon0::l3::Bind

import ldta::oberon0::l3::AST;
import ldta::oberon0::l3::Scope;

extend ldta::oberon0::l2::Bind;

import IO;

public Message notAProcErr(loc l) = error(l, "Not a procedure");
public Message undefProcErr(loc l) = error(l, "Undefined procedure");


public bool isReadable(param(_, _, _)) = true;
public bool isWritable(param(_, _, _)) = true;

// Normalize decls
//public Declarations decls(cds, tds, vds) = decls(cds, tds, vds, []);

public tuple[Declarations, NEnv, set[Message]] bind(ds:decls(list[ConstDecl] cds, list[TypeDecl] tds, list[VarDecl] vds, list[Procedure] pds), NEnv nenv, set[Message] errs) {
  <ds.consts, nenv, errs> = bind(cds, nenv, errs);
  <ds.types, nenv, errs> = bind(tds, nenv, errs);
  <ds.vars, nenv, errs> = bind(vds, nenv, errs);
  <ds.procs, nenv, errs> = bind(pds, nenv, errs);
  return <ds, nenv, errs>;
}

public tuple[list[Procedure], NEnv, set[Message]] bind(list[Procedure] ps, NEnv nenv, set[Message] errs) {
  ps = for (p <- ps) {
    <p, nenv, errs> = bind(p, nenv, errs);
    append p;
  }
  return <ps, nenv, errs>;
}

public list[Formal] flatten(list[Formal] fs, NEnv nenv) = 
  [ formal(hv, [n], evalType(t, nenv)) | formal(hv, ns, t) <- fs, n <- ns ]; 

public tuple[Procedure, NEnv, set[Message]] bind(p:Procedure::proc(f, list[Formal] fs, ds, b, f1), NEnv nenv, set[Message] errs) {
  // TODO: what is the semantics of nested procs with the same name, shadowing or error?
  //if (isDefined(nenv, f)) {
  //  return <p, errs + { dupErr(f@location) }>;
  //}
  outer = define(nenv, f, proc(f@location, flatten(fs, nenv)));
  inner = nest((), outer);
  <p.formals, inner, errs> = bind(fs, inner, errs);
  <p.decls, inner, errs> = bind(ds, inner, errs);
  <p.body, errs> = bind(b, inner, errs);
  errs += { idMismatchErr(f1@location) | f1 != f };
  return <p[@scope=inner], outer, errs>;
}

public tuple[list[Formal], NEnv, set[Message]] bind(list[Formal] fs, NEnv nenv, set[Message] errs) {
  fs = for (f <- fs) {
    <f.\type, errs> = bind(f.\type, nenv, errs);
    f.names = for (n <- f.names) {
      if (isDefined(nenv, n))  // always a param
        errs += { dupErr(n@location) };
      else 
        nenv = define(nenv, n, param(n@location, evalType(f.\type, nenv), f.hasVar));
      append n;
    }
    append f;
  }
  return <fs, nenv, errs>;
}

public tuple[Statement, set[Message]] bind(s:call(f, as), NEnv nenv, set[Message] errs) {
  s.args = for (a <- as) {
    <a, errs> = bind(a, nenv, errs);
    append a;
  }
  if (isVisible(nenv, f)) {
    d = getDef(nenv, f);
    if (d is proc) {
      s.proc = f[@decl=d];
      return <s, errs>;
    }
    return <s, errs + { notAProcErr(f@location) }>;
  }
  return <s, errs + { undefProcErr(f@location) }>;
}
