module languages::oberon0::eval::Env

import languages::oberon0::ast::Oberon0;
import languages::oberon0::eval::Memory;
import IO;

alias Env = map[Ident, Bindable];

data Bindable = typeDef(Env env, Type \type)
              | const(Value val)
              | func(Env env, Procedure proc);              
              
public void printEnv(Env env) {
  println("env = ");
  for (k <- env) {
    println("\t<k.name>\t\t\t:<env[k]>");
  }
}


    