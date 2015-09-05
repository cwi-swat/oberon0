module lang::oberon0::l3::extract::CallGraph

import lang::oberon0::l3::ast::Oberon0;
import lang::oberon0::l3::resolve::SymbolTable;
import lang::oberon0::l1::resolve::NameAnnotator;
import analysis::graphs::Graph;

alias CallGraph = Graph[Item];

public CallGraph generateCallGraph(Module m) {
	return { < p.name@item, v@item > | /Procedure p <- m, /call(Ident v,_) <- p.body} +
		   { < m.name@item, v@item > | /call(Ident v,_) <- m.body };
}
