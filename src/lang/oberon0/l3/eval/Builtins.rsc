module lang::oberon0::l3::eval::Builtins

 
import lang::oberon0::l1::eval::Env;
import lang::oberon0::l1::eval::Memory;
import lang::oberon0::l3::eval::Statements; // TODO: state is declared in Statements?
 
import lang::oberon0::l1::ast::Oberon0;
import lang::oberon0::l3::ast::Oberon0;
import lang::oberon0::l3::eval::IO;

data Bindable = builtin(list[Formal] formals, State(Env, State) func);

public Env BUILTIN_ENV  = (
  id("Write"): builtin([formal(false, [id("x")], user(id("INTEGER")))],
    State(Env env, State state) {
      val = lookupValue(id("x"), env, state.mem);
      s = "<asInt(val)>";
      state.io = write(s, state.io);
      return state;
    }
  ),
  id("WriteLn"): builtin([],
    State(Env env, State state) {
      state.io = write("\n", state.io);
      return state;
    }
  ),
  id("Read"): builtin([formal(true, [id("x")], user(id("INTEGER")))],
    State(Env env, State state) {
      <v, state.io> = readInt(state.io);
      a = lookupAddress(id("x"), env, state.mem);
      state.mem = update(a, v, state.mem);
      return state;
    }
  )
);


