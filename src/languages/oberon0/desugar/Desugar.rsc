module languages::oberon0::desugar::Desugar

import languages::oberon0::ast::Oberon0;

data Statement 
	= forLoop(Ident name, Expression from, Expression to, list[Statement] body)
	| begin(list[Statement] body)
	| let(list[VarDecl] vars, list[Statement] body)
	;

public Procedure EXAMPLE = proc(id("f"), [formal(false, [id("x")], user(id("INTEGER")))], 
				decls([], [], [], []), 
				[forLoop(id("i"), nat(1), nat(10), [call(id("Write"), [lookup(id("i"), [])])])],
				id("f")); 

public Module desugar(Module mod) {
	return visit (mod) {
		case Procedure p => (for2let o let2begin o flattenBegin)(p)
	}
}


public Procedure for2let(Procedure p) {
	return visit (p) {
		case forLoop(n, f, t, b) => 
			let([varDecl([n], user(id("INTEGER")))],
				[assign(n, [], f), whileDo(geq(lookup(n, []), t), b)]) 
	}
}

public Procedure let2begin(Procedure p) {
	int cnt = 0;
	
	map[Ident, Ident] lift(list[VarDecl] vds) {
		subs = ();
		p.decls.vars += for (v <- vds, n <- v.names) {
			nn = id("<n.name>_<cnt>");
			cnt += 1;
			subs[n] = nn;
			append varDecl([nn], v.\type);
		}
		return subs;
	}
	
	p.body = visit (p.body) {
		case let(vds, b) => begin(substitute(b, lift(vds)))
	}
	return p;
}

public list[Statement] substitute(list[Statement] stats, map[Ident, Ident] subs) {
	return visit (stats) {
		case lookup(n, sels) => lookup(subs[n], sels) when subs[n]?
		case assign(n, sels, exp) => assign(subs[n], sels, exp) when subs[n]?
	}
}

public Procedure flattenBegin(Procedure p) {
	return innermost visit (p) {
		case [s1*, begin(b), s2*] => [s1, b, s2]
	}
}