module ldta::oberon0::l1::eval::Memory

import ldta::oberon0::l1::AST;

import List;
import String;

data Value 
	= integer(int n)
	| boolean(bool b)
	;
           
data Bindable = 
	lvalue(Address addr, Type \type)
	;

alias Address = int;
alias Memory = list[Value];

public Memory empty() {
  	return [];
}

public tuple[Address,Memory] new(Type t, Memory mem) {
  	return <size(mem), mem + allocate(t)>;
}

public int sizeOf(user(id("INTEGER"))) = 1;
public int sizeOf(user(id("BOOLEAN"))) = 1;

public Memory allocate(user(id("INTEGER"))) = [integer(0)];
public Memory allocate(user(id("BOOLEAN"))) = [boolean(false)];

public Memory copy(Address from, Address to, Type t, Memory mem) {
  // we assume there's enough space allocated
  	for (i <- [0..sizeOf(t)-1]) {
    	mem[to + i] = mem[from + i];
  	}
  	return mem; 
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

public Address addressOf(Address base, Type t, Memory mem) {
	return base;
}
public Value derefValue(Address base, Type t, Memory mem) {
  	return deref(base, t, mem)[0];
}

public tuple[Value,Type] deref(Address base, Type t, Memory mem) {
  	lv = lvalueOf(base, t, mem);
  	return <mem[lv.addr], lv.\type>;
}

public Bindable lvalueOf(Address base, Type t, Memory mem) {
  	return lvalue(base, t);
}




