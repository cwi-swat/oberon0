module languages::oberon0::compile::Resolve

import languages::oberon0::ast::Oberon0;
import languages::oberon0::compile::Table;

import IO;
import List;
import Map;


anno str Ident@longName;
anno bool Ident@isByReference;
anno Type Ident@\type;
anno str Type@structName;
anno list[Formal] Ident@formals;
anno list[Formal] Ident@captured;

public map[Ident,Entry] declared(Declarations d) {
  return ( c.name : const(c.\value) | c <- d.consts ) +
         ( t.name : typeDef(t.\type) | t <- d.types ) +
         ( n: var(v.\type) | v <- d.vars, n <- v.names ) +
         ( p.name: proc(p) | p <- d.procs );
}

public set[Ident] freeVars(Procedure p) {
  return { i | /assign(i, _, _) <- p.body } + { i | /lookup(i, _) <- p.body } - domain(locals(p));
}

public map[Ident,Entry] params(Procedure p) {
  return ( n: var(f.\type) |  f <- p.formals, n <- f.names );
}

public map[Ident,Entry] locals(Procedure p) {
    return declared(p.decls) + params(p);
}


public map[Ident,Entry] builtIns() {
  return ( 
           id("Write") : builtin([formal(false, [id("x")], user(id("INTEGER")))]), 
           id("WriteLn") : builtin([]), 
           id("Read") : builtin([formal(true, [id("x")], user(id("INTEGER")))])
  );
}

public Module resolve(Module m) {
  tbl = toplevel(builtIns() + declared(m.decls));
  m = top-down-break visit (m) {
    case Procedure p => resolve(p, tbl)
  }
  
  
  // TODO factor out this stuff in a function
  // and reuse for procs.
  m.decls.types = visit (m.decls.types) {
     case user(i) => i[@longName=longName(i, tbl)]
   }
   
   m.body = visit (m.body) {
     case call(i, a) => call(i[@longName=longName(i, tbl)][@formals=formalsOf(i, tbl)][@captured=[]], a)
     case assign(i, s, e) => assign(i[@longName=longName(i, tbl)], s, e)
     case lookup(i, s) => lookup(i[@longName=longName(i, tbl)], s)
   }

   m.body = visit (m.body) {
     case assign(i, s, e) => assign(i[@isByReference=false], s, e)
     case lookup(i, s) => lookup(i[@isByReference=false], s)
   }
  
   return m;   
}


public list[Formal] formalsOf(Ident id, SymbolTable tbl) {
  tbl = scope(id, tbl);
  switch (tbl.entries[id]) {
    case proc(p): return p.formals;
    case builtin(f): return f;
  }
}

public list[Formal] capturedVars(Ident id, SymbolTable tbl) {
  tbl = scope(id, tbl);
  switch (tbl.entries[id]) {
    case proc(p): return captured(p, tbl);
    case builtin(f): return [];
  }
}

public list[Formal] captured(Procedure p, SymbolTable tbl) {
    println(p.name);
    printSymbolTable(tbl);
    return for (fv <- freeVars(p)) {
      println("FV = <fv>");
      sc = scope(fv, tbl);
      append formal(true, [fv], sc.entries[fv].\type);
    } 
}


public Procedure resolve(Procedure p, SymbolTable tbl) {
   p.name = p.name[@longName=longName(p.name, tbl)];

   tbl = local(p.name.name, declared(p.decls), tbl);
   
   p.name = p.name[@captured=capturedVars(p.name, tbl)];
   
   tbl.entries += params(p);
   
   p.decls.procs = [ resolve(lp, tbl) | lp <- p.decls.procs ];
   
   p.decls.types = visit (p.decls.types) {
     case user(i) => i[@longName=longName(i, tbl)]
   }
   
   p.body = visit (p.body) {
     case call(i, a) => call(i[@longName=longName(i, tbl)][@formals=formalsOf(i, tbl)][@captured=capturedVars(i, tbl)], a)
     case assign(i, s, e) => assign(i[@longName=longName(i, tbl)], s, e)
     case lookup(i, s) => lookup(i[@longName=longName(i, tbl)], s)
   }

   vars = ( n: f.hasVar | f <- p.formals + p.name@captured, n <- f.names );
   p.body = visit (p.body) {
     case assign(i, s, e) => assign(i[@isByReference=vars[i] ? false], s, e)
     case lookup(i, s) => lookup(i[@isByReference=vars[i] ? false], s)
   }
   
   return p;
}



