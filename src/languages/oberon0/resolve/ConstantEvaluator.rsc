module languages::oberon0::resolve::ConstantEvaluator

import List;
import Set;

import languages::oberon0::ast::Oberon0;
import languages::oberon0::resolve::SymbolTable;
import languages::oberon0::check::Types;

//
// Constants in Oberon-0 can only be integers -- this function evaluates the constant
// expression to figure out the integer value for the constant.
//
// NOTE: Any constant expression which yields a non-integer value is considered to be
// an error.
//
// CITE: Wirth book, p. 30, paragraph 4.
//
public tuple[SymbolTable st, bool res, int val] evaluateConstantExp(SymbolTable symbolTable, Expression exp, bool registerErrors) {
	switch(exp) {
		case nat(nval) : 
			return <symbolTable, true, nval>;
		
		case lookup(v) : {
			if (var(cid,[]) := v) {
				set[STItemId] items = getItemsForName(symbolTable, cid);
				if (size(items) == 1) {
					if (ConstantItem(_,cval,_) := getOneFrom(items)) {
						return < symbolTable, true, cval >;					
					} else {
						if (registerErrors) symbolTable = addScopeError(symbolTable,exp@location,"Name <cid.name> must be a defined constant.");
					}
				} else {
					if (registerErrors) symbolTable = addScopeError(symbolTable,exp@location,"Multiple definitions were found for name <cid.name>");				
				} 
			} else {
				if (registerErrors) symbolTable = addScopeError(symbolTable,exp@location,"Names used in constant expressions must represent integer constants");
			}
			return <symbolTable, false, 0>;
		}
		
		case neg(e) : {
			int result = 0;
			< symbolTable, res, lval > = evaluateConstantExp(symbolTable, l);
			if (res) {
				result = (-1) * lval;
			}
			return < symbolTable, res, result >;
		}
		
		case pos(e) : {
			int result = 0;
			< symbolTable, res, lval > = evaluateConstantExp(symbolTable, l);
			if (res) {
				result = lval;
			}
			return < symbolTable, res, result >;
		}
		
		case mul(l,r) : {
			int result = 0;
			< symbolTable, res, lval > = evaluateConstantExp(symbolTable, l);
			if (res) {
				< symbolTable, res, rval > = evaluateConstantExp(symbolTable, r);
				if (res) {
					result = lval * rval;
				}
			}
			return < symbolTable, res, result >;
		}
		
		case div(l,r) : {
			int result = 0;
			< symbolTable, res, lval > = evaluateConstantExp(symbolTable, l);
			if (res) {
				< symbolTable, res, rval > = evaluateConstantExp(symbolTable, r);
				if (res) {
					result = lval / rval;
				}
			}
			return < symbolTable, res, result >;
		}
		
		case mod(l,r) : {
			int result = 0;
			< symbolTable, res, lval > = evaluateConstantExp(symbolTable, l);
			if (res) {
				< symbolTable, res, rval > = evaluateConstantExp(symbolTable, r);
				if (res) {
					result = lval % rval;
				}
			}
			return < symbolTable, res, result >;
		}
		
		case add(l,r) : {
			int result = 0;
			< symbolTable, res, lval > = evaluateConstantExp(symbolTable, l);
			if (res) {
				< symbolTable, res, rval > = evaluateConstantExp(symbolTable, r);
				if (res) {
					result = lval + rval;
				}
			}
			return < symbolTable, res, result >;
		}
		
		case sub(l,r) : {
			int result = 0;
			< symbolTable, res, lval > = evaluateConstantExp(symbolTable, l);
			if (res) {
				< symbolTable, res, rval > = evaluateConstantExp(symbolTable, r);
				if (res) {
					result = lval - rval;
				}
			}
			return < symbolTable, res, result >;
		}
		
		default : {
			if (registerErrors) symbolTable = addScopeError(symbolTable, exp@location, "Invalid expression in constant definition.");
			return < symbolTable, false, 0 >;
		}		
	}
}

public tuple[SymbolTable st, bool res, int val] evaluateConstantExp(SymbolTable symbolTable, Expression exp) {
	return evaluateConstantExp(symbolTable, exp, true);
}

public tuple[SymbolTable st, bool res, int val] evaluateConstantExpNoFlags(SymbolTable symbolTable, Expression exp) {
	return evaluateConstantExp(symbolTable, exp, false);
}