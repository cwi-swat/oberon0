module lang::oberon0::l2::ide::Format

import lang::oberon0::l2::ast::Oberon0;
import lang::oberon0::l1::syntax::Modules;
import lang::oberon0::l2::format::Oberon0;
import lang::oberon0::l2::utils::Parse;
import lang::box::util::Box2Text;

import ParseTree;
import String;
import IO;

public lang::oberon0::l1::syntax::Modules::Module formatModule(
		lang::oberon0::l1::syntax::Modules::Module x, loc selection) {
	lang::oberon0::l1::ast::Oberon0::Module m = 
		implode(#lang::oberon0::l1::ast::Oberon0::Module, x);
	b = mod2box(m);
	s = format(b);
	return parse(trim(s), x@\loc);
}

