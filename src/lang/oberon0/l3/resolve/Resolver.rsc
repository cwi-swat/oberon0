module lang::oberon0::l3::resolve::Resolver

import lang::oberon0::l3::ast::Oberon0;
import lang::oberon0::l3::resolve::SymbolTable;
import lang::oberon0::l3::resolve::ResolveNames;
import lang::oberon0::l1::resolve::NameAnnotator;

public tuple[Module ast, SymbolTableBuilder stBuilder] resolve(Module m) {
	SymbolTableBuilder stBuilder = resolveL3Names(m);
	return <annotateModule(m, stBuilder), stBuilder>;
}

