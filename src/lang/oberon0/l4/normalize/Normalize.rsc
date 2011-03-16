module lang::oberon0::l4::normalize::Normalize

import lang::oberon0::l4::ast::Oberon0;
extend lang::oberon0::l3::normalize::Normalize;
import lang::oberon0::l2::desugar::Desugar;

import List;
import Set;
import IO;


data Statement
	= let(list[VarDecl] vars, list[Statement] body)
	;


public Module normalizeL4(Module m) {
	return normalizeSelectors(normalize(m));
}

public Module normalizeSelectors(Module m) {
	return visit (m) {
		case assign(v, e) => assign(v, [], e)
		case lookup(v) => lookup(v, [])
	}
}



public Module flattenBegins(Module m) {
	return innermost visit (m) {
		case [s1*, begin(b), s2*] => [s1, b, s2]
	}
}

public Module liftLets(Module m) {
    m = visit (m) {
		case Procedure p: {
			<p.decls, p.body> = liftLet(p.decls, p.body);
			insert p;
		}
	}
	<m.decls, m.body> = liftLet(m.decls, m.body);
	return m;
}


public Module normalizeBooleans(Module m) {
	return (desugarBooleans o liftLets o flattenBegins)(m);
}


public Module desugarBooleans(Module m) {

	Statement while2let(s:whileDo(c, b)) {
		x = uniqueName(s);
		return let([varDecl([x], user(id("BOOLEAN")))], [assign(x, [], c),
			whileDo(lookup(x, []), [b, assign(x, [], c)])]);
	}
	
	Statement assignCompareToIf(assign(n,sels,compare)) {
		return ifThen(compare, [assign(n, sels, \true())], [], [assign(n, sels, \false())]);
	}
	return innermost visit (m) {
		case assign(n, sels, not(exp)) =>
			ifThen(exp, [assign(n, sels, \false())], [], [assign(n, sels, \true())])
			
		case assign(n, sels, amp(lhs, rhs)) =>
			ifThen(lhs, 
				[ifThen(rhs, 
					[assign(n, sels, \true())], [], 
					[assign(n, sels, \false())]
				)], [],
				[assign(n, sels, \false())])
				
		case assign(n, sels, or(lhs, rhs)) =>
			ifThen(lhs, 
				[assign(n, sels, \true())], [], 
				[ifThen(rhs, 
					[assign(n, sels, \true())], [], 
					[assign(n, sels, \false())])])
					
		case s:assign(n, sels, eq(lhs,rhs)) => assignCompareToIf(s)
		case s:assign(n, sels, neq(lhs,rhs)) => assignCompareToIf(s)
		case s:assign(n, sels, lt(lhs,rhs)) => assignCompareToIf(s)
		case s:assign(n, sels, gt(lhs,rhs)) => assignCompareToIf(s)
		case s:assign(n, sels, geq(lhs,rhs)) => assignCompareToIf(s)		
		case s:assign(n, sels, leq(lhs,rhs)) => assignCompareToIf(s)
			
		case ifThen(not(c), b, [], es) =>
			ifThen(c, es, [], b)

		case ifThen(amp(lhs, rhs), b, [], es) =>
			ifThen(lhs, [ifThen(rhs, b, [], es)], [], es)

		case ifThen(or(lhs, rhs), b, [], es) =>
			ifThen(lhs, b, [], [ifThen(rhs, b, [], es)])

		case ifThen(\true(), b, [], es) => begin(b)
		case ifThen(\false(), b, [], es) => begin(es)

		case s:whileDo(cond, _) : {
			if(lookup(_,_) := cond) fail;
			insert while2let(s);
		}
		
		case whileDo(\false(),_) => begin([])
		// Normalize elsifs					
		case ifThen(c, b, [<ec, eb>, eis*], es) =>
				ifThen(c, b, [], [ifThen(ec, eb, [eis], es)]) 
	}	
}


public Ident uniqueName(Statement s) {
	vars = { n.name | /lookup(n, _) <- s } + { n.name | /assign(n, _, _) <- s };
	return id("_<intercalate("_", toList(vars))>");
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
		case lookup(n, sels) => lookup(subs[n], sels) when subs[n]?
		case assign(n, sels, exp) => assign(subs[n], sels, exp) when subs[n]?
	}
}
