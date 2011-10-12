module ldta::oberon0::A4

import ldta::oberon0::l4::AST;
import ldta::oberon0::l4::Implode;
import ldta::oberon0::l4::Parse;
import ldta::oberon0::l4::Check;
import ldta::oberon0::l4::Bind;
import ldta::oberon0::l3::Scope;
import ldta::oberon0::l4::Format;
import ldta::oberon0::l4::CompileToC;
import ldta::oberon0::l3::Lift;

import Message;
import ParseTree;
import lang::box::util::Box2Text;

// NB: duplicated from A2a
public NEnv GLOBAL_A4 = scope((
  id("Write"): proc(|file://-|,[formal(false, [id("x")], user(id("INTEGER")))]),
  id("Read"): proc(|file://-|,[formal(true, [id("x")], user(id("INTEGER")))]),
  id("WriteLn"): proc(|file://-|,[])
));

public Tree parseL4(loc l) = parse(l);

public str formatL4(loc l) {
 return format(mod2box(implode(parse(l))));
}

public set[Message] bindL4(loc l) {
  m = implode(parse(l));
  <m2, errs> = bind(m, GLOBAL_A4);
  return errs;
}

public set[Message] checkL4(loc l) {  
  m = implode(parse(l));
  <m2, errs> = bind(m, GLOBAL_A4);
  return errs + check(m2);
}

public Module transformA4(loc l) {
  Module myBind(Module m) = bind(m, GLOBAL_A4)[0];
  return lift(myBind(implode(parse(l))), GLOBAL_A4, myBind);
}

public str compileA4(loc l) {
  Module myBind(Module m) = bind(m, GLOBAL_A4)[0];
  return compileL4toC(lift(myBind(implode(parse(l))), GLOBAL_A4, myBind));
}
