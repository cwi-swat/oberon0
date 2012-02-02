module ldta::oberon0::l1::Priorities

import ldta::oberon0::l1::Syntax;
import Grammar;
import Node;
import lang::rascal::grammar::definition::Priorities;
import IO;

// NB () are required around #Module; otherwise ambiguous code error.
public DoNotNest getOberon0Prios() = doNotNest(grammar({}, (#Module).definitions));

private DoNotNest PRIOS = getOberon0Prios();

public &T parens(node parent, node kid, &T x,  &T(&T x) parenizer) = parens(PRIOS, parent, kid, x, parenizer);

public &T parens(DoNotNest prios, node parent, node kid, &T x,  &T(&T x) parenizer) = parenizer(x)
  when 
     <pprod, pos, kprod> <- prios,
     pprod.def has name,
     kprod.def has name, 
     pprod.def.name == getName(parent), 
     kprod.def.name == getName(kid);
     // NEED AST positions.
     //bprintln(kprod.def.name),
     //bprintln(kid),
     //bprintln(pos / 2),
     //parent[pos / 2] == kid;

public default &T parens(DoNotNest prios, node parent, node kid, &T x,  &T(&T x) parenizer) = x;

