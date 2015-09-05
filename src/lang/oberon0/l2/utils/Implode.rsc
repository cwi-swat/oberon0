module lang::oberon0::l2::utils::Implode

import lang::oberon0::l2::ast::Oberon0;
import lang::oberon0::l1::\syntax::Modules;

import ParseTree;

public  lang::oberon0::l2::ast::Oberon0::Module implode(lang::oberon0::l1::\syntax::Modules::Module x) {
	return implode(#lang::oberon0::l2::ast::Oberon0::Module, x);
}
