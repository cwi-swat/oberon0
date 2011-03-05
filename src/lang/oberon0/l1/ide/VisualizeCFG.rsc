module lang::oberon0::l1::ide::VisualizeCFG

import lang::oberon0::l1::ast::Oberon0;
import lang::oberon0::l1::syntax::Modules;
import lang::oberon0::l1::extract::ControlFlow;
import lang::oberon0::l1::extract::CFGtoFigure;

import ParseTree;


import vis::Render;

public lang::oberon0::l1::syntax::Modules::Module visualizeCFG(
	lang::oberon0::l1::syntax::Modules::Module x, loc selection) {
	lang::oberon0::l1::ast::Oberon0::Module m = 
		implode(#lang::oberon0::l1::ast::Oberon0::Module, x);
	f = cfg2figure(getControlFlow(m));
	render(f);
	return x;
}
