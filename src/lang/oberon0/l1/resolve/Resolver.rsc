module lang::oberon0::l1::resolve::Resolver

import lang::oberon0::l1::ast::Oberon0;
import lang::oberon0::l1::resolve::SymbolTable;
import lang::oberon0::l1::resolve::ResolveNames;
import lang::oberon0::l1::resolve::NameAnnotator;

public tuple[Module ast, SymbolTableBuilder stBuilder] resolve(Module m) {
	SymbolTableBuilder stBuilder = resolveNames(m);
	return <annotateModule(m, stBuilder), stBuilder>;
}

