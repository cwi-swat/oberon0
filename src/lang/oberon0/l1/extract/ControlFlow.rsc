module lang::oberon0::l1::extract::ControlFlow

import lang::oberon0::l1::ast::Oberon0;

import Relation;
import String;
import analysis::graphs::Graph;
import List;
import IO;

public data CFNode
	= \start(loc location, Module \mod)
	| end()
	| choice(loc location, Expression exp)
	| statement(loc location, Statement stat);

public data ControlFlowGraph = cfg(Graph[CFNode] graph, CFNode \start);

public ControlFlowGraph getControlFlow(Module m) {
	return getControlFlow(m.body, \start(m@location, m));
}

data CFlow = cflow(Graph[loc] entry, Graph[loc] exit, Graph[loc] succ, map[loc, CFNode] nodes);

public ControlFlowGraph getControlFlow(list[Statement] body, CFNode startNode) {
	if (body == []) {
		return cfg({}, startNode);
	}
	
	cfl = extractCFlow(body);
	
	// convert (entry, exit, succ) graph into one succ graph
	Graph[loc] locCfg = { <l1, l4> | <l2, l3> <- cfl.succ, l1 <- reachBottom(cfl.exit, l2), l4 <- reachBottom(cfl.entry, l3) }; 
	
	// create start and end edges 
	endNode = end();
	entries = reachBottom(cfl.entry, head(body)@location);
	exits = reachBottom(cfl.exit, last(body)@location);
	startAndEnd = ({startNode} * {cfl.nodes[l] | l <- entries}) + ({cfl.nodes[l] | l <- exits} * {endNode});
	
	// convert locations to CFNodes
	nodeCfg = { <cfl.nodes[l1], cfl.nodes[l2]> | <l1, l2> <- locCfg } + startAndEnd;

	return cfg(nodeCfg, startNode);
}


public CFlow extractCFlow(list[Statement] body) {
	cfl = cflow({}, {}, {}, ());
	
	for (/Statement s <- body) {
		cfl.nodes[s@location] = statement(s@location, s);
		cfl = statementCFlow(s, cfl);
	}
	
	return statementListCFlow(body, cfl);
}
	

public CFlow statementCFlow(i:ifThen(cond, body, elseIfs, elsePart), CFlow cfl) {
	cfl.entry += {<i@location, cond@location>};

	ifs = [<cond, body>] + elseIfs;
	for (<c, b> <- ifs) {
		cfl.nodes[c@location] = choice(c@location, c);
		if (b != []) {
			cfl.exit += {<i@location, last(b)@location>};
			cfl.succ += {<c@location, head(b)@location>};
			cfl = statementListCFlow(b, cfl);
		}
	}
	
	for ([_*, <c1, _>, <c2, _>, _*] := ifs) {
		cfl.succ += {<c1@location, c2@location>};
	}
	
	if (elsePart != []) {
		cfl.exit += {<i@location, last(elsePart)@location>};
		if (<c, _> := last(ifs)) {
			cfl.succ += {<c@location, head(elsePart)@location>};
		}
		return statementListCFlow(elsePart, cfl);
	} 
	if (<c, _> := last(ifs)) {
		cfl.exit += {<i@location, c@location>};
	}
	return cfl;
}

public CFlow statementCFlow(w:whileDo(cond, body), CFlow cfl) {
	cfl.nodes[cond@location] = choice(cond@location, cond);

	cfl.entry += {<w@location, cond@location>};
	cfl.exit += {<w@location, cond@location>};
	
	if (body != []) {
		cfl.succ += {<cond@location, head(body)@location>};
		cfl.succ += {<last(body)@location, cond@location>};
		cfl = statementListCFlow(body, cfl);
	} else {
		cfl.succ += {<cond@location, cond@location>};
	}
	return cfl;
}


default CFlow statementCFlow(Statement _, CFlow cfl) {
	return cfl;
}

// create succ edges between statements in a list
public CFlow statementListCFlow(list[Statement] body, CFlow cfl) {
	cfl.succ = ( cfl.succ | it + {<s1@location, s2@location>} | [_*, s1, s2, _*] := body );
	return cfl;  
}

// returns all leaf nodes in r that are reachable from n, or {n} if none exist
private set[&T] reachBottom(Graph[&T] r, &T n) {
	rb = reach(r, {n}) & bottom(r);
	return (rb != {}) ? rb : {n};
}


