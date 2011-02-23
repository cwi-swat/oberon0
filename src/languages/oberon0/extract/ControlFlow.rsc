module languages::oberon0::extract::ControlFlow

import languages::oberon0::ast::Oberon0;

import Relation;
import Graph;
import List;
import IO;

import box::Box;
import box::Box2Text;
import languages::oberon0::format::Oberon0;

import vis::Figure;
import vis::Render;

data CFNode
	= start(loc location, Module mod)
	| start(loc location, Procedure prod)
	| end()
	| choice(loc location, Expression exp)
	| statement(loc location, Statement stat);

data ControlFlowGraph = cfg(Graph[CFNode], CFNode start);

public ControlFlowGraph getControlFlow(Module m) {

}

private Graph[loc] IN = {}, OUT = {}, SUC = {};
private map[loc, CFNode] nodes = ();

public ControlFlowGraph getControlFlow(Procedure p) {

	fprint(proc2box(p));
	
	startNode = start(p@location, p);
	endNode = end();
	
	if (p.body == []) {
		return cfg({}, startNode);
	}
	
	// fill IN, OUT and SUC
	startLoc = |file://dummyLocation1|;
	endLoc = |file://dummyLocation2|;
	nodes = (startLoc : startNode, endLoc : endNode);
	
	IN = {<endLoc, endLoc>};
	OUT = {<startLoc, startLoc>};
	SUC = {};

	for (/Statement s <- p.body) {
		nodes[s@location] = statement(s@location, s);
		print(s);
		visitStatement(s);
	}
	
	SUCC += {<p@location, head(p.body)@location>};
	SUCC += {<p@location, last(p.body)@location>};
	visitStatementList(p.body);
	
	printGraph(IN, "IN");
	printGraph(IN, "OUT");
	printGraph(IN, "SUC");
	
	// merge IN OUT SUC into one relation
	Graph[loc] locCfg = { <l1, l4> | <l2, l3> <- SUC, l1 <- reachBottom(OUT, l2), l4 <- reachBottom(IN, l3) };

	// TODO remove empty statement lists
	
	// create CFNodes for locs	
	nodeCfg = { <nodes[l1], nodes[l2]> | <l1, l2> <- locCfg };

	/*print("nodeCfg");
	for (<n1, n2> <- nodeCfg) {
		print(formatNode(n1));
		print("---\>");
		print(formatNode(n2));
	}*/
	
	visGraph(nodeCfg);
	
	return cfg(nodeCfg, startNode);
}
	
private void visitStatement(i : ifThen(cond, body, elseIfs, elsePart)) {
	nodes[cond@location] = choice(cond@location, cond);

	IN += {<i@location, cond@location>};

	ifs = [<cond, body>] + elseIfs;

	for (<c, b> <- ifs) {
		if (b != []) {
			OUT += {<i@location, last(b)@location>};
			SUC += {<c@location, head(b)@location>};
			visitStatementList(b);
		}
	}
	
	for ([_*, <c1, b1>, <c2, b2>, _*] := ifs) {
		SUC += {<c1@location, c2@location>};
	}
	
	if (elsePart != []) {
		OUT += {<i@location, last(elsePart)@location>};
		if (<c,b> := last(ifs)) {
			SUC += {<c@location, head(elsePart)@location>};
		}
		visitStatementList(elsePart);
	} else {
		if (<c,b> := last(ifs)) {
			OUT += {<i@location, c@location>};
		}
	}
}

private void visitStatement(w : whileDo(cond, body)) {
	nodes[cond@location] = choice(cond@location, cond);

	IN += {<w@location, cond@location>};
	OUT += {<w@location, cond@location>};
	
	if (body != []) {
		SUC += {<cond@location, head(body)@location>};
		SUC += {<last(body)@location, cond@location>};
		visitStatementList(body);
	}	
}

private void visitStatementList(list[Statement] body) {
	for ([_*, s1, s2, _*] := body) {
		SUC += {<s1@location, s2@location>};
	}
}

private void visitStatement(a : assign(_,_,_)) {
	// do nothing
}

private void visitStatement(c : call(_,_)) {
	// do nothing
}

private void default visitStatement(Statement s) {
	print("unmatched: <s>");
}

// returns all leaf nodes in r that are reachable from n
private set[&T] reachBottom(Graph[&T] r, &T n) {
	return reach(r, {n}) & bottom(r);
}


// debugging functions ----------------------------------------------

private void printGraph(Graph[loc] g, str header) {
	print(header);
	
	for (<l1, l2> <- g) {
		print(formatNode(nodes[l1]));
		print("---\>");
		print(formatNode(nodes[l2]));
	}
}

private str formatNode(CFNode n) {
	if (choice(_, Expression e) := n) {
		return format(exp2box(e));
	} else if (statement(_, Statement s) := n) {
		return format(stat2box(s));
	} else if (start(_,_) := n) {
		return "start";
	}
}

private void visGraph(Graph[CFNode] g) {

	_nodes = [ box(text(formatNode(n)), vis::Figure::id("<n.location>"), fillColor("green"), size(0))
     			| n <- carrier(g) ];
    _edges = [ edge("<n1.location>", "<n2.location>") | <n1, n2> <- g ];
    	    
    render(graph(_nodes, _edges, hint("layered"), size(800)));
}

