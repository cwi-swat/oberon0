module lang::oberon0::l4::eval::Memory

import lang::oberon0::l1::eval::Memory;
import lang::oberon0::l1::ast::Oberon0; // For Type
import lang::oberon0::l4::ast::Oberon0;

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


public int sizeOf(array(nat(int n), Type et)) = n * sizeOf(et);

public int sizeOf(record(fs)) =  ( 0 | it + sizeOf(f.\type) | f <- fs, n <- f.names );

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

public Memory allocate(array(nat(int n), Type et)) = ( [] | it + allocate(et) | i <- [0..n-1] );
public Memory allocate(record(fs)) = ( [] | it + allocate(f.\type) | f <- fs, n <- f.names );


// These don't use the L1 version; have to propagate selectors everywhere.

public Address lookupAddress(Ident id, list[Selector] sels, Env env, Memory mem) {
	if (lvalue(a, t) := env[id]) {
		return addressOf(a, sels, t, mem);
	}
	throw "Not a variable: <id.name>";
}

public Value lookupValue(Ident id, Env env, Memory mem) {
  return lookupValue(id, [], env, mem);
}

public Value lookupValue(Ident id, list[Selector] sels, Env env, Memory mem) {
  switch (env[id]) {
    case lvalue(a, t):
      return derefValue(a, sels, t, mem);
    case const(v): 
      return v;
  }
  throw "Not a const/var: <id.name>";
}


