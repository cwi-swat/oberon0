module lang::oberon0::l2::check::Oberon0

import lang::oberon0::l2::ast::Oberon0;
import lang::oberon0::l1::resolve::SymbolTable;
import lang::oberon0::l2::check::CheckTypes;

import Message;

public list[Message] check(Module astModule, SymbolTable tbl) {
	<astModule, errors> = checkTypes(astModule, tbl);
	return errors;
}

