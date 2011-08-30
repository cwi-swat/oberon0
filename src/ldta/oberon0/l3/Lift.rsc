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
  m = normalizeDecls(m);
  m = bind(extendSigs(desugar(m), freeVars(m)));
  return liftArrayTypes(liftDecls(rename(m, global)));
}

public Module normalizeDecls(Module m) = visit (m) {
    case decls(cds, tds, vds) => decls(cds, tds, vds, [])
  };


public Module liftDecls(Module mod) {
  gcs = [];
  gts = [];
  gps = [];
  mod = visit (mod) {
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
  mod.decls.consts = gcs;
  mod.decls.types = gts;
  mod.decls.procs = gps;
  return mod;
}

public Module liftArrayTypes(Module mod) {  
  atypesMap = ();
  mod = visit (mod) {
    case a:array(b, et): {
      if (k <- atypesMap, typeDecl(n2, a2) := atypesMap[k], a2 == a@ntype) {
        insert user(n2)[@location=a@location];
      }
      else {  
        n = id("array_<(a@location).offset>");
        atypesMap[a@location] = typeDecl(n, a@ntype);
        insert user(n)[@location=a@location];
      }
      
    }
  }
  atypes = [ atypesMap[l] | l <- atypesMap ];
  atypes += mod.decls.types;
  deps = { <t1, t2> | t1:typeDecl(x, _) <- atypes, t2 <- atypes , x in { y | /user(Ident y) <- t2.\type } };
  nodeps = toList(toSet(atypes) - carrier(deps));
  mod.decls.types = order(deps) + nodeps;
  return mod;
}

public rel[loc, Ident] freeVars(Module m) {
  result = {};
  globals = { x | vd <- m.decls.vars, x <- vd.names };

  set[Ident] freeVarsDecls(Declarations d) {
    fv = {};
    for (p <- d.procs) {
      fv += freeVars(p);
      result += {(p.name)@location} * fv; 
    }
    return fv;
  }
  
  set[Ident] freeVars(Procedure p) {
    fv = freeVarsDecls(p.decls) + { e.var | /Expression e <- p.body, e is lookup, !(((e.var)@decl) is const) }
       // assignments can never be consts (is caught by binding)
       + { s.var | /Statement s <- p.body, s is assign };
    return { x | x <- fv, !isDefined(p@scope, x) };
  }
  
  freeVarsDecls(m.decls);
  
  return result;
}

public Module extendSigs(Module m, rel[loc, Ident] fv) {
  return top-down visit (m) {
    case p:proc(f, fs, _, _, _): {
      p.formals += [ formal(true, [x], ((x@decl).\type)) | x <- sort(toList(fv[f@location])) ];
      insert p;
    }
    case c:call(f, as): {
      c.args += [ lookup(x) | x <- sort(toList(fv[(f@decl).location])) ];
      insert c;
    }
  }
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

