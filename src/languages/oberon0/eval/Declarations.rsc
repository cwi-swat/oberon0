module languages::oberon0::eval::Declarations

import languages::oberon0::ast::Oberon0;
import languages::oberon0::eval::Env;
import languages::oberon0::eval::Memory;
import languages::oberon0::eval::Expressions;
import IO;
import List;


// all declares work like let*

public Env declareProcs(list[Procedure] ps, Env env) {
	for (p <- ps) {
   		env[p.name] = func(env, p);
  	}
  	return env;
}

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

public Type evalType(Type t, Env env, Memory mem) {
  	switch (t) {
    	case user(id("INTEGER")):
      		return t;
    	case user(id("BOOLEAN")):
      		return t;
    	case user(Ident id):
      		if (typeDef(Type ut) := env[id]) {
         		return evalType(ut, env, mem);
      		}
      		else {
        		throw "Undefined type: <id.name>";
      		}
      
    	case array(Expression b, Type et): {
      		v = eval(b, env, mem);
      		if (integer(int n) := v) {
        		return array(nat(n), evalType(et, env, mem));
      		}
      		throw "Array bounds must be integers not <v>";
    	} 
    	case record(fs): 
      		return record([field(n, evalType(f.\type, env, mem)) | f <- fs, n <- f.names ]);  
  	}
}

public tuple[Env,Memory] declareVars(VarDecl vd, Env env, Memory mem) {
  	Env old = env;
  	for (v <- vd.names) {
    	et = evalType(vd.\type, env, mem);
    	<a, mem> = new(et, mem);
    	env[v] = lvalue(a, et);
  	}
  	return <env, mem>;
}

public tuple[Env, Memory] declare(Declarations d, Env env, Memory mem) {
  	env = declareConsts(d.consts, env);
  	env = declareTypes(d.types, env);
  	for (vd <- d.vars) {
    	<env, mem> = declareVars(vd, env, mem);
  	}
  	env = declareProcs(d.procs, env);
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


public tuple[Env, Memory] bind(list[Expression] args, list[Formal] formals, Env env, Env outer, Memory mem) {
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

