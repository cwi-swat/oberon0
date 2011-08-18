module ldta::oberon0::l3::Parse

import ldta::oberon0::l3::Syntax;

import ParseTree;

public Module parse(loc l) = parse(#Module, l);
public Module parse(str s, loc l) = parse(#Module, s, l);







