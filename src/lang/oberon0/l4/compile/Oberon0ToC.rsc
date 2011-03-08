module lang::oberon0::l4::compile::Oberon0ToC

import lang::oberon0::l4::ast::Oberon0;
extend lang::oberon0::l3::compile::Oberon0ToC;

import String;
import List;

public str compileL4toC(Module m) {
	return compileL3toC(m);
}

public str stat2c(assign(v, sels, exp)) = "<var2c(v, sels)> = <exp2c(exp)>;";

public str exp2c(lookup(v, sels)) = var2c(v, sels);

public str var2c(Ident id, list[Selector] sels) {
  	return "<var2c(id)><sels2c(sels)>";
}

public str sels2c(list[Selector] sels) {
  csels = for (s <- sels) {
    switch (s) {
      case field(Ident id): append ".<id.name>";
      case subscript(e): append "[<exp2c(e)>]";
    }
  }
  return ("" | it + cs | cs <- csels);
}


public str varType2c(str v, array(b, et)) {
	<base, bounds> = baseBounds(et, b);
	return "<base> <v><bounds>";
}


public tuple[str, str] baseBounds(Type t, Expression bound) {
  switch (t) {
    case array(b2, et): {
      <t2, bound2> = baseBounds(et, b2);
      return <t2, bound1 + bound2>;
    }
    default: return <"<type2c(t)>", "[<exp2c(bound)>]">;
  }
}

public str type2c(record(fs)) = "struct { <fields2c(fs)> }";

public str fields2c(list[Field] fs) {
 	return ("" | it + "<varType2c(n.name, f.\type)>;\n" | f <- fs, n <- f.names );
}







