module ldta::oberon0::A1

import ldta::oberon0::l1::Scope;
import ldta::oberon0::l2::Bind;
import ldta::oberon0::l2::Parse;
import ldta::oberon0::l2::Implode;
import ldta::oberon0::l2::Format;

import lang::box::util::Box2Text;
import Message;
import ParseTree;

public str formatL2(loc l) {
  return format(mod2box(implode(parse(l))));
}

public Tree parseL1(loc l) = parse(l);
public Tree parseL2(loc l) = parse(l);

public Tree implodeL1(loc l) = implode(parse(l));
public Tree implodeL2(loc l) = implode(parse(l));


public set[Message] bindL1(loc l) = bindL2(l);

public set[Message] bindL2(loc l) {
  m = implode(parse(l));
  <m2, errs> = bindModule(m, scope(()));
  return errs;
}

