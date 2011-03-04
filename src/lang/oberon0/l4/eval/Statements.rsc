module lang::oberon0::eval::Oberon0

import lang::oberon0::l1::ast::Oberon0;
import lang::oberon0::l3::ast::Oberon0;
import lang::oberon0::l1::eval::Statements;
import lang::oberon0::l3::eval::Statements;
import lang::oberon0::l1::eval::Expressions;
import lang::oberon0::l2::eval::Expressions;
import lang::oberon0::l1::eval::Env;
import lang::oberon0::l1::eval::Memory;


public State evalStat(assign(v, sels, exp), Env env, State state) {
	state.mem = update(lookupAddress(v, sels, env, mem), eval(exp, env, mem), mem);
	return state;
}
