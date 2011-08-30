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
import IO;
import lang::box::util::Box2Text;


public NEnv GLOBAL = scope((
  id("Write"): proc(|file://-|,[formal(false, [id("x")], user(id("INTEGER")))]),
  id("Read"): proc(|file://-|,[formal(true, [id("x")], user(id("INTEGER")))]),
  id("WriteLn"): proc(|file://-|,[formal(false, [id("x")], user(id("INTEGER")))])
));
  

public void format(loc l) {
 println(format(mod2box(implode(parse(l)))));
}

public void bind(loc l) {
  m = implode(parse(l));
  <m2, errs> = bind(m, GLOBAL);
  for (e <- errs) {
    println("Name error: <e.msg> at line <e.at.begin.line>");
  }
}

public void check(loc l) {  
  m = implode(parse(l));
  <m2, errs> = bind(m, GLOBAL);
  if (errs != {}) {
    for (e <- errs) 
      println("Name error: <e.msg> at line <e.at.begin.line>");
    return;
  }
  errs = check(m2);
  for (e <- errs) 
    println("Type error: <e.msg> at line <e.at.begin.line>");
}

public void transform(loc l) {
  Module myBind(Module m) = bind(m, GLOBAL)[0];
  println(format(mod2box(lift(myBind(implode(parse(l))), GLOBAL, myBind))));
}

public void compile(loc l) {
  Module myBind(Module m) = bind(m, GLOBAL)[0];
  println(compileL4toC(lift(myBind(implode(parse(l))), GLOBAL, myBind)));
}
