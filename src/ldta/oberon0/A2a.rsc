module ldta::oberon0::A2a

import ldta::oberon0::l3::Bind;
import ldta::oberon0::l3::Parse;
import ldta::oberon0::l3::Implode;
import ldta::oberon0::l3::Scope;
import ldta::oberon0::Result;

import Message;
import lang::box::util::Box2Text;

public void runA2a(loc l) {
  m = implode(parse(l));
  <m2, errs> = bind(m, scope(()));
  if (errs != {}) {
    e = firstError(errs);
    println(e.at.begin.line);
    return;
  }
  println(format(mod2box(m)));
}

public void formatA2a(loc l) {
  println(format(mod2box(implode(parse(l)))));
}

public void bindA2a(loc l) {
  m = implode(parse(l));
  <m2, errs> = bind(m, GLOBAL);
  report(errs);
}
