module lang::oberon0::l2::extract::ControlFlow

extend lang::oberon0::l1::extract::ControlFlow;
import lang::oberon0::l2::ast::Oberon0;

import Relation;
import String;
import Graph;
import List;
import IO;

public CFlow statementCFlow(fl:forDo(n, f, t, body), CFlow cfl) {
	cfl.nodes[n@location] = choice(n@location, lookup(n));

	cfl.entry += {<fl@location, n@location>};
	cfl.exit += {<fl@location, n@location>};
	
	if (body != []) {
		cfl.succ += {<n@location, head(body)@location>};
		cfl.succ += {<last(body)@location, n@location>};
		cfl = statementListCFlow(body, cfl);
	}	
	return cfl;
}


public CFlow statementCFlow(r:repeatUntil(body, cond), CFlow cfl) {
	// TODO: check this, it is like while now...
	cfl.nodes[cond@location] = choice(cond@location, cond);

	cfl.entry += {<r@location, cond@location>};
	cfl.exit += {<r@location, cond@location>};
	
	if (body != []) {
		cfl.succ += {<cond@location, head(body)@location>};
		cfl.succ += {<last(body)@location, cond@location>};
		cfl = statementListCFlow(body, cfl);
	}	
	return cfl;
}

