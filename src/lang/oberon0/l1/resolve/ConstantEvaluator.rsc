module lang::oberon0::l1::resolve::ConstantEvaluator

import List;
import Set;

import lang::oberon0::l1::ast::Oberon0;
import lang::oberon0::l1::resolve::SymbolTable;
import lang::oberon0::l1::resolve::Types;

//
// Constants in Oberon-0 can only be integers -- this function evaluates the constant
// expression to figure out the integer value for the constant.
//
// NOTE: Any constant expression which yields a non-integer value is considered to be
// an error.
//
// CITE: Wirth book, p. 30, paragraph 4.
//
public tuple[SymbolTableBuilder st, bool res, int val] evaluateConstantExp(SymbolTableBuilder stBuilder, Expression exp) {
	tuple[SymbolTableBuilder st, bool res, int val] evaluateUnaryOp(SymbolTableBuilder stBuilder, Expression e, int(int) op) {
		int result = 0;
		< stBuilder, res, val > = evaluateConstantExp(stBuilder, e);
		if (res) {
			result = op(val);
		}
		return < stBuilder, res, result >;
	}

	tuple[SymbolTableBuilder st, bool res, int val] evaluateBinaryOp(SymbolTableBuilder stBuilder, Expression l, Expression r, int(int,int) op) {
		int result = 0;
		< stBuilder, res, lval > = evaluateConstantExp(stBuilder, l);
		if (res) {
			< stBuilder, res, rval > = evaluateConstantExp(stBuilder, r);
			if (res) {
				result = op(lval,rval);
			}
		}
		return < stBuilder, res, result >;
	}
	
	switch(exp) {
		case nat(nval) : return <stBuilder, true, nval>;
		
		case lookup(cid,[]) : {
			set[Item] items = getConstants(stBuilder, cid);
			if (size(items) == 1) {
				Item item = getOneFrom(items);
				stBuilder.itemUses = stBuilder.itemUses + < item, cid@location >;
				return < stBuilder, true, item.val >;					
			} else if (size(items) == 0) {
				stBuilder = addScopeError(stBuilder,exp@location,"Name <cid.name> must be a defined constant.");
			} else {
				stBuilder = addScopeError(stBuilder,exp@location,"Unexpected error, multiple in-scope constant definitions were found for name <cid.name>");				
			} 
			return <stBuilder, false, 0>;
		}

		case lookup(cid,sels) : {
			stBuilder = addScopeError(stBuilder,exp@location,"Names used in constant expressions must represent integer constants, not arrays or records");
			return <stBuilder, false, 0>;
		}
		
		case neg(e) : return evaluateUnaryOp(stBuilder,e,int(int n) { return (-1) * n; });
		
		case pos(e) : return evaluateUnaryOp(stBuilder,e,int(int n) { return n; });

		case mul(l,r) : return evaluateBinaryOp(stBuilder,l,r,int(int x, int y) { return x * y; });
		
		case div(l,r) : return evaluateBinaryOp(stBuilder,l,r,int(int x, int y) { return x / y; });

		case mod(l,r) : return evaluateBinaryOp(stBuilder,l,r,int(int x, int y) { return x % y; });

		case add(l,r) : return evaluateBinaryOp(stBuilder,l,r,int(int x, int y) { return x + y; });
		
		case sub(l,r) : return evaluateBinaryOp(stBuilder,l,r,int(int x, int y) { return x - y; });
		
		default : {
			stBuilder = addScopeError(stBuilder, exp@location, "Invalid expression in constant definition.");
			return < stBuilder, false, 0 >;
		}		
	}
}


