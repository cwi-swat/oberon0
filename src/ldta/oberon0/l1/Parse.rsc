module ldta::oberon0::l1::Parse

import ldta::oberon0::l1::Syntax;

import ParseTree;

public start[Module] parse(loc l) {
	return parse(#start[Module], l);
}

public start[Module] parse(str s, loc l) {
	return parse(#start[Module], s, l);
}







