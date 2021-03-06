module ldta::oberon0::l4::CompileToC

import ldta::oberon0::l4::AST;
extend ldta::oberon0::l3::CompileToC;

import String;
import List;

public str compileL4toC(Module m) = compileL3toC(m);

public str stat2c(assign(v, sels, exp)) = "<var2c(v, sels)> = <exp2c(exp)>;";

public Expression sizeOf(array(b, et)) = mul(b, sizeOf(et));
public Expression sizeOf(record(fs)) = ( nat(0) | add(it, sizeOf(t)) | field(ns, t) <- fs, _ <- ns );
public default Expression sizeOf(Type t) = nat(1); 

public str exp2c(lookup(v, sels)) = var2c(v, sels);

public str var2c(Ident id, list[Selector] sels) = "<var2c(id)><sels2c(sels)>";

public str sels2c(list[Selector] sels) {
  csels = for (s <- sels) {
    switch (s) {
      case field(Ident id): append ".<id.name>";
      case subscript(e): append "._[<exp2c(e)>]";
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
      return <t2, "[<exp2c(bound)>]" + bound2>;
    }
    default: return <"<type2c(t)>", "[<exp2c(bound)>]">;
  }
}

public str type2c(record(fs)) = "struct {
                                '  <fields2c(fs)>
                                '}";

public str type2c(t:array(b, et)) = "struct { <varType2c("_", t)>; }";

public str fields2c(list[Field] fs) = intercalate("\n", [ "<varType2c(n.name, f.\type)>;" | f <- fs, n <- f.names ]);

public str expForFormal(e:lookup(x, ss), Formal f) {
   if (!f.hasVar) {
     return exp2c(e);
   }
   if (param(_, _, true) := x@decl) {
     return "&((*<x.name>)<sels2c(ss)>)";
   }
   return "&(<x.name><sels2c(ss)>)";
}







