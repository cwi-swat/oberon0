module ldta::oberon0::l4::Parse

import ldta::oberon0::l4::Syntax;

import Grammar;
import IO;

import ParseTree;

public start[Module] parse(loc l) = parse(#start[Module], l);
public start[Module] parse(str s, loc l) = parse(#start[Module], s, l);

