module lang::oberon0::l3::eval::IO

import lang::oberon0::l1::eval::Memory;

alias Stream = list[str];
alias IO = tuple[Stream input, Stream output];

public IO write(value v, IO io) {
  	io.output += ["<v>"];
  	return io;
}

public tuple[Value, IO] readInt(IO io) {
  	x = head(io.input);
  	io.input = tail(io.input);
  	return <integer(toInt(x)), io> ;  
}
           
public int asInt(Value v) {
  	if (integer(int i) := v) {
    	return i;
  	}
  	throw "Expected integer(int x): <v>"; 
}