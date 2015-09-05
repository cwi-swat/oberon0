module lang::oberon0::l1::eval::Statements

import lang::oberon0::l1::ast::Oberon0;
import lang::oberon0::l1::eval::Expressions;
import lang::oberon0::l1::eval::Env;
import lang::oberon0::l1::eval::Memory;

data State = memory(Memory mem);

State evalStats(list[Statement] stats, Env env, State state) {
	for (s <- stats) {
		state = evalStat(s, env, state);
  	}
  	return state;
}


State evalStat(assign(v, exp), Env env, State state) {
	state.mem = update(lookupAddress(v, env, state.mem), eval(exp, env, state.mem), state.mem);
	return state;
}

 
State evalStat(ifThen(c, b, eis, ep), Env env, State state) {
	if (evalCond(c, env, state.mem)) {
		return evalStats(b, env, state);
	}
	if (<ec, eb> <- eis, evalCond(ec, env, state.mem)) {
		return evalStats(eb, env, state);
	}
	return evalStats(ep, env, state);
}
    
State evalStat(whileDo(c, b), Env env, State state) {
	while (evalCond(c, env, state.mem)) {
		state = evalStats(b, env, state);
	}
	return state;
}
