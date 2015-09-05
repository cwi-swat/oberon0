module lang::oberon0::l3::normalize::ResolveProcs

import lang::oberon0::l3::ast::Oberon0;
import lang::oberon0::l3::normalize::Utils;


public Module resolveProcs(Module \mod) {
	env = initEnv({"Write", "WriteLn", "Read"});
	<_, \mod.decls> = resolveProcsInDecls(\mod.decls, TOPLEVEL_SCOPE, env);
	return \mod;
}

tuple[Env, Declarations] resolveProcsInDecls(Declarations decls, Ident scope, Env env) {
	decls.procs = for (p <- decls.procs) {
		env[p.name] = longName(scope, p.name); 
		p = resolveProcsInProc(p, newScope(scope, p.name), env);
		p.name = env[p.name];
		append p;	
	}
	return <env, decls>;
}


Procedure resolveProcsInProc(Procedure proc, Ident scope, Env env) {
	<env, proc.decls> = resolveProcsInDecls(proc.decls, scope, env);	
	proc.body = visit (proc.body) {
		case call(name, args) => call(env[name], args)
	}
	return proc;
}




