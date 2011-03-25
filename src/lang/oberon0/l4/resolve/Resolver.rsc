module lang::oberon0::l4::resolve::Resolver


import lang::oberon0::l4::ast::Oberon0;
import lang::oberon0::l3::resolve::SymbolTable;
import lang::oberon0::l1::resolve::NameAnnotator;
import lang::oberon0::l4::resolve::ResolveNames;

public tuple[Module ast, SymbolTableBuilder stBuilder] resolve(Module m) {
	SymbolTableBuilder stBuilder = resolveL3Names(m);
	return <annotateModule(m, stBuilder), stBuilder>;
}

