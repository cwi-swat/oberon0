module lang::oberon0::l4::ide::Check

import lang::oberon0::l4::utils::Implode;
import lang::oberon0::l1::syntax::Modules;

import lang::oberon0::l4::check::Oberon0;
import lang::oberon0::l4::resolve::Resolver;


import List;
import Message;
import ParseTree;

public Module checkModule(Module x) {
	m = implode(x);
	<m, st> = resolve(m);
	errors = { error(l, s) | <l, s> <- st.scopeErrors };
	if (errors == {}) {
		errors = check(m, st.symbolTable);
	}
	return x[@messages = errors];
}
 
