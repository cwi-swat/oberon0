module lang::oberon0::l1::eval::Oberon0

import lang::oberon0::l1::ast::Oberon0;
import lang::oberon0::l1::eval::Declarations;
import lang::oberon0::l1::eval::Expressions;
import lang::oberon0::l1::eval::Statements;
import lang::oberon0::l1::eval::Env;
import lang::oberon0::l1::eval::Memory;

public State eval(Module m) {
  	env = ();
  	mem = empty();
  	<env, mem> = declare(m.decls, env, mem);
  	return evalStats(m.body, env, memory(mem));
}




