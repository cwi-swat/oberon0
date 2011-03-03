module languages::oberon0::compile::AnnotateByRefs

// we asume oberon0 progs are normalized

import languages::oberon0::ast::Oberon0;

anno bool Ident@receivedByRef;
anno bool Expression@passByRef;

alias Environment = map[Ident, list[Formal]];

Environment TOPLEVEL = (id("Write"): [formal(false, [id("x")], user(id("INTEGER")))],
				id("WriteLn"): [],
				id("Read"): [formal(true, [id("x")], user(id("INTEGER")))]); 

public Module annotateByRefs(Module m) {
	env = TOPLEVEL + ( p.name: p.formals | p <- m.decls.procs );
	m.decls.procs = [ annotateByRefs(p, env) | p <- m.decls.procs ];
	m.body = annotateByRefsInBody(m.body, env, {});
	return m;
}

public Procedure annotateByRefs(Procedure p, Environment env) {
	byRefs = { n | f <- p.formals, f.hasVar, n <- f.names };
	p.body = annotateByRefsInBody(p.body, env, byRefs);
	return p;
}

public list[Statement] annotateByRefsInBody(list[Statement] body, Environment env, set[Ident] byRefs) {
	return visit (body) {
		case lookup(n, sels): {
			n@receivedByRef = (n in byRefs);
			insert lookup(n, sels);
		}
		case assign(n, sels, exp): {
			n@receivedByRef = (n in byRefs);
			insert assign(n, sels, exp);
		}
		case call(n, args): {
			i = 0;
			args = for (f <- env[n], _ <- f.names) {
				args[i]@passByRef = f.hasVar;
				append args[i];
				i += 1;
			}
			insert call(n, args);
		}
	}
}

