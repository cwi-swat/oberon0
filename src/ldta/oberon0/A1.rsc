module ldta::oberon0::A1

import ldta::oberon0::l1::Scope;
import ldta::oberon0::l2::Bind;
import ldta::oberon0::l2::Parse;
import ldta::oberon0::l2::Implode;
import ldta::oberon0::l2::Format;

import lang::box::util::Box2Text;
import Message;
import IO;

import ldta::oberon0::Result;


public void runA1(loc l) {
  m = implode(parse(l));
  <m2, errs> = bind(m, scope(()));
  if (errs != {}) {
    e = firstError(errs);
    println(e.at.begin.line);
    return;
  }
  println(format(mod2box(m)));
}

public void formatA1(loc l) {
 println(format(mod2box(implode(parse(l)))));
}

public void bindA1(loc l) {
  m = implode(parse(l));
  <m2, errs> = bind(m, scope(()));
  if (errs != {}) {
    e = firstError(errs);
    println(e.at.begin.line);
  }
}

