module lang::oberon0::l1::ide::Check

import lang::oberon0::l1::ast::Oberon0;
import lang::oberon0::l1::check::Oberon0;
import lang::oberon0::l1::resolve::Resolver;
import lang::oberon0::l1::syntax::Modules;

import ParseTree;
import List;
import Message;

public lang::oberon0::l1::syntax::Modules::Module checkModule(lang::oberon0::l1::syntax::Modules::Module x) {
	lang::oberon0::l1::ast::Oberon0::Module m = implode(#lang::oberon0::l1::ast::Oberon0::Module, x);
	<m, st> = resolve(m);
	errors = { error(l, s) | <l, s> <- st.scopeErrors };
	if (errors == {}) {
		<m, errors> = check(m, st.symbolTable);
	}
	return x[@messages = errors];
}
 
