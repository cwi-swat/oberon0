module lang::oberon0::l2::desugar::Desugar

import lang::oberon0::l2::ast::Oberon0;

import IO;
import List;

data Statement 
	= begin(list[Statement] body)
	| let(list[VarDecl] vars, list[Statement] body)
	;

alias DeclsBody = tuple[Declarations decls, list[Statement] body];

public Module desugar(Module mod) {
	mod.body = (for2letWhile o repeat2while o case2ifs o flattenBegin)(mod.body);
	<mod.decls, mod.body> = liftLet(mod.decls, mod.body);
	return mod;
}

public list[Statement] case2ifs(list[Statement] stats) {
	Statement cases2if(Expression e, list[Case] cs, list[Statement] es) {
		eis = [ <eq(e, c.guard), c.body> | c <- tail(cs) ];
		c = head(cs);
		return ifThen(eq(e, c.guard), c.body, es); 
	}
	
	return visit (stats) {
		case caseOf(e, [], es) => begin(es)
		case caseOf(e, cs, es) => cases2if(e, cs, es)
	}
}


public list[Statement] repeat2while(list[Statement] stats) {
	return visit (stats) {
		case repeatUntil(b, c) => begin([b, whileDo(not(c), b)]) 
	}
}

public list[Statement] repeat2letWhile(list[Statement] stats) {
	x = id("first");
	return visit (stats) {
		case repeatUntil(b, c) => 
			let([varDecl([x], user(id("INTEGER")))],[
				assign(x, nat(1)), 
				whileDo(or(eq(lookup(x), nat(1)), not(c)), [
					assign(x, nat(0)), 
					b
				])
			]) 
	}
}

public list[Statement] for2letWhile(list[Statement] stats) {
	return visit (stats) {
		case forDo(n, f, t, b) => 
			let([varDecl([n], user(id("INTEGER")))],
				[assign(n, f), whileDo(geq(lookup(n), t), b)]) 
	}
}

public tuple[Declarations, list[Statement]] liftLet(Declarations decls, list[Statement] stats) {
	int cnt = 0;
	
	map[Ident, Ident] lift(list[VarDecl] vds) {
		subs = ();
		decls.vars += for (v <- vds, n <- v.names) {
			nn = id("<n.name>_<cnt>"); // _ prevents nameclashes
			cnt += 1;
			subs[n] = nn;
			append varDecl([nn], v.\type);
		}
		return subs;
	}
	
	stats = visit (stats) {
		case let(vds, b) => begin(substitute(b, lift(vds)))
	}
	return <decls, stats>;
}

public list[Statement] substitute(list[Statement] stats, map[Ident, Ident] subs) {
	return visit (stats) {
		case lookup(n) => lookup(subs[n]) when subs[n]?
		case assign(n, exp) => assign(subs[n], exp) when subs[n]?
	}
}

public list[Statement] flattenBegin(list[Statement] stats) {
	return innermost visit (stats) {
		case [s1*, begin(b), s2*] => [s1, b, s2]
	}
}