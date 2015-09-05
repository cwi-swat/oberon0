module ldta::oberon0::l1::eval::Declarations

import ldta::oberon0::l1::AST;
import ldta::oberon0::l1::eval::Env;
import ldta::oberon0::l1::eval::Memory;
import ldta::oberon0::l1::eval::Expressions;
import IO;
import List;


public Env declareConsts(list[ConstDecl] cs, Env env) {
  	for (c <- cs) {
    	env[c.name] = const(eval(c.\value, env, empty()));
  	}
  	return env;
}

public Env declareTypes(list[TypeDecl] ts, Env env) {
  	for (t <- ts) {
    	env[t.name] = typeDef(env, t);
  	}
  	return env;
}

public Type evalType(t:user(id("INTEGER")), Env env, Memory mem) = t;
public Type evalType(t:user(id("BOOLEAN")), Env env, Memory mem) = t;

default Type evalType(t:user(i), Env env, Memory mem) {
	if (typeDef(Type ut) := env[id]) {
 		return evalType(ut, env, mem);
	}
	throw "Undefined type: <id.name>";
}

public tuple[Env, Memory] declareVars(VarDecl vd, Env env, Memory mem) {
  	Env old = env;
  	for (v <- vd.names) {
    	et = evalType(vd.\type, env, mem);
    	<a, mem> = new(et, mem);
    	env[v] = lvalue(a, et);
  	}
  	return <env, mem>;
}

public tuple[Env, Memory] declare(decls(consts, types, vars), Env env, Memory mem) {
  	env = declareConsts(consts, env);
  	env = declareTypes(types, env);
  	for (vd <- vars) {
    	<env, mem> = declareVars(vd, env, mem);
  	}
  	return <env, mem>;
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


