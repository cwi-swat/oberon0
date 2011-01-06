module languages::oberon0::compile::Table

import languages::oberon0::ast::Oberon0;
import IO;

data SymbolTable = toplevel(map[Ident,Entry] entries)
			     | local(str name, map[Ident,Entry] entries, SymbolTable parent);
			     
data Entry = var(Type \type)
		   | const(Expression exp)
		   | typeDef(Type \type)
		   | proc(Procedure proc)
		   | builtin(list[Formal] formals);
			     
public str longName(Ident i, SymbolTable tbl) {
   tbl = scope(i, tbl);
   return i.name + path(tbl);
}

private str path(SymbolTable tbl) {
  switch (tbl) {
    case toplevel(_): return "";
    case local(n, _, p): return "_" + n + path(p);
  }
}

public SymbolTable scope(Ident i, SymbolTable tbl) {
  if (i in tbl.entries) {
    return tbl;
  }
  if (local(_, v, p) := tbl) {
     return scope(i, p);
  }
  throw "undeclared name: <i.name>";
}


public str indent(int n) {
  return ("" | it + " " | i <- [0..n-1] );
}

public void printEntries(map[Ident, Entry] es) {
  for (k <- es) { 
    println(" <k.name>: <es[k]>");
  }
}

public void printSymbolTable(SymbolTable t) {
  switch (t) {
    case toplevel(es): {
      println("TOPLEVEL:"); 
      printEntries(es);
    }
    case local(n, es, p): {
      println("SCOPE: <n>");
      printEntries(es);
      printSymbolTable(p);
      
    }
  }
}