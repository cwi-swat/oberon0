module languages::oberon0::eval::Expressions

import languages::oberon0::eval::Env;
import languages::oberon0::eval::Memory;
import languages::oberon0::ast::Oberon0;
import List;
import IO;


data Value 
	= array(Address a, Type \t)
	;


public bool evalCond(not(exp), Env env, Memory mem) 		= !evalCond(exp, env);
public bool evalCond(amp(lhs, rhs), Env env, Memory mem) 	= evalCond(lhs, env, mem) && evalCond(rhs, env, mem);
public bool evalCond(or(lhs, rhs), Env env, Memory mem) 	= evalCond(lhs, env, mem) || evalCond(rhs, env, mem);
public bool evalCond(eq(lhs, rhs), Env env, Memory mem) 	= eval(lhs, env, mem) == eval(rhs, env, mem);
public bool evalCond(neq(lhs, rhs), Env env, Memory mem) 	= eval(lhs, env, mem) != eval(rhs, env, mem);
public bool evalCond(lt(lhs, rhs), Env env, Memory mem) 	= asInt(eval(lhs, env, mem)) < asInt(eval(rhs, env, mem));
public bool evalCond(gt(lhs, rhs), Env env, Memory mem) 	= asInt(eval(lhs, env, mem)) > asInt(eval(rhs, env, mem));
public bool evalCond(leq(lhs, rhs), Env env, Memory mem) 	= asInt(eval(lhs, env, mem)) <= asInt(eval(rhs, env, mem));
public bool evalCond(geq(lhs, rhs), Env env, Memory mem) 	= asInt(eval(lhs, env, mem)) >= asInt(eval(rhs, env, mem));


public Value eval(nat(int val), Env env, Memory mem) 	= integer(val);
public Value eval(lookup(v, sels), Env env, Memory mem) = lookupValue(v, evalSubscripts(sels, env, mem), env, mem);
public Value eval(neg(exp), Env env, Memory mem) 		= integer(- asInt(eval(exp, env, mem)));
public Value eval(pos(exp), Env env, Memory mem) 		= eval(exp, env, mem);
public Value eval(mul(lhs, rhs), Env env, Memory mem) 	= integer(asInt(eval(lhs, env, mem)) * asInt(eval(rhs, env, mem)));
public Value eval(div(lhs, rhs), Env env, Memory mem) 	= integer(asInt(eval(lhs, env, mem)) / asInt(eval(rhs, env, mem)));
public Value eval(Expression::mod(lhs, rhs), Env env, Memory mem) 	= integer(asInt(eval(lhs, env, mem)) % asInt(eval(rhs, env, mem)));
public Value eval(add(lhs, rhs), Env env, Memory mem) 	= integer(asInt(eval(lhs, env, mem)) + asInt(eval(rhs, env, mem)));
public Value eval(sub(lhs, rhs), Env env, Memory mem) 	= integer(asInt(eval(lhs, env, mem)) - asInt(eval(rhs, env, mem)));

public Bindable addressOf(Expression e, Env env, Memory mem) {
  	if (lookup(Ident id, list[Selector] sels) := e, lvalue(Address a, Type t) := env[id]) {
    	return lvalueOf(a, evalSubscripts(sels, env, mem), t, mem);
  	}
  	throw "Cannot get address of non-variable: <id.name>";
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
