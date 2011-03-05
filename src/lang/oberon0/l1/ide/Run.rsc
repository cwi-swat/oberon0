module lang::oberon0::l1::ide::Run

import lang::oberon0::l1::ast::Oberon0;
import lang::oberon0::l1::eval::Oberon0;
import lang::oberon0::l1::syntax::Modules;
import lang::oberon0::l1::format::Oberon0;
import lang::oberon0::l1::utils::Parse;
import lang::box::util::Box2Text;

import ParseTree;
import IO;


public lang::oberon0::l1::syntax::Modules::Module runModule(
	lang::oberon0::l1::syntax::Modules::Module x, loc selection) {
	lang::oberon0::l1::ast::Oberon0::Module m = 
		implode(#lang::oberon0::l1::ast::Oberon0::Module, x);
	println(eval(m));
	return x;
}
 


public lang::oberon0::l1::syntax::Modules::Module formatModule(
		lang::oberon0::l1::syntax::Modules::Module x, loc selection) {
	lang::oberon0::l1::ast::Oberon0::Module m = 
		implode(#lang::oberon0::l1::ast::Oberon0::Module, x);
	b = mod2box(m);
	s = format(b);
	println("*****<trim(s)>******");
	return parse(trim(s), x@\loc);
}


public str trim(str s) {
	if (/^\s*<rest:\S.*>$/ := s) {
		s = rest;
	}
	if (/^<rest:.*?>\s*$/ := s) {
		s = rest;
	}
	return s;
}