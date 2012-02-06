@cachedParser{ldta.oberon0.l3.Parser}
module ldta::oberon0::l3::Parse

import ldta::oberon0::l3::Syntax;

import lang::rascal::grammar::ParserGenerator;
import Grammar;
import IO;

import ParseTree;

public start[Module] parse(loc l) = parse(#start[Module], l);
public start[Module] parse(str s, loc l) = parse(#start[Module], s, l);

public void genL3Parser() {
  rt = #Module;
  src = generateObjectParser("ldta.oberon0.l3", "Parser", 
     grammar({rt.symbol}, rt.definitions));
  writeFile(|project://oberon0/src/ldta/oberon0/l3/Parser.java|, src);
} 





