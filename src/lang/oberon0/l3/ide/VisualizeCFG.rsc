module lang::oberon0::l3::ide::VisualizeCFG

import lang::oberon0::l3::utils::Implode;
import lang::oberon0::l1::\syntax::Modules;
import lang::oberon0::l3::\syntax::Declarations;
import lang::oberon0::l3::extract::ControlFlow;
import lang::oberon0::l3::extract::CFGtoFigure;

import vis::Render;
import ParseTree;


public void visualizeCFG(Module x, loc l) {
	if (treeFound(t) := treeAt(#ProcedureDecl, l, x)) {
		render(cfg2figure(getControlFlow(implode(t))));
	} else {
		render(cfg2figure(getControlFlow(implode(x))));
	}	
}
