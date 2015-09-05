module ldta::oberon0::l1::eval::Oberon0

import ldta::oberon0::l1::AST;
import ldta::oberon0::l1::eval::Declarations;
import ldta::oberon0::l1::eval::Expressions;
import ldta::oberon0::l1::eval::Statements;
import ldta::oberon0::l1::eval::Env;
import ldta::oberon0::l1::eval::Memory;

public State eval(Module m) {
  	env = ();
  	mem = empty();
  	<env, mem> = declare(m.decls, env, mem);
  	return evalStats(m.body, env, memory(mem));
}




