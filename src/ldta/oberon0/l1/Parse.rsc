module ldta::oberon0::l1::Parse

import ldta::oberon0::l1::Syntax;

import ParseTree;

public start[Module] parse(loc l) = parse(#start[Module], l);
public start[Module] parse(str s, loc l) = parse(#start[Module], s, l);







