module lang::oberon0::l4::compile::AnnotateByRefs

import lang::oberon0::l4::ast::Oberon0;

extend lang::oberon0::l3::compile::AnnotateByRefs;

import IO;

public Expression annotateExp(lookup(n, sels), set[Ident] byRefs) {
	n@receivedByRef = (n in byRefs);
	println("Annotating: <n>");
	return lookup(n, sels);
}

public Statement annotateStat(assign(n, sels, exp), Env env, set[Ident] byRefs) {
	n@receivedByRef = (n in byRefs);
	return assign(n, sels, exp);
}


