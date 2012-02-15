module ldta::oberon0::l3::Lift

import ldta::oberon0::l3::AST;
import ldta::oberon0::l3::Scope;

import List;
import Set;
import Graph;
import Relation;
import util::Math;

// TODO remove this
anno Type Type@ntype;

// presumes m to have been desugared.
public Module lift(Module m) = liftDecls(rename(normalizeDecls(m)));

public Module normalizeDecls(Module m) = visit (m) {
    case decls(cds, tds, vds) => decls(cds, tds, vds, [])
  };


public Module liftDecls(Module m) {
  gcs = [];
  gts = [];
  gps = [];
  m = visit (m) {
    case Declarations decls: {
      gcs += decls.consts;
      gts += decls.types;
      gps = ( gps | it + liftProc(p) | p <- decls.procs );
      insert decls[const=[]][types=[]][procs=[]];
    }
  }
  m.decls.consts = gcs;
  m.decls.types = gts;
  m.decls.procs = gps;
  return m;
}

public list[Procedure] liftProc(Procedure proc) {
  newProcs = ( [] | it + liftProc(p) | p <- proc.decls.procs );
  proc.decls.procs = [];
  return newProcs + [proc];
}

public str suffix(loc l) = "_<abs(l.offset)>";

public Module rename(Module m, NEnv global) {
  // todo: check that @decl is there
  Ident prime(Ident x) = id("<x.name><(x@decl).location.offset>")
                          [@decl=x@decl][@location=x@location];
  return visit (m) {
    case c:call(x, as) => call(prime(x))
       when !isDefined(global, x)
    case p:proc(x, fs, ds, b, f2) => proc(prime(x), fs, ds, b, f2)[@scope=p@scope]
    case constDecl(x, e) => constDecl(prime(x), e)
    case typeDecl(x, t) => typeDecl(prime(x), t)
    case user(x) => user(prime(x))
      when (x@decl)?, \type(l, _) := x@decl
    case lookup(x) => Lookup(prime(x))
      when const(l, _) := x@decl
  };
}

