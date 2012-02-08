module ldta::oberon0::A2b

import ldta::oberon0::l1::Parse;
import ldta::oberon0::l1::Implode;
import ldta::oberon0::l1::Bind;
import ldta::oberon0::l1::Scope;
import ldta::oberon0::l1::Check;

import ldta::oberon0::l2::Parse;
import ldta::oberon0::l2::Implode;
import ldta::oberon0::l2::Bind;
import ldta::oberon0::l2::Check;

import Message;

// note: if there are errors during binding, these are discarded
// we're only interested in type errors.
public set[Message] checkL1(loc l) = ldta::oberon0::l1::Check::check(m2)
  when
     pt := ldta::oberon0::l1::Parse::parse(l),
     m1 := ldta::oberon0::l1::Implode::implode(pt),
     <m2, errs> := ldta::oberon0::l1::Bind::bindModule(m1, scope(())); 

public set[Message] checkL2(loc l) = ldta::oberon0::l2::Check::check(m2)
  when
     pt := ldta::oberon0::l2::Parse::parse(l),
     m1 := ldta::oberon0::l2::Implode::implode(pt),
     <m2, errs> := ldta::oberon0::l2::Bind::bindModule(m1, scope(())); 
