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

import ldta::oberon0::Result;


import Message;
import IO;
import lang::box::util::Box2Text;


public NEnv GLOBAL_A4 = scope((
  id("Write"): proc(|file://-|,[formal(false, [id("x")], user(id("INTEGER")))]),
  id("Read"): proc(|file://-|,[formal(true, [id("x")], user(id("INTEGER")))]),
  id("WriteLn"): proc(|file://-|,[formal(false, [id("x")], user(id("INTEGER")))])
));

public void runA4(loc l) {
  m = implode(parse(l));
  <m2, errs> = bind(m, GLOBAL_A4);
  if (errs != {}) {
     e = firstError(errs);
     println(e.at.begin.line);
     return;
  }
  errs = check(m2);
  if (errs != {}) {
    e = firstError(errs);
    println(e.at.begin.line);
    return;
  }
  println(compileL4toC(lift(m2), GLOBAL_A4, myBind));
}
  

public void formatA4(loc l) {
 println(format(mod2box(implode(parse(l)))));
}

public void bindA4(loc l) {
  m = implode(parse(l));
  <m2, errs> = bind(m, GLOBAL_A4);
  report(errs);
}

public void checkA4(loc l) {  
  m = implode(parse(l));
  <m2, errs> = bind(m, GLOBAL_A4);
  if (errs != {}) {
    throw "Name error(s) before typechecking: <errs>";
  }
  report(check(m2));
}

public void transformA4(loc l) {
  Module myBind(Module m) = bind(m, GLOBAL_A4)[0];
  println(format(mod2box(lift(myBind(implode(parse(l))), GLOBAL_A4, myBind))));
}

public void compileA4(loc l) {
  Module myBind(Module m) = bind(m, GLOBAL_A4)[0];
  println(compileL4toC(lift(myBind(implode(parse(l))), GLOBAL_A4, myBind)));
}
