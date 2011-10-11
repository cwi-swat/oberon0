module ldta::oberon0::A2b

import ldta::oberon0::l2::Bind;
import ldta::oberon0::l2::Parse;
import ldta::oberon0::l2::Implode;
import ldta::oberon0::l2::Check;
import ldta::oberon0::l1::Scope;
import ldta::oberon0::Result;

import IO;
import Message;


public void runA2a(loc l) {
  m = implode(parse(l));
  <m2, errs> = bind(m, scope(()));
  if (errs != {}) {
    e = firstError(errs);
    println(e.at.begin.line);
    return;
  }
  report(check(m2));
}

public void checkA2b(loc l) {  
  m = implode(parse(l));
  <m2, errs> = bind(m, scope(()));
  if (errs != {}) {
    throw "Name error(s) before type checking: <errs>";
  }
  report(check(m2));
}
