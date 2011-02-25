module languages::oberon0::desugar::Desugar

import languages::oberon0::ast::Oberon0;

data Statement 
	= forDo(Ident name, Expression from, Expression to, list[Statement] body)
	| repeatUntil(list[Statement] body, Expression cond)
	| begin(list[Statement] body)
	| let(list[VarDecl] vars, list[Statement] body)
	;

public Procedure EXAMPLE = proc(id("f"), [formal(false, [id("x")], user(id("INTEGER")))], 
				decls([], [], [], []), 
				[forDo(id("i"), nat(1), nat(10), [call(id("Write"), [lookup(id("i"), [])])])],
				id("f")); 

public Procedure REPEAT = proc(id("f"), [formal(false, [id("x")], user(id("INTEGER")))], 
				decls([], [], [], []), 
				[repeatUntil([call(id("Write"), [lookup(id("i"), [])])], geq(lookup(id("i"), []), nat(0)))],
				id("f")); 

public Module desugar(Module mod) {
	return visit (mod) {
		case Procedure p => (for2let o let2begin o flattenBegin)(p)
	}
}

public Procedure repeat2while(Procedure p) {
	return visit (p) {
		case repeatUntil(b, c) => begin([b, whileDo(not(c), b)]) 
	}
}


public Procedure repeat2letWhile(Procedure p) {
	x = id("first");
	return visit (p) {
		case repeatUntil(b, c) => 
			let([varDecl([x], user(id("INTEGER")))],[
				assign(x, [], nat(1)), 
				whileDo(or(eq(lookup(x, []), nat(1)), not(c)), [
					assign(x, [], nat(0)), 
					b
				])
			]) 
	}
}

public Procedure for2letWhile(Procedure p) {
	return visit (p) {
		case forDo(n, f, t, b) => 
			let([varDecl([n], user(id("INTEGER")))],
				[assign(n, [], f), whileDo(geq(lookup(n, []), t), b)]) 
	}
}

public Procedure let2begin(Procedure p) {
	int cnt = 0;
	
	map[Ident, Ident] lift(list[VarDecl] vds) {
		subs = ();
		p.decls.vars += for (v <- vds, n <- v.names) {
			nn = id("<n.name>_<cnt>"); // _ prevents nameclashes
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