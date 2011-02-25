module languages::oberon0::eval::Oberon0

import languages::oberon0::ast::Oberon0;
import languages::oberon0::eval::Declarations;
import languages::oberon0::eval::Expressions;
import languages::oberon0::eval::Env;
import languages::oberon0::eval::Memory;
import languages::oberon0::eval::Builtins;

import IO;

public Result eval(Module m, Stream input) {
  	env = TOPLEVEL;
  	mem = empty();
  	<env, mem> = declare(m.decls, env, mem);
  	println(mem);
  	printEnv(env);
  	return evalStats(m.body, env, mem, <input, []>);
}

public Result evalStats(list[Statement] stats, Env env, Memory mem, IO io) {
	for (s <- stats) {
		<mem, io> = evalStat(s, env, mem, io);
  	}
  	return <mem, io>;
}


public Result evalProc(Procedure pr, list[Expression] args, Env env, Env outer, Memory mem, IO io) {
	scope = push(mem);
	<env, mem> = declare(pr.decls, env, mem);
	<env, mem> = bind(args, pr.formals, env, outer, mem);
	env[pr.name] = func(env, pr); // for recursion
	<mem, io> = evalStats(pr.body, env, mem, io);
	mem = pop(mem, scope);
  	return <mem, io>;
}

public Result evalBuiltin(list[Formal] fs, Result(Env, Memory, IO) f, list[Expression] args, Env env, Memory mem, IO io) 
{
	scope = push(mem);
	<env, mem> = bind(args, fs, TOPLEVEL, env, mem);
	<mem, io> = f(env, mem, io);
	mem = pop(mem, scope);
	return <mem, io>;
}


public Result evalStat(assign(v, sels, exp), Env env, Memory mem, IO io) {
	mem = update(lookupAddress(v, sels, env, mem), eval(exp, env, mem), mem);
	return <mem, io>;
}



public Result evalStat(call(Ident id, args), Env env, Memory mem, IO io) { 
	switch (env[id]) {
		case func(env2, pr): return evalProc(pr, args, env2, env, mem, io);
		case builtin(fs, f): return evalBuiltin(fs, f, args, env, mem, io);
		default: throw "Can only call procedures not <id.name>";
	}
}
 
 
public Result evalStat(ifThen(c, b, eis, ep), Env env, Memory mem, IO io) {
	if (evalCond(c, env, mem)) {
		return evalStats(b, env, mem, io);
	}
	if (<ec, eb> <- eis, evalCond(ec, env, mem)) {
		return evalStats(eb, env, mem, io);
	}
	return evalStats(ep, env, mem, io);
}
    
public Result evalStat(whileDo(c, b), Env env, Memory mem, IO io) {
	while (evalCond(c, env, mem)) {
		<mem, io> = evalStats(b, env, mem, io);
	}
	return <mem, io>;
}


