module languages::oberon0::eval::Expressions

import languages::oberon0::eval::Env;
import languages::oberon0::eval::Store;
import languages::oberon0::ast::Oberon0;


public bool evalCond(Expression e, Env env, Store store) {
  switch (e) {
    case not(exp): return !evalCond(exp, env);
    case amp(lhs, rhs): return evalCond(lhs, env, store) && evalCond(rhs, env, store);
    case or(lhs, rhs): return evalCond(lhs, env, store) || evalCond(rhs, env, store);
    case eq(lhs, rhs): return eval(lhs, env, store) == eval(rhs, env, store);
    case neq(lhs, rhs): return eval(lhs, env, store) != eval(rhs, env, store);
    case lt(lhs, rhs): return asInt(eval(lhs, env, store)) < asInt(eval(rhs, env, store));
    case gt(lhs, rhs): return asInt(eval(lhs, env, store)) > asInt(eval(rhs, env, store));
    case leq(lhs, rhs): return asInt(eval(lhs, env, store)) <= asInt(eval(rhs, env, store));
    case geq(lhs, rhs): return asInt(eval(lhs, env, store)) >= asInt(eval(rhs, env, store));
    default: throw "Not a condition: <e>";
  }
}

public Value eval(Expression e, Env env, Store store) {
  switch (e) {
    case nat(int val): return integer(val);
    case lookup(v, sels): return store[findCell(env[v], sels, env, store)];
    case neg(exp): return integer(- asInt(eval(exp, env, store)));
    case pos(exp): return eval(exp, env, store);
    case mul(lhs, rhs): return integer(asInt(eval(lhs, env, store)) * asInt(eval(rhs, env, store)));
    case div(lhs, rhs): return integer(asInt(eval(lhs, env, store)) / asInt(eval(rhs, env, store)));
    case mod(lhs, rhs): return integer(asInt(eval(lhs, env, store)) % asInt(eval(rhs, env, store)));
    case add(lhs, rhs): return integer(asInt(eval(lhs, env, store)) + asInt(eval(rhs, env, store)));
    case sub(lhs, rhs): return integer(asInt(eval(lhs, env, store)) - asInt(eval(rhs, env, store)));
    default: throw "Not a value: <e>";
  }
}

int asInt(Value v) {
  if (integer(int i) := v) {
    return i;
  }
  throw "Expected integer(int x): <v>"; 
}