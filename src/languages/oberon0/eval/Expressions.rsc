module languages::oberon0::eval::Expressions

import languages::oberon0::eval::Env;
import languages::oberon0::eval::Memory;
import languages::oberon0::ast::Oberon0;
import List;
import IO;


public bool evalCond(Expression e, Env env, Memory mem) {
  switch (e) {
    case not(exp): return !evalCond(exp, env);
    case amp(lhs, rhs): return evalCond(lhs, env, mem) && evalCond(rhs, env, mem);
    case or(lhs, rhs): return evalCond(lhs, env, mem) || evalCond(rhs, env, mem);
    case eq(lhs, rhs): return eval(lhs, env, mem) == eval(rhs, env, mem);
    case neq(lhs, rhs): return eval(lhs, env, mem) != eval(rhs, env, mem);
    case lt(lhs, rhs): return asInt(eval(lhs, env, mem)) < asInt(eval(rhs, env, mem));
    case gt(lhs, rhs): return asInt(eval(lhs, env, mem)) > asInt(eval(rhs, env, mem));
    case leq(lhs, rhs): return asInt(eval(lhs, env, mem)) <= asInt(eval(rhs, env, mem));
    case geq(lhs, rhs): return asInt(eval(lhs, env, mem)) >= asInt(eval(rhs, env, mem));
    default: throw "Not a condition: <e>";
  }
}


public list[Selector] evalSubscripts(list[Selector] sels, Env env, Memory mem) {
  return visit(sels) {
    case subscript(Expression sub): {
      val = eval(sub, env, mem);
      if (integer(int n) := val) {
        insert subscript(nat(n));
      }
      throw "Subscripts must be integers, not: <val>";
    }
  }
}

public Value lookupValue(Ident id, Env env, Memory mem) {
  return lookupValue(id, [], env, mem);
}

public Value lookupValue(Ident id, list[Selector] sels, Env env, Memory mem) {
  switch (env[id]) {
    case lvalue(a, t):
      return derefValue(a, sels, t, mem);
    case const(v): 
      return v;
  }
  throw "Not a const/var: <id.name>";
}


public Value eval(Expression e, Env env, Memory mem) {
  switch (e) {
    case nat(int val): return integer(val);
    case lookup(v, sels): 
       return lookupValue(v, evalSubscripts(sels, env, mem), env, mem);
    case neg(exp): return integer(- asInt(eval(exp, env, mem)));
    case pos(exp): return eval(exp, env, mem);
    case mul(lhs, rhs): return integer(asInt(eval(lhs, env, mem)) * asInt(eval(rhs, env, mem)));
    case div(lhs, rhs): return integer(asInt(eval(lhs, env, mem)) / asInt(eval(rhs, env, mem)));
    case mod(lhs, rhs): return integer(asInt(eval(lhs, env, mem)) % asInt(eval(rhs, env, mem)));
    case add(lhs, rhs): return integer(asInt(eval(lhs, env, mem)) + asInt(eval(rhs, env, mem)));
    case sub(lhs, rhs): return integer(asInt(eval(lhs, env, mem)) - asInt(eval(rhs, env, mem)));
    default: throw "Not a value: <e>";
  }
}


