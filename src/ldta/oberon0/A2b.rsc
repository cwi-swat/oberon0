module ldta::oberon0::A2b

import ldta::oberon0::l2::Bind;
import ldta::oberon0::l2::Parse;
import ldta::oberon0::l2::Implode;
import ldta::oberon0::l2::Check;
import ldta::oberon0::l1::Scope;

import Message;

public set[Message] checkL1(loc l) = checkL2(l);

public set[Message] checkL2(loc l) {  
  m = implode(parse(l));
  <m2, errs> = bind(m, scope(()));
  return errs + check(m2);
}
