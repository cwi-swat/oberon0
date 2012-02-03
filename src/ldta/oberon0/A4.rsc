module ldta::oberon0::A4

import ldta::oberon0::l4::AST;
import ldta::oberon0::l4::Implode;
import ldta::oberon0::l4::Parse;
import ldta::oberon0::l4::Check;
import ldta::oberon0::l4::Bind;
import ldta::oberon0::l3::Scope;
import ldta::oberon0::l4::Format;
import ldta::oberon0::l4::CompileToC;
//import ldta::oberon0::l4::Normalize;
import ldta::oberon0::l3::Lift;

import Message;
import ParseTree;
import lang::box::util::Box2Text;

// NB: duplicated from A2a
public NEnv GLOBAL_L4 = nest((), scope((
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

public Tree parseL4(loc l) = parse(l);
public Tree parseL4(str src, loc l) = parse(src, l);

public str formatL4(loc l) {
 return format(mod2box(implode(parse(l))));
}

public set[Message] bindL4(loc l) {
  m = implode(parse(l));
  <m2, errs> = bindModule(m, GLOBAL_L4);
  return errs;
}

public set[Message] checkL4(loc l) {  
  m = implode(parse(l));
  <m2, errs> = bindModule(m, GLOBAL_L4);
  if (errs == {}) {
    errs = check(m2);
  }
  return errs;
}

public Module transformL4(loc l) {
  Module myBind(Module m) = bindModule(m, GLOBAL_L4)[0];
  return lift(myBind(implode(parse(l))), GLOBAL_L4.parent, myBind);
}

public str compileL4(loc l) {
  Module myBind(Module m) = bindModule(m, GLOBAL_L4)[0];
  return compileL4toC(lift(myBind(implode(parse(l))), GLOBAL_L4.parent, myBind));
}
