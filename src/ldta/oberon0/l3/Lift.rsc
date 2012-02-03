module ldta::oberon0::l3::Lift

import ldta::oberon0::l3::AST;
import ldta::oberon0::l3::Scope;
import ldta::oberon0::l2::Desugar;


import List;
import Set;
import Graph;
import IO;
import Relation;

// TODO remove this
anno Type Type@ntype;

public Module lift(Module m, NEnv global, Module(Module) bind) {
  println("Lifting");
  return liftDecls(rename(bind(desugar(normalizeDecls(m))), global));
}

public Module normalizeDecls(Module m) = visit (m) {
    case decls(cds, tds, vds) => decls(cds, tds, vds, [])
  };


public Module liftDecls(Module \mod) {
  gcs = [];
  gts = [];
  gps = [];
  \mod = visit (\mod) {
    case Declarations decls: {
	      gcs += decls.consts;
	      gts += decls.types;
	      gps = ( gps | it + liftProc(p) | p <- decls.procs );
	      decls.consts = [];
	      decls.types = [];
	      decls.procs = [];
	      insert decls;
    }
  }
  \mod.decls.consts = gcs;
  \mod.decls.types = gts;
  \mod.decls.procs = gps;
  return \mod;
}

public list[Procedure] liftProc(Procedure proc) {
  newProcs = ( [] | it + liftProc(p) | p <- proc.decls.procs );
  proc.decls.procs = [];
  return newProcs + [proc];
}

public Module rename(Module m, NEnv global) {
  return visit (m) {
    case c:call(x:id(s), as) => call(id("<s>_<(x@decl).location.offset>")[@decl=x@decl][@location=x@location], as)
       when !isDefined(global, x)
    case p:proc(x:id(s), fs, ds, b, f2) => proc(id("<s>_<(x@location).offset>")[@location=x@location], fs, ds, b, f2)[@scope=p@scope]
    case constDecl(x:id(s), e) => constDecl(id("<s>_<(x@location).offset>")[@location=x@location], e)
    case typeDecl(x:id(s), t) => typeDecl(id("<s>_<(x@location).offset>")[@location=x@location], t)
    case user(x:id(s)) => user(id("<s>_<l.offset>")[@decl=x@decl])
      when (x@decl)?, \type(l, _) := x@decl
    case lookup(x:id(s)) => lookup(id("<s>_<l.offset>")[@decl=x@decl])
      when const(l, _) := x@decl
  };
}

