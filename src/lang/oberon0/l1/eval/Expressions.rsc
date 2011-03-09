module lang::oberon0::l1::eval::Expressions

import lang::oberon0::l1::eval::Env;
import lang::oberon0::l1::eval::Memory;
import lang::oberon0::l1::ast::Oberon0;
import List;
import IO;


public Value eval(\true(), Env env, Memory mem)			= boolean(true);
public Value eval(\false(), Env env, Memory mem)		= boolean(false);
public Value eval(not(exp), Env env, Memory mem) 		= boolean(!asBool(eval(exp, env)));
public Value eval(amp(lhs, rhs), Env env, Memory mem) 	= boolean(asBool(eval(lhs, env, mem)) && asBool(eval(rhs, env, mem)));
public Value eval(or(lhs, rhs), Env env, Memory mem) 	= boolean(asBool(eval(lhs, env, mem)) || asBool(eval(rhs, env, mem)));
public Value eval(eq(lhs, rhs), Env env, Memory mem) 	= boolean(eval(lhs, env, mem) == eval(rhs, env, mem));
public Value eval(neq(lhs, rhs), Env env, Memory mem) 	= boolean(eval(lhs, env, mem) != eval(rhs, env, mem));
public Value eval(lt(lhs, rhs), Env env, Memory mem) 	= boolean(asInt(eval(lhs, env, mem)) < asInt(eval(rhs, env, mem)));
public Value eval(gt(lhs, rhs), Env env, Memory mem) 	= boolean(asInt(eval(lhs, env, mem)) > asInt(eval(rhs, env, mem)));
public Value eval(leq(lhs, rhs), Env env, Memory mem) 	= boolean(asInt(eval(lhs, env, mem)) <= asInt(eval(rhs, env, mem)));
public Value eval(geq(lhs, rhs), Env env, Memory mem) 	= boolean(asInt(eval(lhs, env, mem)) >= asInt(eval(rhs, env, mem)));

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
public bool asBool(boolean(b)) = b;

