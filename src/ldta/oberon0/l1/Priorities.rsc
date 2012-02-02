module ldta::oberon0::l1::Priorities

import ldta::oberon0::l1::Syntax;
import ldta::oberon0::util::Priorities;
import lang::rascal::grammar::definition::Priorities;
import Grammar;


// NB () are required around #Module; otherwise ambiguous code error.
public DoNotNest getOberon0Prios() = doNotNest(grammar({}, (#Module).definitions));

private DoNotNest PRIOS = getOberon0Prios();

public &T parens(node parent, node kid, &T x,  &T(&T x) parenizer) = parens(PRIOS, parent, kid, x, parenizer);
