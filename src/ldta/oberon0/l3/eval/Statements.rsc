module ldta::oberon0::l3::eval::Statements

import ldta::oberon0::l3::AST;
import ldta::oberon0::l3::eval::IO;

import ldta::oberon0::l1::eval::Expressions;
import ldta::oberon0::l1::eval::Env;
import ldta::oberon0::l1::eval::Memory;

extend ldta::oberon0::l1::eval::Statements;

data State = memIO(Memory mem, IO io);


public State evalProc(Procedure pr, list[Expression] args, Env env, Env outer, State) {
	scope = push(state.mem);
	<env, state.mem> = declare(pr.decls, env, mem);
	<env, state.mem> = bind(args, pr.formals, env, outer, mem);
	env[pr.name] = func(env, pr); // for recursion
	state = evalStats(pr.body, env, state);
	state.mem = pop(state.mem, scope);
  	return state;
}

public State evalBuiltin(list[Formal] fs, State(Env, State) f, list[Expression] args, Env env, State state) {
	scope = push(state.mem);
	<env, state.mem> = bind(args, fs, (), env, state.mem);
	state = f(env, state);
	state.mem = pop(state.mem, scope);
	return state;
}


public State evalStat(call(Ident id, args), Env env, State state) { 
	switch (env[id]) {
		case func(env2, pr): return evalProc(pr, args, env2, env, state);
		case builtin(fs, f): return evalBuiltin(fs, f, args, env, state);
		default: throw "Can only call procedures not <id.name>";
	}
}
 

tuple[Env, Memory] bind(list[Expression] args, list[Formal] formals, Env env, Env outer, Memory mem) {
  	i = 0;
  	for (f <- formals, n <- f.names) {
    	if (i >= size(args)) {
        	throw "Insufficient arguments";
      	}
      	if (f.hasVar) {
        	env[n] = addressOf(args[i], outer, mem);
      	}
      	else {
        	<env, mem> = push(n, args[i], f.\type, env, outer, mem);
      	}
      	i += 1;
  	}
  	if (size(args) > i) {
    	throw "Too many arguments";
  	}
  	return <env, mem>;
}


tuple[Env, Memory] push(Ident n, Expression arg, Type t, Env env, Env outer, Memory mem) {
    et = evalType(t, env, mem);
    <a, mem> = new(et, mem);
    if (array(_, _) := et || record(_) := et) {
      	lv = addressOf(arg, outer, mem);
      	mem = copy(lv.addr, a, mem);
    }
    else {
      	mem = update(a, eval(arg, outer, mem), mem);
    }
    env[n] = lvalue(a, et);
    return <env, mem>;
}