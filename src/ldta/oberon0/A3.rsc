module ldta::oberon0::A3

import ldta::oberon0::l3::Implode;
import ldta::oberon0::l3::Parse;
import ldta::oberon0::l3::Check;
import ldta::oberon0::l3::Bind;
import ldta::oberon0::l3::Scope;
import ldta::oberon0::l3::Format;

import Message;
import lang::box::util::Box2Text;

public str formatL3(loc l) = format(mod2box(implode(parse(l))));

public set[Message] checkL3(loc l) = check(m)
  when
    <m, errs> := bindModule(implode(parse(l)), GLOBALS());

