module languages::oberon0::eval::Store

import languages::oberon0::ast::Oberon0;
import languages::oberon0::eval::Values;

alias Store = map[Cell, Value];


private int CELL_COUNT = -1;

Cell newCell() {
  CELL_COUNT++;
  return cell(CELL_COUNT);
}

public tuple[Cell, Store] new(Type t, Env env, Store store) {
  c = newCell();
  return <c, init(t, c, env, store)>;
}

private Store init(Type t, Cell c, Env env, Store store) {
  switch (t) {
   case user("INTEGER"): 
     store[c] = integer(0);
   case user(str n): {
     if (typeDef(env2, t2) := env[n]) {
       return init(t2, c, env2, store);
     }
     throw "Undeclared type: <n>";  
   }
   case array(e, typ): { 
     bound = asInt(eval(e, env));
     cells = for (i <- [0 .. bound - 1]) {
       <ac, store> = new(typ, env, store);
       append ac;
     }
     store[c] = array(bound, cells);
   }
   case record(fs): {
     fields = ();
     for (f <- fs, n <- f.names) {
       <fc, store> = new(f.\type, env, store);
       fields[n] = fc;
     }
     store[c] = record(fields);
   }
   default: throw "Invalid type: <t>";
  }
  return store;
}

public Store findCell(Cell c, list[Selector] sels, Env env, Store store) {
  if (sels == []) {
    return c;
  }
  old = store[c];
  switch (head(sels)) {
    case field(Ident id):  
       if (record(map[str, Cell] m) := old, m[id]?) {
          return findCell(m[id.name], tail(sels), store);
       }
       else 
          fail;
    case subscript(e):
       if (array(int n, elts) := old, i := asInt(eval(e, env, store)), i < n) {
         return find(elts[i], tail(sels), env, store);
       }
       else
         fail;
    default: throw "Invalid subscript/field-deref <x> for <old>";           	
  }
}

