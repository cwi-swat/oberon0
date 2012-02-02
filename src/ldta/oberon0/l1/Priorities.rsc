module ldta::oberon0::l1::Priorities

import ldta::oberon0::l1::Syntax;
import Grammar;
import lang::rascal::grammar::definition::Priorities;


public DoNotNest getOberon0Prios() {
  rt = #Module;
  // TODO: find out field labels.
  if (Symbol s := rt[0], map[Symbol, Production] m := rt[1]) {
     g = grammar({s}, m);
     return doNotNest(g);
  }
  throw "unexpected error obtaining priorities";
}

private DoNotNest PRIOS = getOberon0Prios();


//rel[Production father, int position, Production child]

