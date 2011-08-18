module ldta::oberon0::A1

import ldta::oberon0::l2::Bind;
import ldta::oberon0::l2::Parse;
import ldta::oberon0::l2::Implode;
import ldta::oberon0::l2::Format;

import lang::box::util::Box2Text;
import Message;
import IO;

public void format(loc l) {
 println(format(mod2box(implode(parse(l)))));
}

public void bind(loc l) {
  m = implode(parse(l));
  <m2, errs> = bind(m, scope(()));
  for (e <- errs) {
    println("Name error: <e.msg> at line <e.at.begin.line>");
  }
}

