module lang::oberon0::l1::ide::Run

import lang::oberon0::l1::syntax::Modules;
import lang::oberon0::l1::utils::Implode;
import lang::oberon0::l1::eval::Oberon0;

import IO;

import vis::Render;

public void runModule(Module x, loc selection) {
	m = implode(x); 
	println(eval(m));
}






