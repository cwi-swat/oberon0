module ldta::oberon0::l2::Parse

import ldta::oberon0::l2::Syntax;

import lang::rascal::grammar::ParserGenerator;
import Grammar;
import IO;

import ParseTree;

public start[Module] parse(loc l) = parse(#start[Module], l);
public start[Module] parse(str s, loc l) = parse(#start[Module], s, l);






