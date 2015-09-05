module ldta::oberon0::l3::eval::Declarations

import ldta::oberon0::l3::AST;
import ldta::oberon0::l1::eval::Env;
import ldta::oberon0::l1::eval::Memory;
import ldta::oberon0::l1::eval::Expressions;

extend ldta::oberon0::l1::eval::Declarations;

import IO;
import List;


public tuple[Env, Memory] declare(decls(consts, types, vars, procs), Env env, Memory mem) {
  	env = declareConsts(consts, env);
  	env = declareTypes(types, env);
  	for (vd <- vars) {
    	<env, mem> = declareVars(vd, env, mem);
  	}
  	env = declareProcs(procs, env);
  	return <env, mem>;
}


public Env declareProcs(list[Procedure] ps, Env env) {
	for (p <- ps) {
   		env[p.name] = func(env, p);
  	}
  	return env;
}

public tuple[Env, Memory] push(Ident n, Expression arg, Type t, Env env, Env outer, Memory mem) {
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


