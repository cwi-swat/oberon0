module languages::oberon0::resolve::TypeEvaluator

import List;
import Set;

import languages::oberon0::ast::Oberon0;
import languages::oberon0::resolve::SymbolTable;
import languages::oberon0::check::Types;
import languages::oberon0::resolve::ConstantEvaluator;

//
// Generate an OType for a given AST Type. Note that we do NOT alter the symbol
// table here, but assume this has been done in the resolveTypeNames function in
// module ResolveNames.
//
public tuple[SymbolTable st, bool cres, OType ot] otype(SymbolTable symbolTable, Type t) {
	// Special check for INTEGER
	if (user(name) := t, /^integer$/i := name.name) return < symbolTable, true, Integer() >;
	
	// Check for user type: make sure it is a defined type name. If not, return the
	// Invalid() type instead.
	if (user(name) := t) {
		if (size(getItemsForTypeName(symbolTable, symbolTable.currentScope, name)) > 0) {
			return < symbolTable, true, User(name) >;
		} else {
			return < symbolTable, false, Invalid() >;
		}
	}
	
	// Check for array: make sure we can evaluate the sizing constant, plus make sure the
	// check the type to make sure it is valid.
	if (array(e,ty) := t) {
		< symbolTable, evalResult, evalValue > = evaluateConstantExpNoFlags(symbolTable, e);
		< symbolTable, typeResult, typeValue > = otype(symbolTable, ty);
		if (evalResult && typeResult && evalValue > 0)
			return < symbolTable, true, Array(typeValue, evalValue) >;
		else
			return < symbolTable, false, Invalid() >;
	}
	
	// Record: check the fields to make sure they have valid types.
	if (record(fs) := t) {
		list[tuple[OType fieldType, Ident fieldName]] fldTypes = [ ];
		bool badFieldFound = false;
		for (field(ids,ty) <- fs) {
			< symbolTable, typeResult, typeValue > = otype(symbolTable, ty);
			if (!typeResult) badFieldFound = true;
			for (fid <- ids) fldTypes += < typeValue, fid >;
		}
		if (badFieldFound)
			return < symbolTable, false, Invalid() >;
		else
			return < symbolTable, true, Record(fldTypes) >;
	} 
}