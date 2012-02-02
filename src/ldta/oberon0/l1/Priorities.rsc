module ldta::oberon0::l1::Priorities

import ldta::oberon0::l1::Syntax;
import Grammar;
import Node;
import lang::rascal::grammar::definition::Priorities;
import IO;
import List;

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
     kprod.def.name == getName(kid),
     bprintln(kprod.def.name),
     bprintln(pprod),
     bprintln(pos),
     bprintln(astPosition(pos, pprod)),
     parent[astPosition(pos, pprod)] == kid;

private int astPosition(int pos, Production p)
  = ( -1 | it + 1 | i <- [0,1..pos], isASTsymbol(p.symbols[i]) );

public bool isASTsymbol(\layouts(_)) = false; 
public bool isASTsymbol(\keywords(str name)) = false;
public bool isASTsymbol(\lit(str string)) = false;
public bool isASTsymbol(\cilit(str string)) = false;
public bool isASTsymbol(\conditional(_, _)) = false;
public bool isASTsymbol(\empty()) = false;
public default bool isASTsymbol(Symbol _) = true;

public default &T parens(DoNotNest prios, node parent, node kid, &T x,  &T(&T x) parenizer) = x;

