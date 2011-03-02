module languages::oberon0::resolve::TypeEvaluator

import List;
import Set;

import languages::oberon0::ast::Oberon0;
import languages::oberon0::resolve::SymbolTable;
import languages::oberon0::check::Types;
import languages::oberon0::resolve::ConstantEvaluator;

//
// Generate an OType for a given AST Type. Must like the constant evaluator, we build the result
// and we add any errors we find into the symbol table builder.
//
public tuple[SymbolTableBuilder st, bool cres, OType ot] otype(SymbolTableBuilder stBuilder, Type t) {
	// Special check for INTEGER.
	if (user(name) := t, "INTEGER" := name.name) return < stBuilder, true, Integer() >;
	
	// For other user types, make sure the named type is in scope with a unique definition.
	if (user(name) := t) {
		set[Item] types = getTypes(stBuilder, name);
		if (size(types) == 1) {
			stBuilder.itemUses = stBuilder.itemUses + < getOneFrom(types), name@location >;
			return < stBuilder, true, User(name) >;
		} else if (size(types) > 1) {
			stBuilder = addScopeError(stBuilder, name@location, "Type <name.name> has multiple in-scope definitions.");
			return < stBuilder, false, Invalid() >;
		} else {
			stBuilder = addScopeError(stBuilder, name@location, "Type <name.name> not defined before use");
			return < stBuilder, false, Invalid() >;
		}
	}

	// For array types, ensure that the type itself is valid, plus make sure the constant
	// expression really is constant and is > 0.	
	if (array(e,ty) := t) {
		< stBuilder, typeResult, typeValue > = otype(stBuilder, ty);
		< stBuilder, evalResult, evalValue > = evaluateConstantExp(stBuilder, e);
		if (evalResult && typeResult && evalValue >= 1) {
			return < stBuilder, true, Array(typeValue, evalValue) >;
		} else if (evalResult && typeResult) {
			stBuilder = addScopeError(stBuilder, t@location, "Invalid array definition, array size must be larger than 0");
			return < stBuilder, false, Invalid() >;
		} else if (evalResult) {
			stBuilder = addScopeError(stBuilder, t@location, "Invalid array definition, the sizing constant is invalid");
			return < stBuilder, false, Invalid() >;
		} else if (typeResult) {
			stBuilder = addScopeError(stBuilder, t@location, "Invalid array definition, the type is invalid");
			return < stBuilder, false, Invalid() >;
		} else {
			stBuilder = addScopeError(stBuilder, t@location, "Invalid array definition, the type and sizing constant are invalid");
			return < stBuilder, false, Invalid() >;
		}
	}
	
	// Record: check the fields to make sure they have valid types and that the field
	// identifiers are unique.
	if (record(fs) := t) {
		list[tuple[OType fieldType, Ident fieldName]] fldTypes = [ ];
		set[Ident] seenAlready = { };
		bool foundTypeProblems = false; bool foundDuplicateIds = false;

		for (field(ids,ty) <- fs) {
			< stBuilder, typeResult, typeValue > = otype(stBuilder, ty);
			if (!typeResult) foundTypeProblems = true;
			for (fid <- ids) {
				if (fid in seenAlready) {
					stBuilder = addScopeError(stBuilder, fid@location, "Field <fid.name> is defined multiple times");
					foundDuplicateIds = true;
				} else {
					fldTypes += < typeValue, fid >;
				}
			}
		}
		
		if (foundTypeProblems && foundDuplicateIds) {
			stBuilder = addScopeError(stBuilder, t@location, "Invalid record definitions, invalid field types and duplicate field names found");
			return < stBuilder, false, Invalid() >;		
		} else if (foundTypeProblems) {
			stBuilder = addScopeError(stBuilder, t@location, "Invalid record definitions, invalid field types found");
			return < stBuilder, false, Invalid() >;		
		} else if (foundDuplicateIds) {
			stBuilder = addScopeError(stBuilder, t@location, "Invalid record definition, duplicate field names found");
			return < stBuilder, false, Invalid() >;		
		} else {
			return < stBuilder, true, Record(fldTypes) >;
		}
	} 
}