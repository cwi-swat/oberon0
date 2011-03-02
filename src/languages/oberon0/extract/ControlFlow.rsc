module languages::oberon0::extract::ControlFlow

import languages::oberon0::ast::Oberon0;

import Relation;
import String;
import Graph;
import List;
import IO;

import lang::box::util::Box;
import lang::box::util::Box2Text;
import languages::oberon0::format::Oberon0;

import vis::Figure;
import vis::Render;

public data CFNode
	= start(loc location, Module mod)
	| start(loc location, Procedure prod)
	| end()
	| choice(loc location, Expression exp)
	| statement(loc location, Statement stat);

public data ControlFlowGraph = cfg(Graph[CFNode] graph, CFNode start);

public ControlFlowGraph getControlFlow(Module m) {
	return getControlFlow(m.body, start(m@location, m));
}

public ControlFlowGraph getControlFlow(Procedure p) {
	return getControlFlow(p.body, start(p@location, p));	
}

private Graph[loc] IN = {}, OUT = {}, SUC = {};
private map[loc, CFNode] nodes = ();

private ControlFlowGraph getControlFlow(list[Statement] body, CFNode startNode) {
	if (body == []) {
		return cfg({}, startNode);
	}
	
	// fill IN, OUT and SUC
	IN = OUT = SUC = {};
	nodes = ();
	
	for (/Statement s <- body) {
		nodes[s@location] = statement(s@location, s);
		visitStatement(s);
	}
	
	visitStatementList(body);
	
	// merge IN OUT SUC into one relation
	Graph[loc] locCfg = { <l1, l4> | <l2, l3> <- SUC, l1 <- reachBottom(OUT, l2), l4 <- reachBottom(IN, l3) }; 
	
	// create start and end edges 
	endNode = end();
	entries = reachBottom(IN, head(body)@location);
	exits = reachBottom(OUT, last(body)@location);
	startAndEnd = ({startNode} * {nodes[l] | l <- entries}) + ({nodes[l] | l <- exits} * {endNode});
	
	// convert locations to CFNodes
	nodeCfg = { <nodes[l1], nodes[l2]> | <l1, l2> <- locCfg } + startAndEnd;

	return cfg(nodeCfg, startNode);
}

// add IN, OUT, and SUC entries for each Statement type
private void visitStatement(i : ifThen(cond, body, elseIfs, elsePart)) {
	IN += {<i@location, cond@location>};

	ifs = [<cond, body>] + elseIfs;

	for (<c, b> <- ifs) {
		nodes[c@location] = choice(c@location, c);
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

private void visitStatement(a : assign(_,_,_)) {
	// do nothing
}

private void visitStatement(c : call(_,_)) {
	// do nothing
}

private void default visitStatement(Statement s) {
	throw "visitStatement did not match : <s>";
}

// add SUC entries for statement list
private void visitStatementList(list[Statement] body) {
	for ([_*, s1, s2, _*] := body) {
		SUC += {<s1@location, s2@location>};
	}
}

// returns all leaf nodes in r that are reachable from n, or {n} if none exist
private set[&T] reachBottom(Graph[&T] r, &T n) {
	rb = reach(r, {n}) & bottom(r);
	return (rb != {}) ? rb : {n};
}


// visualization functions ------------------------------------

private str formatNode(CFNode n) {
	switch(n) {
		case choice(_, Expression e) : return replaceLast(format(exp2box(e)), "\n", "");
		case statement(_, Statement s) : return replaceLast(format(stat2box(s)), "\n", "");
		case start(_, Module m) : return "start <m.name.name>";
		case start(_, Procedure p) : return "start <p.name.name>";
		case end() : return "end";
	}
}

private Figure getFigure(CFNode n) {
	switch(n) {
		case choice(_,_) : return ellipse(text(formatNode(n)), vis::Figure::id(getId(n)), fillColor("yellow"), size(0), gap(8));
		case start(_,_) : return box(text(formatNode(n)), vis::Figure::id(getId(n)), fillColor("orange"), size(0), gap(4));
		case end() : return box(text(formatNode(n)), vis::Figure::id(getId(n)), fillColor("grey"), size(0), gap(4));
		default: return box(text(formatNode(n)), vis::Figure::id(getId(n)), fillColor("white"), size(0), gap(4));
	}
}

private str getId(CFNode n) {
	if (end() := n) {
		return "end";
	} else {
		return "<n.location>";
	}
}

public void visControlFlow(ControlFlowGraph cfg) {

	_nodes = [ getFigure(n) | n <- carrier(cfg.graph) + cfg.start ];
    _edges = [ edge(getId(n1), getId(n2), shape([vertex(0,0), vertex(4,8), vertex(8, 0)], shapeClosed(true), fillColor("black"))) | <n1, n2> <- cfg.graph ];

    render(graph(_nodes, _edges, hint("layered"), size(800)));
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
