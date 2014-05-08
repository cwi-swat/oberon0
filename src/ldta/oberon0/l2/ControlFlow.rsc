module ldta::oberon0::l2::ControlFlow

extend ldta::oberon0::l1::ControlFlow;
import ldta::oberon0::l2::AST;

public data CFNode = expression(loc location, Expression expr); // needed for case

public CFlow statementCFlow(fd:forDo(n, f, t, body), CFlow cfl) {
	cfl.nodes[n@location] = choice(n@location, lookup(n));

	cfl.entry += {<fd@location, n@location>};
	cfl.exit += {<fd@location, n@location>};
	
	if (body != []) {
		cfl.succ += {<n@location, head(body)@location>};
		cfl.succ += {<last(body)@location, n@location>};
		cfl = statementListCFlow(body, cfl);
	} else {
		cfl.succ += {<n@location, n@location>};
	}
	return cfl;
}


//public CFlow statementCFlow(r:repeatUntil(body, cond), CFlow cfl) {
//	cfl.nodes[cond@location] = choice(cond@location, cond);
//
//	if (body != []) {
//		cfl.entry += {<r@location, head(body)@location>};
//		cfl.succ += {<last(body)@location, cond@location>};
//		cfl.succ += {<cond@location, head(body)@location>};
//		cfl = statementListCFlow(body, cfl);
//	} else {
//		cfl.entry += {<r@location, cond@location>};
//		cfl.succ += {<cond@location, cond@location>};		
//	}
//	
//	cfl.exit += {<r@location, cond@location>};
//	return cfl;
//}

public CFlow statementCFlow(c:caseOf(exp, cases, elsePart), CFlow cfl) { // very similar to ifThen, refactor?
	cfl.nodes[exp@location] = expression(exp@location, exp);
	cfl.entry += {<c@location, exp@location>};

	// interconnect exp, cases and else part
	// set exit of c
	if (cases == []) {
		if (elsePart == []) {
			cfl.exit += {<c@location, exp@location>};
			return cfl;
		} else {
			cfl.succ += {<exp@location, head(elsePart)@location>};
			cfl.exit += {<c@location, last(elsePart)@location>};
		}
	} else {
		cfl.succ += {<exp@location, head(cases).labels[0].exp@location>};
		if (elsePart == []) {
			cfl.exit += {<c@location, last(cases).labels[0].exp@location>};
		} else {
			cfl.succ += {<last(cases).labels[0].exp@location, head(elsePart)@location>};
			cfl.exit += {<c@location, last(elsePart)@location>};
		}
	}

	// connect case expressions and bodies
	for (guard(/expression(e), body) <- cases) {
		cfl.nodes[e@location] = choice(e@location, e);
		if (body != []) {
			cfl.succ += {<e@location, head(body)@location>};
			cfl.exit += {<c@location, last(body)@location>};
			cfl = statementListCFlow(body, cfl);
		}
	}
	
	// connect case expressions
	for ([_*, guard(/expression(e1), _), guard(/expression(e2), _), _*] := cases) {
		cfl.succ += {<e1@location, e2@location>};
	}

	// connect else body
	if (elsePart != []) {
		cfl = statementListCFlow(elsePart, cfl);
	}
	
	return cfl;
}