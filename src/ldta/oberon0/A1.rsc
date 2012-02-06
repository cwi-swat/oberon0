module ldta::oberon0::A1

import ldta::oberon0::l1::Parse;
import ldta::oberon0::l1::Implode;
import ldta::oberon0::l1::Scope;
import ldta::oberon0::l1::Bind;

import ldta::oberon0::l2::Parse;
import ldta::oberon0::l2::Implode;
import ldta::oberon0::l2::Bind;
import ldta::oberon0::l2::Format;

import lang::box::util::Box2Text;
import Message;
import ParseTree;

public str formatL2(loc l) = format(mod2box(implode(parse(l))));

public Tree parseL1(loc l) = ldta::oberon0::l1::Parse::parse(l);
public Tree parseL2(loc l) = ldta::oberon0::l2::Parse::parse(l);

public Tree implodeL1(loc l) = ldta::oberon0::l1::Implode::implode(parseL1(l));
public Tree implodeL2(loc l) = ldta::oberon0::l2::Implode::implode(parseL2(l));

public set[Message] bindL1(loc l) = errs
   when <_, errs> := ldta::oberon0::l1::Bind::bindModule(implodeL1(l), scope(()));

public set[Message] bindL2(loc l) = errs
   when <_, errs> := ldta::oberon0::l2::Bind::bindModule(implodeL2(l), scope(()));

