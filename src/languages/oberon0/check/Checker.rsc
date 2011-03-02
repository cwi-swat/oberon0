module languages::oberon0::check::Checker

import IO;
import List;
import Set;
import ParseTree;
import Relation;

import languages::oberon0::syntax::Oberon0;
import languages::oberon0::utils::Parse;
import languages::oberon0::ast::Oberon0;
import languages::oberon0::check::Types;
import languages::oberon0::resolve::SymbolTable;
import languages::oberon0::resolve::Resolver;
import languages::oberon0::check::CheckTypes;

public tuple[languages::oberon0::ast::Oberon0::Module ast, SymbolTableBuilder stBuilder] checkAux(loc l) {
	println("RESOLVING NAMES");
	< astModule, stBuilder > = resolveAux(l);
	println("CHECKING TYPES");
	astModule = checkTypes(astModule, stBuilder.symbolTable);
	return < astModule, stBuilder >;
}

public tuple[languages::oberon0::ast::Oberon0::Module ast, SymbolTable st] check(loc l) {
	< astModule, stBuilder > = checkAux(l);
	return < astModule, stBuilder.symbolTable >;
}

public tuple[languages::oberon0::ast::Oberon0::Module ast, SymbolTable st] checkSample() {
	return check(|project://Oberon0/src/sample.oberon0|);
}