module ldta::oberon0::A3

import ldta::oberon0::l3::AST;
import ldta::oberon0::l3::Implode;
import ldta::oberon0::l3::Parse;
import ldta::oberon0::l3::Check;
import ldta::oberon0::l3::Bind;
import ldta::oberon0::l3::Scope;
import ldta::oberon0::l3::Format;

import Message;
import lang::box::util::Box2Text;

// NB: duplicate from A2a

public NEnv GLOBAL_L3 = nest((), scope((
  id("Write"): proc(|file://-|,[
     formal(false, [id("x")[
        @decl=param(|file://-|, user(id("INTEGER")), false)
     ]], user(id("INTEGER")))
  ]),
  id("Read"): proc(|file://-|,[
     formal(true, [id("x")[
        @decl=param(|file://-|, user(id("INTEGER")), true)
     ]], user(id("INTEGER")))
  ]),
  id("WriteLn"): proc(|file://-|,[])
)));


public str formatL3(loc l) {
 return format(mod2box(implode(parse(l))));
}

public set[Message] checkL3(loc l) {  
  m = implode(parse(l));
  <m2, errs> = bindModule(m, GLOBAL_L3);
  if (errs == {}) {
    errs = check(m2);
  }
  return errs;
}

