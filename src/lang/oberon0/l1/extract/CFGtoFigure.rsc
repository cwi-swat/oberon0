module lang::oberon0::l1::extract::CFGtoFigure

import lang::oberon0::l1::extract::ControlFlow;
import lang::oberon0::l1::format::Oberon0;
import lang::oberon0::l1::ast::Oberon0;
import vis::Figure;
import vis::Render;

import Relation;
import String;
import lang::box::util::Box2Text;

public str formatNode(CFNode::choice(_, Expression e)) = replaceLast(format(exp2box(e)), "\n", "");
public str formatNode(statement(_, Statement s)) = replaceLast(format(stat2box(s)), "\n", "");
public str formatNode(\start(_, Module m)) = "start <m.name.name>";
public str formatNode(end()) = "end";


/*private str formatNode(CFNode n) {
	switch(n) {
		case choice(_, Expression e) : return replaceLast(format(exp2box(e)), "\n", "");
		case statement(_, Statement s) : return replaceLast(format(stat2box(s)), "\n", "");
		case start(_, Module m) : return "start <m.name.name>";
		case start(_, Procedure p) : return "start <p.name.name>";
		case end() : return "end";
		default: return "<n>";
	}
}*/

//public Figure node2figure(n:choice(_,_)) = ellipse(text(formatNode(n)), vis::Figure::id(getId(n)), fillColor("yellow"), size(0), gap(8));
//public Figure node2figure(n:start(_,_)) = box(text(formatNode(n)), vis::Figure::id(getId(n)), fillColor("orange"), size(0), gap(4));
//public Figure node2figure(n:end()) = box(text(formatNode(n)), vis::Figure::id(getId(n)), fillColor("grey"), size(0), gap(4));

private Figure node2figure(CFNode n) {
    cl = onClick(void(){;});
    
    if (n has location) 
      cl = onClick(void () { println("Hoi!"); edit(n.location,[]);});
      
	switch(n) {
		case choice(_,_) : return ellipse(text(formatNode(n),cl), vis::Figure::id(getId(n)), fillColor("yellow"), size(0), gap(8), cl);
		case \start(_,_) : return box(text(formatNode(n),cl), vis::Figure::id(getId(n)), fillColor("orange"), size(0), gap(4), cl);
		case end() : return box(text(formatNode(n)), vis::Figure::id(getId(n)), fillColor("grey"), size(0), gap(4));
		default: return box(text(formatNode(n),cl), vis::Figure::id(getId(n)), fillColor("white"), size(0), gap(4), cl);
	}
}

default Figure node2figure(CFNode n) = 
	box(text(formatNode(n)), vis::Figure::id(getId(n)), fillColor("white"), gap(4));

private str getId(end()) = "end";
default str getId(CFNode n) = "<n.location>";

public Figure cfg2figure(ControlFlowGraph cfg) {
	_nodes = [ node2figure(n) | n <- carrier(cfg.graph) + cfg.\start ];
//    _edges = [ edge(getId(n1), getId(n2), shape([vertex(0,0), vertex(4,8), vertex(8, 0)], shapeClosed(true), fillColor("black"))) | <n1, n2> <- cfg.graph ];
    _edges = [ edge(getId(n1), getId(n2), shapeClosed(true), fillColor("black"), toArrow(shape([vertex(0,0), vertex(4,8), vertex(8, 0)]))) | <n1, n2> <- cfg.graph ];

    return graph(_nodes, _edges, /*hint("layered"),*/ size(800));
}

