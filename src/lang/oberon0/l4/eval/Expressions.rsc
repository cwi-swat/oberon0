module lang::oberon0::eval::Expressions

import lang::oberon0::l1::eval::Env;
import lang::oberon0::l1::eval::Memory;
import lang::oberon0::l4::eval::Memory;

import lang::oberon0::l1::ast::Oberon0;
import lang::oberon0::l4::ast::Oberon0;

public Value eval(lookup(v, sels), Env env, Memory mem) = lookupValue(v, evalSubscripts(sels, env, mem), env, mem);

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
