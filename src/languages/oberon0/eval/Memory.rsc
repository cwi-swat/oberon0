module languages::oberon0::eval::Memory

import languages::oberon0::ast::Oberon0;

import List;

data Value = integer(int n)
           | boolean(bool b);
           
public int asInt(Value v) {
  if (integer(int i) := v) {
    return i;
  }
  throw "Expected integer(int x): <v>"; 
}

data Bindable = lvalue(Address addr, Type \type);
alias Address = int;
alias Memory = list[Value];

public Memory empty() {
  return [];
}

public tuple[Address,Memory] new(Type t, Memory mem) {
  return <size(mem), mem + allocate(t)>;
}

public tuple[int, Type] offset(list[Selector] sels, Type t) {
  if (sels == []) {
    return <0, t>;
  }
  
  h = head(sels);
  
  if (field(Ident id) := h, record(fs) := t) {
    o = 0;
    for (f <- fs, n <- f.names) {
      if (n == id.name) {
        <o2, t2> = offset(tail(sels), f.\type);
        return <o + o2, t2>;
      }
      o += sizeOf(f.\type);
    }
    throw "No such field: <id.name>";
  }

  if (subscript(nat(int i)) := h, a:array(nat(int b), Type et) := t) {
     <o2, t2> = offset(tail(sels), et);
     return <i * sizeOf(et) + o2, t2>; 
  }
  
  throw "Invalid selector <h> for <t>";
}


public int sizeOf(Type t) {
  switch (t) {
    case user(id("INTEGER")):
      return 1;
    case user(id("BOOLEAN")):
      return 1;
    case array(nat(int n), Type et):
      return n * sizeOf(et);
    case record(fs): 
      return ( 0 | it + sizeOf(f.\type) | f <- fs, n <- f.names );
  }
}

public Value derefValue(Address base, list[Selector] sels, Type t, Memory mem) {
  return deref(base, sels, t, mem)[0];
}

public tuple[Value,Type] deref(Address base, list[Selector] sels, Type t, Memory mem) {
  lv = lvalueOf(base, sels, t, mem);
  return <mem[lv.addr], lv.\type>;
}

public Bindable lvalueOf(Address base, list[Selector] sels, Type t, Memory mem) {
  <o, t> = offset(sels, t);
  return lvalue(base + o, t);
}

public Address addressOf(Address base, list[Selector] sels, Type t, Memory mem) {
  return lvalueOf(base, sels, t, mem).addr;
}


public Memory allocate(Type t) {
  switch (t) {
    case user(id("INTEGER")):
      return [integer(0)];
    case user(id("BOOLEAN")):
      return [boolean(false)];
    case array(nat(int n), Type et): 
      return ( [] | it + allocate(et) | i <- [0..n-1] );
    case record(fs): 
      return ( [] | it + allocate(f.\type) | f <- fs, n <- f.names );
    default: throw "Unhandled type: <t>";  
    
  }
}

public Memory pop(Memory mem, Address scope) {
   return slice(mem, 0, scope);
}

public Address push(Memory mem) {
   return size(mem);
}


public Memory update(Address addr, Value v, Memory mem) {
  mem[addr] = v;
  return mem;
}