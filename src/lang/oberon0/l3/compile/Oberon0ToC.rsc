module lang::oberon0::l3::compile::Oberon0ToC

extend lang::oberon0::l1::compile::Oberon0ToC;

import lang::oberon0::l3::ast::Oberon0;
import lang::oberon0::l3::compile::AnnotateByRefs;

import String;
import List;

public str compileL3toC(Module m) {
	// call annotate here, since the compiler will throw if annos are absent
	// we assume m is resolved and lifted.
	m = annotateByRefs(m);
	return "
#include \<builtins.h\>
<decls2c(decls)>
<procs2cdecls(m.decls.procs)>
<procs2c(m.decls.procs)>
<body2c(m.body)>
";
}

public str procs2cdecls(list[Procedure] procs) {
	return ( "" | it + proc2csig(p) + ";\n" | p <- procs );
}

public str proc2csig(Procedure p) {
	return "static void <p.name.name>(<formals2c(p)>)";
}

public str procs2c(list[Procedure] procs) {
	return ( "" | it + proc2c(p) | p <- procs );
}

public str proc2c(Procedure p) {
	byRef = { n | f <- p.formals, f.hasVar, n <- f.names };
 	return "
<proc2csig(p)> {
  <vars2c(p.decls.vars)>
  <stats2c(p.body)>
}
";
}

public str formals2c(Procedure p) {
  cfs = for (f <- p.formals, n <- f.names) {
    append f.hasVar ? varType2c("(*<n.name>)", f.\type) : varType2c(n.name, f.\type);
  }
  return intercalate(", ", cfs);
}


// Default, because extended later...
public str default varType2C(str v, Type t) = "<type2c(t)> <v>";


public str stat2c(call(Ident id, args)) {
  cargs = [ (a@passByRef) ? "&(<e>)" : e | a <- args, str e := exp2c(a) ];
  return "<id.name>(<intercalate(", ", cargs)>)";
}

public str var2c(Ident id) {
	e = id.name;
	if (id@receivedByRef) {
		e = "(*<e>)";
	}
  	return e;
}








