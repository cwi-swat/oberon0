module lang::oberon0::l2::check::CheckTypes

import IO;
import List;
import Set;
import Node;

import lang::oberon0::l2::ast::Oberon0;
extend lang::oberon0::l1::check::CheckTypes;

import Message;

public void checkStat(f:forDo(n, f, t, b)) {
	Item vItem = v@item;
	if (Constant(_,_,_) := vItem) {
		errors += [error(s@location, "A constant cannot be an assignment target")];
	} else {
		OType ot = getTypeFor(v, s@location);
		if (Invalid() != ot && Invalid() != e@otype && ot != e@otype) {
			errors += [error(s@location, "Cannot assign value of type <prettyPrint(e@otype)>, expected type <prettyPrint(ot)>")]; 
		}
	}		
}
		
public void checkStat(r:repeatUntil(b, c)) {
	// Make sure the while guard is a boolean
	if (Boolean() != c@otype && Invalid() != c@otype) {
		errors += [error(c@location, "The guard of a repeat loop must have type BOOLEAN, not <prettyPrint(c@otype)>")];
	}
}
		
public void checkStat(c:caseOf(exp, cs, es)) {
	if (Integer() != c@otype && Invalid() != c@otype) {
		errors += [error(c@location, "The expression of a case statement must have type INTEGER, not <prettyPrint(c@otype)>")];
	}
	errors += for (guard(x, body) <- cs) {
		if (x@otype != Integer() && x@otype != Invalid()) {
			append error(x@location, "The guard in a case statement must have type INTEGER, not <prettyPrint(c@otype)>");
		}
	}
}

