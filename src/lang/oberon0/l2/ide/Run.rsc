module lang::oberon0::l2::ide::Run

import lang::oberon0::l1::eval::Oberon0;
import lang::oberon0::l1::syntax::Modules;

import lang::oberon0::l2::ast::Oberon0;
import lang::oberon0::l2::desugar::Desugar;

import ParseTree;
import IO;


public lang::oberon0::l1::syntax::Modules::Module runModule(
	lang::oberon0::l1::syntax::Modules::Module x, loc selection) {
	lang::oberon0::l1::ast::Oberon0::Module m = 
		implode(#lang::oberon0::l1::ast::Oberon0::Module, x);
	println(eval(desugar(m)));
	return x;
}
 


