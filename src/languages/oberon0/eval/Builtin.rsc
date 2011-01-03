module languages::oberon0::eval::Builtin

import languages::oberon0::eval::Env;
import languages::oberon0::eval::IO;
import languages::oberon0::ast::Oberon0;

data Bindable = builtin(list[Formals], IO(Env, IO) func);


public Env toplevel  = (
  "Write": builtin([formal(false, [id("x")], user("INTEGER"))],
    IO(Env env, IO io) {
      io.output += [toString(io.store[env["x"]])];
      return io;
    }
  ),
  "Read": builtin([formal(true, [id("x")], user("INTEGER"))],
    IO(Env env, IO io) {
      d;
    }
  )
);