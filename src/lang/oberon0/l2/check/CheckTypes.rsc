module lang::oberon0::l2::check::CheckTypes

import IO;
import List;
import Set;
import Node;

import lang::oberon0::l2::ast::Oberon0;
import lang::oberon0::l1::resolve::NameAnnotator;
extend lang::oberon0::l1::check::CheckTypes;

import Message;


public void checkStat(forDo(n, f, t, b), SymbolTable st) {
	OType ot = getTypeFor(n, n@location, st);
	if (ot != Integer() && ot != Invalid()) {
		errors += error(n@location, "Loop index variable cannot have type <prettyPrint(ot)>, must be INTEGER"); 
	}
	
	ot = f@otype;
	if (ot != Integer() && ot != Invalid()) {
		errors += error(f@location, "Initial expression of for loop cannot have type <prettyPrint(ot)>, must be INTEGER"); 
	}
	
	ot = t@otype;
	if (ot != Integer() && ot != Invalid()) {
		errors += error(t@location, "Upper bound expression of for loop cannot have type <prettyPrint(ot)>, must be INTEGER"); 
	}
}
		
public void checkStat(repeatUntil(b, c), SymbolTable st) {
	// Make sure the while guard is a boolean
	if (Boolean() != c@otype && Invalid() != c@otype) {
		errors += error(c@location, "The guard of a repeat loop must have type BOOLEAN, not <prettyPrint(c@otype)>");
	}
}
		
public void checkStat(caseOf(exp, cs, es), SymbolTable st) {
	if (Integer() != exp@otype && Invalid() != exp@otype) {
		errors += error(exp@location, "The expression of a case statement must have type INTEGER, not <prettyPrint(exp@otype)>");
	}
	for (guard(x, body) <- cs) {
		if (x@otype != Integer() && x@otype != Invalid()) {
			errors += error(x@location, "The guard in a case statement must have type INTEGER, not <prettyPrint(c@otype)>");
		}
	}
}

