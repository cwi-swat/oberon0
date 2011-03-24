module lang::oberon0::l3::check::CheckTypes

import IO;
import List;
import Set;
import Node;

import lang::oberon0::l3::ast::Oberon0;
import lang::oberon0::l1::resolve::Types;
import lang::oberon0::l3::resolve::SymbolTable;
import lang::oberon0::l1::resolve::NameAnnotator;
import lang::oberon0::l3::resolve::Resolver;

extend lang::oberon0::l2::check::CheckTypes;

public void checkStat(s:call(p, args), SymbolTable st) {
	Item procItem = p@item;
	list[tuple[OType paramType, bool isVar]] params = [ ];
	bool isProc = true;
	
	// First check: we have a procedure or built-in procedure
	if (Procedure(pn,pargs,_) := procItem) {
		params = [ < unwind(pOtype, procItem), pIsVar > | FormalParameter(_,pOtype,pIsVar,_) <- pargs ];
	} 
	else if (BuiltInProcedure(pn,pargs) := procItem) {
		params = [ < unwind(pOtype, procItem), pIsVar > | <pOtype,pIsVar> <- pargs ];
	} 
	else {
		errors = errors + < s@location, "<p.name> is not a procedure" >;
		isProc = false;
	}
	
	if (isProc) {
		// Second check: arities match
		if (size(args) == size(params) && size(args) > 0) {
			for (n <- [0..size(args)-1]) {
				// Third check: types match
				OType paramType = params[n].paramType;
				OType argType = args[n]@otype;
				if (paramType != argType) {
					errors = errors + < (args[n])@location, "Actual parameter has type <prettyPrint(argType)>, but the formal parameter is of type <prettyPrint(paramType)>" >;
				} else {
					// Fourth check -- if the param is VAR, the actual is assignable
					if (params[n].isVar && !expIsWritable(args[n])) {
						errors = errors + < (args[n])@location, "Actual parameter must be a variable, array element, or record field, since the formal parameter is a VAR parameter" >;
					}	
				}
			}
		} else if (size(args) != size(params)) {
			errors = errors + < s@location, "Procedure <p.name> expects <size(params)> actuals, but was given <size(args)>" >;
		}
	}
}

public OType getTypeFor(item:FormalParameter(_, ot, _, _), loc l, SymbolTable st) 
  = getTypeFor(ot, l, item, st);	
  
bool isWritableKind(FormalParameter(_, _, _, _)) = true;
