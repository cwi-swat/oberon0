module languages::oberon0::eval::IO

import List;
import String;
import languages::oberon0::eval::Values;

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


