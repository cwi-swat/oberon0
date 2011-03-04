module lang::oberon0::l1::eval::Env

import lang::oberon0::l1::ast::Oberon0;
import lang::oberon0::l1::eval::Memory;
import IO;

alias Env = map[Ident, Bindable];

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
	if (lvalue(a, t) := env[id]) {
		return addressOf(a, t, mem);
	}
	throw "Not a variable: <id.name>";
}

public Value lookupValue(Ident id, Env env, Memory mem) {
  switch (env[id]) {
    case lvalue(a, t):
      return derefValue(a, t, mem);
    case const(v): 
      return v;
  }
  throw "Not a const/var: <id.name>";
}
