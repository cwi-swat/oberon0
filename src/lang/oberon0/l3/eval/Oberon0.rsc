module lang::oberon0::l3::eval::Oberon0

import lang::oberon0::l3::ast::Oberon0;
import lang::oberon0::l3::eval::IO;
import lang::oberon0::l3::eval::Declarations;
import lang::oberon0::l3::eval::Statements;
import lang::oberon0::l1::eval::Expressions;
import lang::oberon0::l1::eval::Env;
import lang::oberon0::l1::eval::Memory;

import IO;

public State eval(Module m, Stream input) {
  	env = BUILTIN_ENV;
  	mem = empty();
  	<env, mem> = declare(m.decls, env, mem);
  	println(mem);
  	printEnv(env);
  	return evalStats(m.body, env, memIO(mem, <input, []>));
}





