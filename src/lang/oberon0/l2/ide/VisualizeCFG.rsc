module lang::oberon0::l2::ide::VisualizeCFG

import lang::oberon0::l2::utils::Implode;
import lang::oberon0::l1::syntax::Modules;
import lang::oberon0::l2::extract::ControlFlow;
import lang::oberon0::l2::extract::CFGtoFigure;

import vis::Render;

public void visualizeCFG(Module x, loc l) {
	render(cfg2figure(getControlFlow(implode(x))));
}
