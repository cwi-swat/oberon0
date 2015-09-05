module lang::oberon0::l1::format::Priorities

import lang::oberon0::l1::\syntax::Expressions;
import lang::rascal::grammar::definition::Priorities;
import Grammar;
import Node;
import lang::rascal::grammar::definition::Priorities;
import IO;
import List;


// NB () are required around #Expression; otherwise ambiguous code error.
public DoNotNest getOberon0Prios() = doNotNest(grammar({}, (#Expression).definitions));

private DoNotNest PRIOS = getOberon0Prios();

public DoNotNest oberon0Prios() = PRIOS;

public &T parens(DoNotNest prios, node parent, node kid, &T x,  &T(&T x) parenizer) = parenizer(x)
  when 
     <pprod, pos, kprod> <- prios,
     pprod.def has name,
     kprod.def has name, 
     pprod.def.name == getName(parent), 
     kprod.def.name == getName(kid),
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
