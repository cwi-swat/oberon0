module lang::oberon0::l3::normalize::ResolveTypes

import lang::oberon0::l3::ast::Oberon0;
import lang::oberon0::l3::normalize::Utils;


public Module resolveTypes(Module mod) {
	env = initEnv({"INTEGER", "BOOLEAN"});
	mod.decls = resolveTypesInDecls(mod.decls, TOPLEVEL_SCOPE, env);
	return mod;
}

Declarations resolveTypesInDecls(Declarations decls, Ident scope, Env env) {
	decls.types = for (typeDecl(n, t) <- decls.types) {
		ln = longName(scope, n);
		append typeDecl(ln, renameType(t, env));
		env[n] = ln;
	}
	
	decls.vars = [ varDecl(ns, renameType(t, env)) | varDecl(ns, t) <- decls.vars ];
	decls.procs = [ resolveTypesInProc(p, newScope(scope, p.name), env) | p <- decls.procs ];

	return decls; 
}

Procedure resolveTypesInProc(Procedure proc, Ident scope, Env env) {
	proc.formals = [ formal(hv, ns, renameType(t, env)) | formal(hv, ns, t) <- proc.formals ];
	proc.decls = resolveTypesInDecls(proc.decls, scope, env);
	return proc;
}

Type renameType(Type t, Env env) {
	return visit (t) {
		case user(n) => user(env[n])
	}
}