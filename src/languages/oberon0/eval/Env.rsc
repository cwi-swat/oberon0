module languages::oberon0::eval::Env

import languages::oberon0::ast::Oberon0;

alias Env = map[Ident, Bindable];

data Bindable = var(Cell cell)
              | typeDef(Env env, Type typ)
              | const(Value val)
              | closure(Env env, Procedure proc);
              



    