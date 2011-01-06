module languages::oberon0::compile::Oberon0

import languages::oberon0::ast::Oberon0;
import languages::oberon0::compile::Table;

import IO;
import List;
import Map;

// TODO: types

public Module sample = mod(id("Sample"),decls([],[],[],[proc(id("Nesting"),[],decls([],[],[varDecl([id("x"),id("y")],user(id("INTEGER")))],[proc(id("f"),[formal(false,[id("x")],user(id("INTEGER"))),formal(false,[id("z")],user(id("INTEGER")))],decls([],[],[],[
proc(id("g"),[],decls([],[],[],[]), [assign(id("y"), [], nat(1234)),assign(id("x"), [], nat(1234))], id("g"))
]),[call(id("Write"),[lookup(id("x"),[])]),assign(id("y"), [], nat(3)),assign(id("z"),[],add(lookup(id("z"),[]),nat(1)))],id("f"))]),[assign(id("y"),[],nat(1)),assign(id("x"),[],nat(3)),call(id("f"),[lookup(id("x"),[]),lookup(id("y"),[])])],id("Nesting")),proc(id("Multiply"),[],decls([],[],[varDecl([id("x"),id("y"),id("z")],user(id("INTEGER")))],[]),[call(id("Read"),[lookup(id("x"),[])]),call(id("Read"),[lookup(id("y"),[])]),assign(id("z"),[],nat(0)),whileDo(gt(lookup(id("x"),[]),nat(0)),[ifThen(eq(mod(lookup(id("x"),[]),nat(2)),nat(1)),[assign(id("z"),[],add(lookup(id("z"),[]),lookup(id("y"),[])))],[],[]),assign(id("y"),[],mul(nat(2),lookup(id("y"),[]))),assign(id("x"),[],div(lookup(id("x"),[]),nat(2)))]),call(id("Write"),[lookup(id("x"),[])]),call(id("Write"),[lookup(id("y"),[])]),call(id("Write"),[lookup(id("z"),[])]),call(id("WriteLn"),[])],id("Multiply")),proc(id("Divide"),[],decls([],[],[varDecl([id("x"),id("y"),id("r"),id("q"),id("w")],user(id("INTEGER")))],[]),[call(id("Read"),[lookup(id("x"),[])]),call(id("Read"),[lookup(id("y"),[])]),assign(id("r"),[],lookup(id("x"),[])),assign(id("q"),[],nat(0)),assign(id("w"),[],lookup(id("y"),[])),whileDo(leq(lookup(id("w"),[]),lookup(id("r"),[])),[assign(id("w"),[],mul(nat(2),lookup(id("w"),[])))]),whileDo(gt(lookup(id("w"),[]),lookup(id("y"),[])),[assign(id("q"),[],mul(nat(2),lookup(id("q"),[]))),assign(id("w"),[],div(lookup(id("w"),[]),nat(2))),ifThen(leq(lookup(id("w"),[]),lookup(id("r"),[])),[assign(id("r"),[],sub(lookup(id("r"),[]),lookup(id("w"),[]))),assign(id("q"),[],add(lookup(id("q"),[]),nat(1)))],[],[])]),call(id("Write"),[lookup(id("x"),[])]),call(id("Write"),[lookup(id("y"),[])]),call(id("Write"),[lookup(id("q"),[])]),call(id("Write"),[lookup(id("r"),[])]),call(id("WriteLn"),[])],id("Divide")),proc(id("BinSearch"),[],decls([],[],[varDecl([id("i"),id("j"),id("k"),id("n"),id("x")],user(id("INTEGER"))),varDecl([id("a")],array(nat(32),user(id("INTEGER"))))],[]),[call(id("Read"),[lookup(id("n"),[])]),assign(id("k"),[],nat(0)),whileDo(lt(lookup(id("k"),[]),lookup(id("n"),[])),[call(id("Read"),[lookup(id("a"),[subscript(lookup(id("k"),[]))])]),assign(id("k"),[],add(lookup(id("k"),[]),nat(1)))]),call(id("Read"),[lookup(id("x"),[])]),assign(id("i"),[],nat(0)),assign(id("j"),[],lookup(id("n"),[])),whileDo(lt(lookup(id("i"),[]),lookup(id("j"),[])),[assign(id("k"),[],div(add(lookup(id("i"),[]),lookup(id("j"),[])),nat(2))),ifThen(lt(lookup(id("x"),[]),lookup(id("a"),[subscript(lookup(id("k"),[]))])),[assign(id("j"),[],lookup(id("k"),[]))],[],[assign(id("i"),[],add(lookup(id("k"),[]),nat(1)))])]),call(id("Write"),[lookup(id("i"),[])]),call(id("Write"),[lookup(id("j"),[])]),call(id("Write"),[lookup(id("a"),[subscript(lookup(id("j"),[]))])]),call(id("WriteLn"),[])],id("BinSearch"))]),[],id("Sample"));

public Module quicksort =
mod(id("QuickSort"),decls([constDecl(id("INPUTLENGTH"),nat(4))],[],[varDecl([id("input")],array(lookup(id("INPUTLENGTH"),[]),user(id("INTEGER")))),varDecl([id("i")],user(id("INTEGER")))],[proc(id("QuickSort"),[formal(true,[id("array")],array(lookup(id("INPUTLENGTH"),[]),user(id("INTEGER")))),formal(false,[id("left"),id("right")],user(id("INTEGER")))],decls([],[],[varDecl([id("pivot"),id("leftIdx"),id("rightIdx")],user(id("INTEGER")))],[proc(id("Swap"),[formal(true,[id("x"),id("y")],user(id("INTEGER")))],decls([],[],[varDecl([id("temp")],user(id("INTEGER")))],[]),[assign(id("temp"),[],lookup(id("x"),[])),assign(id("x"),[],lookup(id("y"),[])),assign(id("y"),[],lookup(id("temp"),[]))],id("Swap"))]),[assign(id("leftIdx"),[],lookup(id("left"),[])),assign(id("rightIdx"),[],lookup(id("right"),[])),ifThen(gt(sub(lookup(id("right"),[]),lookup(id("left"),[])),nat(0)),[assign(id("pivot"),[],div(add(lookup(id("left"),[]),lookup(id("right"),[])),nat(2))),whileDo(amp(leq(lookup(id("leftIdx"),[]),lookup(id("pivot"),[])),geq(lookup(id("rightIdx"),[]),lookup(id("pivot"),[]))),[whileDo(amp(lt(lookup(id("array"),[subscript(lookup(id("leftIdx"),[]))]),lookup(id("array"),[subscript(lookup(id("pivot"),[]))])),leq(lookup(id("leftIdx"),[]),lookup(id("pivot"),[]))),[assign(id("leftIdx"),[],add(lookup(id("leftIdx"),[]),nat(1)))]),whileDo(amp(gt(lookup(id("array"),[subscript(lookup(id("rightIdx"),[]))]),lookup(id("array"),[subscript(lookup(id("pivot"),[]))])),geq(lookup(id("rightIdx"),[]),lookup(id("pivot"),[]))),[assign(id("rightIdx"),[],sub(lookup(id("rightIdx"),[]),nat(1)))]),call(id("Swap"),[lookup(id("array"),[subscript(lookup(id("leftIdx"),[]))]),lookup(id("array"),[subscript(lookup(id("rightIdx"),[]))])]),assign(id("leftIdx"),[],add(lookup(id("leftIdx"),[]),nat(1))),assign(id("rightIdx"),[],sub(lookup(id("rightIdx"),[]),nat(1))),ifThen(eq(sub(lookup(id("leftIdx"),[]),nat(1)),lookup(id("pivot"),[])),[assign(id("rightIdx"),[],add(lookup(id("rightIdx"),[]),nat(1))),assign(id("pivot"),[],lookup(id("rightIdx"),[]))],[<eq(add(lookup(id("rightIdx"),[]),nat(1)),lookup(id("pivot"),[])),[assign(id("leftIdx"),[],sub(lookup(id("leftIdx"),[]),nat(1))),assign(id("pivot"),[],lookup(id("leftIdx"),[]))]>],[])]),call(id("QuickSort"),[lookup(id("array"),[]),lookup(id("left"),[]),sub(lookup(id("pivot"),[]),nat(1))]),call(id("QuickSort"),[lookup(id("array"),[]),add(lookup(id("pivot"),[]),nat(1)),lookup(id("right"),[])])],[],[])],id("QuickSort"))]),[assign(id("i"),[],nat(0)),whileDo(lt(lookup(id("i"),[]),lookup(id("INPUTLENGTH"),[])),[call(id("Read"),[lookup(id("input"),[subscript(lookup(id("i"),[]))])]),assign(id("i"),[],add(lookup(id("i"),[]),nat(1)))]),call(id("QuickSort"),[lookup(id("input"),[]),nat(0),sub(lookup(id("INPUTLENGTH"),[]),nat(1))]),assign(id("i"),[],nat(0)),whileDo(lt(lookup(id("i"),[]),lookup(id("INPUTLENGTH"),[])),[call(id("Write"),[lookup(id("input"),[subscript(lookup(id("i"),[]))])]),call(id("WriteLn"),[]),assign(id("i"),[],add(lookup(id("i"),[]),nat(1)))])],id("QuickSort"));

public Procedure nesting = proc(id("Nesting"),[],decls([],[],[varDecl([id("x"),id("y")],user(id("INTEGER")))],[proc(id("f"),[formal(false,[id("x")],user(id("INTEGER"))),formal(false,[id("z")],user(id("INTEGER")))],decls([],[],[],[]),[call(id("Write"),[lookup(id("x"),[])]),assign(id("z"),[],add(lookup(id("z"),[]),nat(1)))],id("f"))]),[assign(id("y"),[],nat(1)),assign(id("x"),[],nat(3)),call(id("f"),[lookup(id("x"),[]),lookup(id("y"),[])])],id("Nesting"));

public Procedure nesting_f = proc(id("f"),[formal(false,[id("x")[@location=|project://oberon0/src/sample.oberon0|(81,1,<7,14>,<7,15>)]],user(id("INTEGER")[@location=|project://oberon0/src/sample.oberon0|(84,7,<7,17>,<7,24>)])[@location=|project://oberon0/src/sample.oberon0|(84,7,<7,17>,<7,24>)])[@location=|project://oberon0/src/sample.oberon0|(81,10,<7,14>,<7,24>)],formal(false,[id("z")[@location=|project://oberon0/src/sample.oberon0|(97,1,<7,30>,<7,31>)]],user(id("INTEGER")[@location=|project://oberon0/src/sample.oberon0|(100,7,<7,33>,<7,40>)])[@location=|project://oberon0/src/sample.oberon0|(100,7,<7,33>,<7,40>)])[@location=|project://oberon0/src/sample.oberon0|(93,14,<7,26>,<7,40>)]],decls([],[],[],[]),[call(id("Write")[@location=|project://oberon0/src/sample.oberon0|(123,5,<9,5>,<9,10>)],[lookup(id("x")[@location=|project://oberon0/src/sample.oberon0|(129,1,<9,11>,<9,12>)],[])[@location=|project://oberon0/src/sample.oberon0|(129,1,<9,11>,<9,12>)]])[@location=|project://oberon0/src/sample.oberon0|(123,8,<9,5>,<9,13>)],assign(id("y"), [], nat(3)), assign(id("z")[@location=|project://oberon0/src/sample.oberon0|(138,1,<10,5>,<10,6>)],[],add(lookup(id("z")[@location=|project://oberon0/src/sample.oberon0|(143,1,<10,10>,<10,11>)],[])[@location=|project://oberon0/src/sample.oberon0|(143,2,<10,10>,<10,12>)],nat(1)[@location=|project://oberon0/src/sample.oberon0|(147,1,<10,14>,<10,15>)])[@location=|project://oberon0/src/sample.oberon0|(143,5,<10,10>,<10,15>)])[@location=|project://oberon0/src/sample.oberon0|(138,10,<10,5>,<10,15>)]],id("f"));



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
   
  return nameRecords(m);
}


public Module nameRecords(Module m) {
  structs = ();
  int i = 0;
  return visit (m) {
    case r:record(fs): {
      if (!structs[r]?) {
        i += 1;
        structs[r] = i;
      }
      insert record(fs)[@structName="record<structs[r]>"];
    }
  } 
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



