module ldta::oberon0::l3::CompileToC

extend ldta::oberon0::l1::CompileToC;
import ldta::oberon0::l3::AST;
import ldta::oberon0::l3::Scope;

import String;
import List;
import IO;

public str compileL3toC(Module m) {
	  return "
#include \<builtins.h\>
<decls2c(m.decls)>
<procs2cdecls(m.decls.procs)>
<procs2c(m.decls.procs)>
<body2c(m.body)>
";
}

public str procs2cdecls(list[Procedure] procs) = ( "" | it + proc2csig(p) + ";\n" | p <- procs );

public str proc2csig(Procedure p) = "static void <p.name.name>(<formals2c(p)>)";

public str procs2c(list[Procedure] procs) = ( "" | it + proc2c(p) | p <- procs );

public str proc2c(Procedure p) {
 	return "<proc2csig(p)> {
           '  <vars2c(p.decls.vars)>
           '  <stats2c(p.body)>
           '}\n";
}

public str formals2c(Procedure p) {
  cfs = for (f <- p.formals, n <- f.names) {
    append f.hasVar ? varType2c("(*<n.name>)", f.\type) : varType2c(n.name, f.\type);
  }
  return intercalate(", ", cfs);
}

// Default, because extended later...
public default str varType2C(str v, Type t) = "<type2c(t)> <v>";

public str stat2c(call(Ident id, args)) {
  fs = (id@decl).formals;
  i = 0;
  cargs = for (f <- fs, n <- f.names) {
    append expForFormal(args[i], f);
    i += 1;
  }
  return "<id.name>(<intercalate(", ", cargs)>);";
}

public str expForFormal(lookup(x), Formal f) {
   passedByVar = (param(_, _, true) := x@decl);
   if (!f.hasVar && !passedByVar) {
     return "<x.name>";
   }
   if (!f.hasVar && passedByVar) {
     return "*<x.name>";
   }
   if (passedByVar) {
     return "<x.name>";
   }
   return "&(<x.name>)";
}

public default str expForFormal(Expression e, Formal _) = exp2c(e);

public str var2c(Ident id) = (param(_, _, true) := id@decl) ? "*<id.name>" : id.name;








