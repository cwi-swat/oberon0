module lang::oberon0::l3::compile::AnnotateByRefs

// we asume oberon0 progs are normalized

import lang::oberon0::l3::ast::Oberon0;

anno bool Ident@receivedByRef;
anno bool Expression@passByRef;

alias Env = map[Ident, list[Formal]];

Env TOPLEVEL = (id("Write"): [formal(false, [id("x")], user(id("INTEGER")))],
				id("WriteLn"): [],
				id("Read"): [formal(true, [id("x")], user(id("INTEGER")))]); 

public Module annotateByRefs(Module m) {
	env = TOPLEVEL + ( p.name: p.formals | p <- m.decls.procs );
	m.decls.procs = [ annotateByRefs(p, env) | p <- m.decls.procs ];
	m.body = annotateByRefsInBody(m.body, env, {});
	return m;
}

public Procedure annotateByRefs(Procedure p, Env env) {
	byRefs = { n | f <- p.formals, f.hasVar, n <- f.names };
	p.body = annotateByRefsInBody(p.body, env, byRefs);
	return p;
}

public list[Statement] annotateByRefsInBody(list[Statement] body, Env env, set[Ident] byRefs) {
	return visit (body) {
		case Expression e => annotateExp(e, byRefs)
		case Statement s => annotateStat(s, env, byRefs)
	}
}

public Expression annotateExp(lookup(n), set[Ident] byRefs) {
	n@receivedByRef = (n in byRefs);
	return lookup(n);
}

public Expression default annotateExp(Expression exp, set[Ident] byRefs) = exp;

public Statement annotateStat(assign(n, exp), Env env, set[Ident] byRefs) {
	n@receivedByRef = (n in byRefs);
	return assign(n, exp);
}

public Statement annotateStat(call(n, args), Env env, set[Ident] byRefs) {
	i = 0;
	args = for (f <- env[n], _ <- f.names) {
		args[i]@passByRef = f.hasVar;
		append args[i];
		i += 1;
	}
	return call(n, args);
}

public Statement default annotateStat(Statement stat, Env env, set[Ident] byRefs) = stat;

