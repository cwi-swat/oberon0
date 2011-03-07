module lang::oberon0::l1::check::Oberon0

import lang::oberon0::l1::ast::Oberon0;
import lang::oberon0::l1::resolve::Types;
import lang::oberon0::l1::resolve::SymbolTable;
import lang::oberon0::l1::resolve::Resolver;
import lang::oberon0::l1::check::CheckTypes;

import Message;

public list[Message] check(Module astModule, SymbolTable tbl) {
	<astModule, errors> = checkTypes(astModule, tbl);
	return errors;
}

