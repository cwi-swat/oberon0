module lang::oberon0::l3::check::Oberon0

import lang::oberon0::l3::ast::Oberon0;
import lang::oberon0::l3::resolve::SymbolTable;
import lang::oberon0::l3::check::CheckTypes;

import Message;

public set[Message] check(Module astModule, SymbolTable tbl) {
	<astModule, errors> = checkTypes(astModule, tbl);
	return errors;
}

