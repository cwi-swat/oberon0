module lang::oberon0::l2::check::CheckTypes

import IO;
import List;
import Set;
import Node;

import lang::oberon0::l2::ast::Oberon0;
extend lang::oberon0::l1::check::CheckTypes;

import Message;

public void default checkStat(Statement s) {
	println(s);
}

public void checkStat(fl:forDo(n, f, t, b)) {
	OType ot = getTypeFor(n, n@location);
	if (ot != Integer() && ot != Invalid()) {
		errors += [error(s@location, "Loop index variable cannot have type <prettyPrint(n@otype)>, must be INTEGER")]; 
	}
	
	ot = f@otype;
	if (ot != Integer() && ot != Invalid()) {
		errors += [error(s@location, "Initial expression of for loop cannot have type <prettyPrint(ot)>, must be INTEGER")]; 
	}
	
	ot = t@otype;
	if (ot != Integer() && ot != Invalid()) {
		errors += [error(s@location, "Upper bound expression of for loop cannot have type <prettyPrint(ot)>, must be INTEGER")]; 
	}
}
		
public void checkStat(repeatUntil(b, c)) {
	// Make sure the while guard is a boolean
	if (Boolean() != c@otype && Invalid() != c@otype) {
		errors += [error(c@location, "The guard of a repeat loop must have type BOOLEAN, not <prettyPrint(c@otype)>")];
	}
}
		
public void checkStat(caseOf(exp, cs, es)) {
	if (Integer() != exp@otype && Invalid() != exp@otype) {
		errors += [error(exp@location, "The expression of a case statement must have type INTEGER, not <prettyPrint(exp@otype)>")];
	}
	errors += for (guard(x, body) <- cs) {
		if (x@otype != Integer() && x@otype != Invalid()) {
			append error(x@location, "The guard in a case statement must have type INTEGER, not <prettyPrint(c@otype)>");
		}
	}
}

