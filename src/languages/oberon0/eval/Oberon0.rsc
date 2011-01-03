module languages::oberon0::eval::Oberon0

import languages::oberon0::ast::Oberon0;
import languages::oberon0::eval::Store;
import languages::oberon0::eval::Builtin;
import languages::oberon0::eval::Values;
import languages::oberon0::eval::Env;
import languages::oberon0::eval::IO;

        
alias Result = tuple[Store, IO];

public Result eval(Module m, Env env, Store store, Store store, IO io) {

}



public Result evalStats(list[Statement] stats, Env env, Store store, IO io) {
  for (s <- stats) {
    <store, io> = evalStat(s, env, store, io);
  }
  return <store, io>;
}

public Cell addressOf(Expression e, Env env, Store store) {
  if (lookup(Ident var, sels) := e) {
    return findCell(env[var], sels, env, store);
  }
  throw "Not an lvalue <e>";
}





public Result evalStat(Statement stat, Env env, Store store, IO io) {
  switch (s) {
    case assign(v, sels, exp): {
      c = findCell(env[v], sels, env, io.store);
      io.store[c] = eval(exp, env, io); 
      return <store, io>;
    }
        
    case call(Ident id, args): {
      if (closure(Env env2, pr) := env[id]) {
        <env2, store2> = declare(pr.decls, env2, store);
        <env2, store2> = bind(args, pr.formals, env2, store2);
        return evalStats(pr.body, env2, store2, io);
        // todo: dispose env2 bound cells.
      }
      throw "Can only call procedures not, <b>";
    }
    
    case ifThen(c, b, eis, ep): {
      if (evalCond(c, env, store)) {
          return evalStats(b, env, io);
      }
      for (ei <- eis, evalCond(ei.condition, env, store)) {
         return evalStats(ei.body, env, io);
      }
      return evalStats(ep, env, io);
    }
    
    case whileDo(c, b): {
      while (evalCond(c, env, store)) {
        <store, io> = evalStats(b, env, store, io);
      }
      return <store, io>;
    }
  }
}

