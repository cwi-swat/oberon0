module languages::oberon0::eval::Declarations

import languages::oberon0::ast::Oberon0;
import languages::oberon0::eval::Env;
import languages::oberon0::eval::Store;

public Env declareProcs(list[Procedure] ps, Env env) {
  for (p <- ps) {
    env[p.name] = closure(env, p);
  }
  return env;
}

public Env declareConsts(list[ConstDecl] cs, Env env) {
  for (c <- cs) {
    // Constants may use previously defined constants
    env[c.name] = const(evalExp(c.\value, env));
  }
  return env;
}

public Env declareTypes(list[TypeDecl] ts, Env env) {
  for (t <- ts) {
    // Typedefs see previous types at the same level (let*)
    env[t.name] = typeDef(env, t);
  }
  return env;
}

public tuple[Env,Store] declareVars(VarDecl vd, Env env, Store store) {
  old = env;
  for (v <- vd.names) {
    <c, io> = new(vd.\type, old, store);
    env[v] = c;
  }
  return <env, store>;
}

public tuple[Env, Store] declare(Declarations d, Env env, Store store) {
  env = declareConsts(d.consts, env);
  env = declareTypes(d.types, env);
  for (vd <- d.vars) {
    <env, io> = declareVars(vd, env, store);
  }
  env = declareProcs(d.procs, env);
  return <env, store>;
}

public tuple[Env, Store] bind(list[Expression] args, list[Formal] formals, Env env, Store store) {
  i = 0;
  old = env;
  for (f <- formals) {
    for (n <- f.names) {
      if (i >= size(args)) {
        throw "Insufficient arguments";
      }
      arg = args[i];
      if (f.isVar) {
        env[n] = var(addressOf(args[i], old, store));
      }
      else {
        // NB: evaluate args in old environment!
        // otherwise, previously bound formals become
        // available in the evaluation of actuals
        <c, io> = new(eval(arg, old, io), f.\type, old, store);
        env[n] = c;
      }
      i++;
    }
  }
  if (size(args) - 1 > i) {
    throw "Too many arguments";
  }
  return <env, store>;
}

