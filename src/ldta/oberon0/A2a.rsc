module ldta::oberon0::A2a

import ldta::oberon0::l3::Bind;
import ldta::oberon0::l3::Parse;
import ldta::oberon0::l3::Implode;
import ldta::oberon0::l3::Scope;

import Message;
import lang::box::util::Box2Text;

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
