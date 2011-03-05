module lang::oberon0::l1::eval::Expressions

import lang::oberon0::l1::eval::Env;
import lang::oberon0::l1::eval::Memory;
import lang::oberon0::l1::ast::Oberon0;
import List;
import IO;


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
public Value eval(lookup(v), Env env, Memory mem) 		= lookupValue(v, env, mem);
public Value eval(neg(exp), Env env, Memory mem) 		= integer(- asInt(eval(exp, env, mem)));
public Value eval(pos(exp), Env env, Memory mem) 		= eval(exp, env, mem);
public Value eval(mul(lhs, rhs), Env env, Memory mem) 	= integer(asInt(eval(lhs, env, mem)) * asInt(eval(rhs, env, mem)));
public Value eval(div(lhs, rhs), Env env, Memory mem) 	= integer(asInt(eval(lhs, env, mem)) / asInt(eval(rhs, env, mem)));
public Value eval(Expression::mod(lhs, rhs), Env env, Memory mem) 	= integer(asInt(eval(lhs, env, mem)) % asInt(eval(rhs, env, mem)));
public Value eval(add(lhs, rhs), Env env, Memory mem) 	= integer(asInt(eval(lhs, env, mem)) + asInt(eval(rhs, env, mem)));
public Value eval(sub(lhs, rhs), Env env, Memory mem) 	= integer(asInt(eval(lhs, env, mem)) - asInt(eval(rhs, env, mem)));

public int asInt(integer(n)) = n;

