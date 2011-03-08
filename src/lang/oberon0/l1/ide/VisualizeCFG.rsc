module lang::oberon0::l1::ide::VisualizeCFG

import lang::oberon0::l1::syntax::Modules;
import lang::oberon0::l1::extract::ControlFlow;
import lang::oberon0::l1::extract::CFGtoFigure;
import lang::oberon0::l1::utils::Implode;

import vis::Render;

public void visualizeCFG(Module x, loc selection) {
	render(cfg2figure(getControlFlow(implode(x))));
}
