module lang::oberon0::eval::Builtins

import lang::oberon0::eval::Env;
import lang::oberon0::eval::Memory;
import lang::oberon0::ast::Oberon0;
import IO;

data Bindable = builtin(list[Formal] formals, Result(Env, Memory, IO) func);



public Env TOPLEVEL  = (
  id("Write"): builtin([formal(false, [id("x")], user(id("INTEGER")))],
    Result(Env env, Memory mem, IO io) {
      val = lookupValue(id("x"), env, mem);
      s = "<asInt(val)>";
      println(s);
      io = write(s, io);
      return <mem, io>;
    }
  ),
  id("WriteLn"): builtin([],
    Result(Env env, Memory mem, IO io) {
      io = write("\n", io);
      return <mem, io>;
    }
  ),
  id("Read"): builtin([formal(true, [id("x")], user(id("INTEGER")))],
    Result(Env env, Memory mem, IO io) {
      <v, io> = readInt(io);
      a = lookupAddress(id("x"), env, mem);
      mem = update(a, v, mem);
      return <mem, io>;
    }
  )
);
