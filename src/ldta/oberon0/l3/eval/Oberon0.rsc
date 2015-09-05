module ldta::oberon0::l3::eval::Oberon0

import ldta::oberon0::l3::AST;
import ldta::oberon0::l3::eval::IO;
import ldta::oberon0::l3::eval::Declarations;
import ldta::oberon0::l3::eval::Statements;
import ldta::oberon0::l1::eval::Expressions;
import ldta::oberon0::l1::eval::Env;
import ldta::oberon0::l1::eval::Memory;

import IO;

public State eval(Module m, Stream input) {
  	env = BUILTIN_ENV;
  	mem = empty();
  	<env, mem> = declare(m.decls, env, mem);
  	println(mem);
  	printEnv(env);
  	return evalStats(m.body, env, memIO(mem, <input, []>));
}





