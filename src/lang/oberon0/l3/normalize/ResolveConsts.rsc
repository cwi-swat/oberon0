module lang::oberon0::l3::normalize::ResolveConsts

import lang::oberon0::l3::ast::Oberon0;
import lang::oberon0::l3::normalize::Utils;

import IO;

public Module resolveConsts(Module mod) {
	env = ();
	mod.decls = resolveConstsInDecls(mod.decls, TOPLEVEL_SCOPE, env);
	return mod;
}

Declarations resolveConstsInDecls(Declarations decls, Ident scope, Env env) {
	decls.consts = for (constDecl(n, e) <- decls.consts) {
		ln = longName(scope, n);
		append constDecl(ln, renameConst(e, env));
		env[n] = ln;
	}
	
	decls.types = [ typeDecl(n, renameConst(t, env)) | typeDecl(n, t) <- decls.types ];
	decls.vars = [ varDecl(ns, renameConst(t, env)) | varDecl(ns, t) <- decls.vars ];
	
	decls.procs = [ resolveConstsInProc(p, newScope(scope, p.name), env) | p <- decls.procs ];
	return decls; 
}

Procedure resolveConstsInProc(Procedure proc, Ident scope, Env env) {
	proc.formals = [ formal(hv, ns, renameConst(t, env)) | formal(hv, ns, t) <- proc.formals ];
	proc.decls = resolveConstsInDecls(proc.decls, scope, env);
	proc.body = visit (proc.body) {
		case Expression e => renameConst(e, env)
	}
	return proc;
}

Type renameConst(Type t, Env env) {
	return visit (t) {
		case Expression e => renameConst(e, env)
	}
}

Expression renameConst(Expression e, Env env) {
	return visit (e) {
		case lookup(n) => lookup(env[n]) when env[n]?
	}
}