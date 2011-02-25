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
public tuple[SymbolTableBuilder st, bool cres, OType ot] otype(SymbolTableBuilder stBuilder, Type t) {
	// Special check for INTEGER
	if (user(name) := t, "INTEGER" := name.name) return < stBuilder, true, Integer() >;
	
	// Check for user type: make sure it is a defined type name. If not, return the
	// Invalid() type instead.
	if (user(name) := t) {
		if (size(getTypes(stBuilder, name)) > 0) {
			return < stBuilder, true, User(name) >;
		} else {
			return < stBuilder, false, Invalid() >;
		}
	}
	
	// Check for array: make sure we can evaluate the sizing constant, plus make sure to
	// check the type to ensure it is valid.
	if (array(e,ty) := t) {
		< stBuilder, evalResult, evalValue > = evaluateConstantExpNoFlags(stBuilder, e);
		< stBuilder, typeResult, typeValue > = otype(stBuilder, ty);
		if (evalResult && typeResult && evalValue > 0)
			return < stBuilder, true, Array(typeValue, evalValue) >;
		else
			return < stBuilder, false, Invalid() >;
	}
	
	// Record: check the fields to make sure they have valid types.
	// TODO: Verify that field names are not duplicated
	if (record(fs) := t) {
		list[tuple[OType fieldType, Ident fieldName]] fldTypes = [ ];
		bool badFieldFound = false;
		for (field(ids,ty) <- fs) {
			< stBuilder, typeResult, typeValue > = otype(stBuilder, ty);
			if (!typeResult) badFieldFound = true;
			for (fid <- ids) fldTypes += < typeValue, fid >;
		}
		if (badFieldFound)
			return < stBuilder, false, Invalid() >;
		else
			return < stBuilder, true, Record(fldTypes) >;
	} 
}