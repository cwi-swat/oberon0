module ldta::oberon0::A3

import ldta::oberon0::l3::AST;
import ldta::oberon0::l3::Implode;
import ldta::oberon0::l3::Parse;
import ldta::oberon0::l3::Check;
import ldta::oberon0::l3::Bind;
import ldta::oberon0::l3::Scope;
import ldta::oberon0::l3::Format;

import Message;
import IO;
import lang::box::util::Box2Text;

import ldta::oberon0::Result;

public NEnv GLOBAL_A3 = scope((
  id("Write"): proc(|file://-|,[formal(false, [id("x")], user(id("INTEGER")))]),
  id("Read"): proc(|file://-|,[formal(true, [id("x")], user(id("INTEGER")))]),
  id("WriteLn"): proc(|file://-|,[])
));
  

public void runA3(loc l) {
  m = implode(parse(l));
  <m2, errs> = bind(m, GLOBAL_A3);
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
  println(format(mod2box(m2)));
}

public void formatA3(loc l) {
 println(format(mod2box(implode(parse(l)))));
}

public void bindA3(loc l) {
  m = implode(parse(l));
  <m2, errs> = bind(m, GLOBAL_A3);
  report(errs);
}

public void checkA3(loc l) {  
  m = implode(parse(l));
  <m2, errs> = bind(m, GLOBAL_A3);
  if (errs != {}) {
    throw "Name error(s) before type checking: <errs>";
  }
  report(check(m2));
}

