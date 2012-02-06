module ldta::oberon0::A2a

import ldta::oberon0::l3::Bind;
import ldta::oberon0::l3::Parse;
import ldta::oberon0::l3::Implode;
import ldta::oberon0::l3::Scope;

import Message;
import ParseTree;
import lang::box::util::Box2Text;

public Tree parseL3(loc l) = parse(l);

public str formatL3(loc l) = format(mod2box(implode(parse(l))));

public set[Message] bindL3(loc l) = errs
  when <_, errs> := bindModule(implode(parse(l)), GLOBALS());

