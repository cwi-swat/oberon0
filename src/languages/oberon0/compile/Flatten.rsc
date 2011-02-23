module languages::oberon0::compile::Flatten

alias Env = map[Ident, Ident];

public Ident longName(Ident scope, Ident name) {
	return id(scope.name + "_" + name.name);
}

public Ident newScope(Ident scope, Ident name) = longName(scope, name);

public Module resolve(Module mod) {
	mod.decls = resolveDecls(mod.decls, ());
	return mod;
}

public Procedure resolveProc(Procedure proc, Ident scope, Env env) {
	proc.formals = [ formal(hv, ns, renameType(t, env)) | formal(hv, ns, t) <- proc.formals ];
	proc.decls = resolveDecls(proc.decls, env);
	return proc;
}

public Declarations resolveDecls(Declarations decls, Env env) {
	env += ( t.name: longName(scope, t.name) | t <- decls.types );
	
	decls.types = [ typeDecl(env[n], renameType(t, env))  | typeDecl(n, t) <- decls.types ];
	decls.vars = [ varDecl(ns, renameType(t, env)) | varDecl(ns, t) <- decls.vars ];
	decls.procs = [ resolveProc(p, newScope(scope, proc.name), env) | p <- decls.procs ];
	
	return decls; 
}

public Type renameType(Type t, Env env) {
	return visit (t) {
		case user(n) => user(env[n])
	}
}