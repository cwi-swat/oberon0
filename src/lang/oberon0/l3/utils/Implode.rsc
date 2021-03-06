module lang::oberon0::l3::utils::Implode

import lang::oberon0::l1::\syntax::Modules;
import lang::oberon0::l3::\syntax::Declarations;
import lang::oberon0::l3::ast::Oberon0;

import ParseTree;

public lang::oberon0::l3::ast::Oberon0::Module implode(lang::oberon0::l1::\syntax::Modules::Module pt) {
	return implode(#lang::oberon0::l3::ast::Oberon0::Module, pt);
}

public lang::oberon0::l3::ast::Oberon0::Procedure implode(lang::oberon0::l3::\syntax::Declarations::ProcedureDecl pt) {
	return implode(#lang::oberon0::l3::ast::Oberon0::Procedure, pt);
}
