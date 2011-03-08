module lang::oberon0::l3::compile::Oberon0ToC

extend lang::oberon0::l1::compile::Oberon0ToC;

import lang::oberon0::l3::ast::Oberon0;
import lang::oberon0::l3::compile::AnnotateByRefs; // for annos

import String;
import List;
import IO;

public str compileL3toC(Module m) {
	// assume byRefs are annotated
	return "
#include \<builtins.h\>
<decls2c(m.decls)>
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
	// const ids in array type- and vardecls are not annotated
	if ((id@receivedByRef)? && id@receivedByRef) {
		e = "(*<e>)";
	}
  	return e;
}








