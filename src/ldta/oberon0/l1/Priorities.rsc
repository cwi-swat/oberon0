module ldta::oberon0::l1::Priorities

import ldta::oberon0::l1::Syntax;
import Grammar;
import Node;
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

public &T parens(node parent, node kid, &T x,  &T(&T x) parenizer) = 
  parens(PRIOS, parent, kid, x, parenizer);

public &T parens(DoNotNest prios, node parent, node kid, &T x,  &T(&T x) parenizer) 
  = parenizer(x)
  when 
     <pprod, pos, kprod> <- prios, 
     pprod.label == getName(parent), 
     kprod.label == getName(kid);

public default &T parens(DoNotNest prios, node parent, node kid, &T x,  &T(&T x) parenizer) = x;


//rel[Production father, int position, Production child]

