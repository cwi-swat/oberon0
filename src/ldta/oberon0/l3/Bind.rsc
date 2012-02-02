module ldta::oberon0::l3::Bind

import ldta::oberon0::l3::AST;
import ldta::oberon0::l3::Scope;
extend ldta::oberon0::l2::Bind;

import IO;

public Message notAProcErr(loc l) = error("Not a procedure", l);
public Message undefProcErr(loc l) = error("Undefined procedure", l);


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

//// Global scope = nest((), scope((...builtins...)))
//public NEnv globalScope(s:nest(_, scope(_))) = s;
//public default NEnv globalScope(nest(_, p)) = globalScope(p);

public NEnv parentScope(nest(_, s)) = s; 

public tuple[Procedure, NEnv, set[Message]] bind(p:Procedure::proc(f, list[Formal] fs, ds, b, f1), NEnv nenv, set[Message] errs) {
  // TODO: what is the semantics of nested procs with the same name, shadowing or error?
  if (isDefined(nenv, f)) {
    return <p, nenv, errs + { dupErr(f@location) }>;
  }
  
  // TODO: review this again closely.
  
  
  // create new scope
  NEnv inner = nest((), nenv);
  
  // Declare the formal params in them
  <p.formals, inner, errs> = bind(fs, inner, errs);
  
  // Define a forward reference to this proc
  inner = define(inner, f, proc(f@location, p.formals));
  
  // Declare the decls
  <p.decls, inner, errs> = bind(ds, inner, errs);
  
  // Bind the body of the procedure in the inner scope
  <p.body, errs> = bind(b, inner, errs);
  
  // Make the proc visible to the outside.
  nenv = define(nenv, f, proc(f@location, p.formals));
  
  // Check the end keyword.
  errs += { idMismatchErr(f@location) | f1 != f };
 
  // Annotate the proc with its inner scope. 
  return <p[@scope=inner], nenv, errs>;
}

public tuple[list[Formal], NEnv, set[Message]] bind(list[Formal] fs, NEnv nenv, set[Message] errs) {
  fs = for (f <- fs) {
    <f.\type, errs> = bind(f.\type, nenv, errs);
    f.names = for (n <- f.names) {
      if (isDefined(nenv, n)) {  // always a param
        errs += { dupErr(n@location) };
      }
      else {
        ann = param(n@location, evalType(f.\type, nenv), f.hasVar);
        nenv = define(nenv, n, ann);
        n@decl = ann;
      }
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

