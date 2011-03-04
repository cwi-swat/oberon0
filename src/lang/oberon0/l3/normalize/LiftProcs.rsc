module lang::oberon0::l3::normalize::LiftProcs

import lang::oberon0::l3::ast::Oberon0;
import List;
import Set;
import Map;

alias Variables = map[Ident, Type];

alias SortedVariables = list[tuple[Ident, Type]];

alias FreeVarsMap = map[Ident, Variables];

alias SortedFreeVarsMap = map[Ident, SortedVariables];

public Module liftProcs(Module mod) {
	mod.decls.procs = ( [] | it + liftProc(p) | p <- mod.decls.procs );
	return mod;
}

public list[Procedure] liftProc(Procedure proc) {
	newProcs = ( [] | it + liftProc(p) | p <- proc.decls.procs );
	proc.decls.procs = [];
	return newProcs + [proc];
}


public Module extendSignatures(Module mod) {
	fvsm = sortFreeVarsMap(freeVarsMap(mod));

	Procedure extendSig(Procedure p) {
		p.formals += [ formal(true, [fn], t) | <fn, t> <- fvsm[p.name] ];
		return p;
	}
	
	Statement extendCall(Statement call) {
		call.args += [ lookup(fn, []) | <fn, _> <- fvsm[call.proc] ];
		return call;
	}
	
	return visit(mod) {
		case Procedure p => extendSig(p)
		case c:call(_, _) => extendCall(c)
	} 
}

public SortedFreeVarsMap sortFreeVarsMap(FreeVarsMap fvm) {
	// ( v: sort(toList(fvm[v])) | v <- fvm )
	SortedFreeVarsMap result = ();
	for (v <- fvm) {
		SortedVariables sv = sort(toList(fvm[v]));
		result[v] = sv;
	}
	return result;
}

public FreeVarsMap builtins() {
	map[Ident, Type] empty = ();
 	return (id("Write"): empty, id("WriteLn"): empty, id("Read"): empty);
}

public FreeVarsMap freeVarsMap(Module mod) {
	// assume: constants have been eliminated/resolved
	// and procs have been resolved
	globals = declaredVars(mod.decls);
		
	FreeVarsMap freeVarsMapOfProcedures(list[Procedure] procs, Variables env) {
		return ( () | it + freeVarsMapOfProcedure(p, env) | p <- procs );
	}

	FreeVarsMap freeVarsMapOfProcedure(Procedure p, Variables env) {
		locals = localVars(p);
		env += locals; 
		fvm = freeVarsMapOfProcedures(p.decls.procs, env);
		freeVarsNested = ( () | it + x | x <- range(fvm) );
		freeVarsUnusedAtThisLevel = freeVarsNested - locals;
		return ( p.name : freeVars(p, env, locals) + freeVarsUnusedAtThisLevel) + fvm;
	}
	
	Variables freeVars(Procedure p, Variables env, Variables locals) {
		return usedVars(p, env) - locals - globals;
	}
	
	return builtins() + freeVarsMapOfProcedures(mod.decls.procs, ());
}


public Variables usedVars(Procedure p, Variables env) {
	return ( i: env[i] | /assign(i, _, _) <- p.body, env[i]? ) 
			+ ( i: env[i] | /lookup(i, _) <- p.body, env[i]? );
}

public Variables localVars(Procedure p) {
    return declaredVars(p.decls) + formalVars(p);
}

public Variables formalVars(Procedure p) {
  return ( n: f.\type | f <- p.formals, n <- f.names );
}

public Variables declaredVars(Declarations d) {
  return ( n: v.\type | v <- d.vars, n <- v.names );
}
