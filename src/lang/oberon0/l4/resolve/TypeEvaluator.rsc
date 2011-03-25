module lang::oberon0::l4::resolve::TypeEvaluator

import lang::oberon0::l4::ast::Oberon0;
import lang::oberon0::l3::resolve::SymbolTable;
import lang::oberon0::l4::resolve::Types;

extend lang::oberon0::l1::resolve::TypeEvaluator;

public tuple[SymbolTableBuilder st, bool cres, OType ot] otype(SymbolTableBuilder stBuilder, t:array(e, ty)) {
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

public tuple[SymbolTableBuilder st, bool cres, OType ot] otype(SymbolTableBuilder stBuilder, t:record(fs)) {
	// Record: check the fields to make sure they have valid types and that the field
	// identifiers are unique.
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