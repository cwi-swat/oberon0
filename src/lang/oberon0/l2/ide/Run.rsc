module lang::oberon0::l2::ide::Run

import lang::oberon0::l1::eval::Oberon0;
import lang::oberon0::l1::syntax::Modules;

import lang::oberon0::l2::desugar::Desugar;
import lang::oberon0::l2::utils::Implode;

import IO;

public void runModule(Module x, loc selection) {
	println(eval(desugar(implode(x))));
}
 



