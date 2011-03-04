module lang::oberon0::eval::Env

import lang::oberon0::ast::Oberon0;
import lang::oberon0::eval::Memory;
import IO;

alias Env = map[Ident, Bindable];

alias Result = tuple[Memory, IO];


data Bindable 
	= typeDef(Env env, Type \type)
	| const(Value val)
	| func(Env env, Procedure proc)
	;              
              
public void printEnv(Env env) {
  	println("env = ");
  	for (k <- env) {
    	println("\t<k.name>\t\t\t:<env[k]>");
  	}
}

public Address lookupAddress(Ident id, Env env, Memory mem) {
  	return lookupAddress(id, [], env, mem);
}

public Address lookupAddress(Ident id, list[Selector] sels, Env env, Memory mem) {
	if (lvalue(a, t) := env[id]) {
		return addressOf(a, sels, t, mem);
	}
	throw "Not a variable: <id.name>";
}

public Value lookupValue(Ident id, Env env, Memory mem) {
  return lookupValue(id, [], env, mem);
}

public Value lookupValue(Ident id, list[Selector] sels, Env env, Memory mem) {
  switch (env[id]) {
    case lvalue(a, t):
      return derefValue(a, sels, t, mem);
    case const(v): 
      return v;
  }
  throw "Not a const/var: <id.name>";
}

    