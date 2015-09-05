module ldta::oberon0::eval::Statements

import ldta::oberon0::l1::AST;
import ldta::oberon0::l3::AST;
import ldta::oberon0::l4::AST;
import ldta::oberon0::l1::eval::Statements;
import ldta::oberon0::l1::eval::Expressions;
import ldta::oberon0::l1::eval::Env;
import ldta::oberon0::l1::eval::Memory;
import ldta::oberon0::l3::eval::Statements;

public State evalStat(assign(v, sels, exp), Env env, State state) {
	state.mem = update(lookupAddress(v, sels, env, mem), eval(exp, env, mem), mem);
	return state;
}
