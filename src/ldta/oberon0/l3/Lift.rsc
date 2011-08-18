module ldta::oberon0::l3::Lift

import ldta::oberon0::l3::AST;
import ldta::oberon0::l3::Scope;
import ldta::oberon0::l2::Desugar;

import List;
import Set;

public Module lift(Module m, NEnv global, Module(Module) bind) {
  m = normalizeDecls(m);
  m = bind(extendSigs(desugar(m), freeVars(m)));
  return liftDecls(rename(m, global));
}

public Module normalizeDecls(Module m) = visit (m) {
    case decls(cds, tds, vds) => decls(cds, tds, vds, [])
  };

public Module liftDecls(Module mod) {
  visit (mod.decls.procs) {
    case Declarations decls: {
	      mod.decls.consts = decls.consts + mod.decls.consts;
	      mod.decls.types = decls.types + mod.decls.types;
	      mod.decls.procs += ( [] | it + liftProc(p) | p <- decls.procs );
	      decls.consts = [];
	      decls.types = [];
	      decls.procs = [];
	      insert decls;
    }
  }  
  
  atypes = [];
  mod = visit (mod) {
    case a:array(b, et): {
      n = id("array_<(a@location).offset>");
      atypes += [typeDecl(n, a)];
      insert user(n); 
    }
  }
  mod.decls.types += atypes;
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
      p.formals += [ formal(true, [x], (x@decl).\type) | x <- sort(toList(fv[f@location])) ];
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

