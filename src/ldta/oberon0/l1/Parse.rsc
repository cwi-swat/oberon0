module ldta::oberon0::l1::Parse

import ldta::oberon0::l1::Syntax;

import ParseTree;

public Module parse(loc l) {
	return parse(#Module, l);
}

public Module parse(str s, loc l) {
	return parse(#Module, s, l);
}







