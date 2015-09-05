module lang::oberon0::l1::resolve::TypeEvaluator

import List;
import Set;

import lang::oberon0::l1::ast::Oberon0;
import lang::oberon0::l1::resolve::SymbolTable;
import lang::oberon0::l1::resolve::Types;
import lang::oberon0::l1::resolve::ConstantEvaluator;

//
// Generate an OType for a given AST Type. Much like the constant evaluator, we build the result
// and we add any errors we find into the symbol table builder.
//
public tuple[SymbolTableBuilder st, bool cres, OType ot] otype(SymbolTableBuilder stBuilder, user(id("INTEGER"))) = <stBuilder, true, Integer()>;

public tuple[SymbolTableBuilder st, bool cres, OType ot] otype(SymbolTableBuilder stBuilder, user(id("BOOLEAN"))) = <stBuilder, true, Boolean()>;

// NB: default, otherwise it could match INTEGER.
default tuple[SymbolTableBuilder st, bool cres, OType ot] otype(SymbolTableBuilder stBuilder, user(name)) {
	set[Item] types = getTypes(stBuilder, name);
	if (size(types) == 1) {
		stBuilder.itemUses = stBuilder.itemUses + < getOneFrom(types), name@location >;
		return < stBuilder, true, User(name) >;
	} 
	if (size(types) > 1) {
		stBuilder = addScopeError(stBuilder, name@location, "Type <name.name> has multiple in-scope definitions.");
		return < stBuilder, false, Invalid() >;
	} 
	stBuilder = addScopeError(stBuilder, name@location, "Type <name.name> not defined before use");
	return < stBuilder, false, Invalid() >;
}

