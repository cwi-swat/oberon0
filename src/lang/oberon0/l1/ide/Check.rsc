module lang::oberon0::l1::ide::Check

import lang::oberon0::l1::utils::Implode;
import lang::oberon0::l1::check::Oberon0;
import lang::oberon0::l1::resolve::Resolver;
import lang::oberon0::l1::syntax::Modules;

import List;
import Message;

import ParseTree; // for anno messages

public Module checkModule(Module x) {
	m = implode(x);
	<m, st> = resolve(m);
	errors = { error(l, s) | <l, s> <- st.scopeErrors };
	if (errors == {}) {
		errors = check(m, st.symbolTable);
	}
	return x[@messages = errors];
}
 
