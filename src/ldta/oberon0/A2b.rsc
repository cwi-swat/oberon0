module ldta::oberon0::A2b

import ldta::oberon0::l2::Bind;
import ldta::oberon0::l2::Parse;
import ldta::oberon0::l2::Implode;
import ldta::oberon0::l2::Check;
import ldta::oberon0::l1::Scope;

import IO;
import Message;

public void check(loc l) {  
  m = implode(parse(l));
  <m2, errs> = bind(m, scope(()));
  if (errs != {}) {
    for (e <- errs) 
      println("Name error: <e.msg> at line <e.at.begin.line>");
    return;
  }
  errs = check(m2);
  for (e <- errs) 
    println("Type error: <e.msg> at line <e.at.begin.line>");
}
