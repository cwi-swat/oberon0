module lang::oberon0::check::Checker

import IO;
import List;
import Set;
import ParseTree;
import Relation;

import lang::oberon0::syntax::Oberon0;
import lang::oberon0::utils::Parse;
import lang::oberon0::ast::Oberon0;
import lang::oberon0::check::Types;
import lang::oberon0::resolve::SymbolTable;
import lang::oberon0::resolve::Resolver;
import lang::oberon0::check::CheckTypes;

public tuple[lang::oberon0::ast::Oberon0::Module ast, SymbolTableBuilder stBuilder] checkAux(loc l) {
	println("RESOLVING NAMES");
	< astModule, stBuilder > = resolveAux(l);
	println("CHECKING TYPES");
	astModule = checkTypes(astModule, stBuilder.symbolTable);
	return < astModule, stBuilder >;
}

public tuple[lang::oberon0::ast::Oberon0::Module ast, SymbolTable st] check(loc l) {
	< astModule, stBuilder > = checkAux(l);
	return < astModule, stBuilder.symbolTable >;
}

public tuple[lang::oberon0::ast::Oberon0::Module ast, SymbolTable st] checkSample() {
	return check(|project://Oberon0/src/sample.oberon0|);
}