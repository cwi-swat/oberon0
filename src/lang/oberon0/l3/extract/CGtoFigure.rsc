module lang::oberon0::l3::extract::CGtoFigure

import lang::oberon0::l3::extract::CallGraph;
import lang::oberon0::l3::ast::Oberon0;
import lang::oberon0::l3::resolve::SymbolTable;
import vis::Figure;
import lang::box::util::Box2Text;
import Relation;

public Figure default proc2figure(Item i) = 
	box(text(i.name.name,center()), vis::Figure::id(i.name.name), fillColor("white"), size(0), gap(4));

public Figure cg2figure(CallGraph cg) {
	_nodes = [ proc2figure(n) | n <- carrier(cg) ];
    _edges = [ edge(n1.name.name, n2.name.name, shape([vertex(0,0), vertex(4,8), vertex(8, 0)], shapeClosed(true), fillColor("black"))) | <n1, n2> <- cg ];

    return graph(_nodes, _edges, hint("layered"), size(800));
}

