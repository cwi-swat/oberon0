module lang::oberon0::check::CheckTypes

import IO;
import List;
import Set;
import Node;

import lang::oberon0::ast::Oberon0;
import lang::oberon0::check::Types;
import lang::oberon0::resolve::SymbolTable;
import lang::oberon0::resolve::Resolver;

anno OType Expression@otype;
anno rel[loc,str] Module@typeErrors;

public Module checkTypes(Module ast, SymbolTable st) {
	rel[loc,str] errors = { } ;

	//
	// Get the type for an item. This is in the context of lvalues, so these are items that 
	// can be assigned into and read from, i.e., not names representing types, modules, or 
	// procedures. Variables and Formal Parameters can represent records and arrays, while
	// constants cannot, so we check here to make sure the selectors for a constant are
	// empty (and give an error if they are not).
	//
	OType getTypeFor(Ident v, list[Selector] selectors, loc l) {
		Item item = v@item;
		switch (item) {
			case Variable(_,ot,_): return getTypeFor(ot,selectors,l,item);
			case Constant(_,_,_): {
				if (selectors == []) {
					return Integer();
				}
				errors = errors + < l, "<v.name> is a constant INTEGER, no selectors should be used" >;
				return Invalid();
			}
			case FormalParameter(_,ot,_,_): return getTypeFor(ot,selectors,l,item);
			default: { 
				errors = errors + < l, "<v.name> is not a variable, constant, or formal parameter, and cannot be used in this context: <item>" >;
				return Invalid();
			}
		}
	}
	
	//
	// Unwind all the type aliases in a type. This ensures that we can compare two types
	// just by checking to see if their representations are equal (we have no subtyping).
	//
	OType unwind(OType ot, Item ctx) {
		switch(ot) {
			case Array(et,n) : return Array(unwind(et,ctx),n);
			case Record(fs) : return Record([<unwind(ft,ctx),fn> | <ft,fn> <- fs]);
			case User(n) : {
				if ({tItem} := getTypesAt(stBuilder,n,ctx)) {
					switch (tItem) {
						case BuiltInType(id("INTEGER")): return Integer();
						case Type(_,ut,_): return unwind(ut, tItem);
					}
				}
				return Invalid();
			}
			default : return ot;
		}
	}
		
	//
	// Encode the rules constraining the use of types (e.g., no subscripts on ints).
	// This detects any errors in variable expressions and returns either the resulting
	// type or Invalid() if there is an error. Note that this code also fully unwinds
	// the type, so we remove all type aliases (declared types).
	//
	OType getTypeFor(OType ot, list[Selector] selectors, loc l, Item ctx) {
		switch (ot) {
			case Integer(): {
			// INTEGER: There should be no selectors.
				if (size(selectors) == 0) {
					return ot;
				}
				errors = errors + < l, "You cannot use subscripts or fields with values of type integer" >;
				return Invalid();
			}
			case Array(ota,n): {
				// ARRAY: There should either be no selectors, or the first selector
				// should be a subscript with expression evaluating to type INTEGER,
				// in which case we recurse on the array element type and the remaining
				// selectors.
				if (size(selectors) == 0) {
					return unwind(ot,ctx);
				}
				switch (<head(selectors), se@otype>) {
					case <subscript(se), Integer()>: return getTypeFor(ota,tail(selectors),l,ctx);
					case <subscript(se), _>: {
						errors = errors + < l, "You cannot use a non-INTEGER subscript to access an array" >;
						return Invalid();
					}
					default: {
						errors = errors + < l, "You cannot use fields on values of array type" >;
						return Invalid();
					}
				}
			}
			case Record(fs): {
				// RECORD: There should either be no selectors, or the first selector
				// should be a field, and that field should be one of the defined
				// fields for the record, in which case we will recurse on the type
				// of the field and the remaining selectors.
				if (size(selectors) == 0) {
					return unwind(ot,ctx);
				} 
				if (size(selectors) > 0 && field(fid) := head(selectors)) {
					list[OType] flds = { f.fieldType | f <- fs, f.fieldName == fid };
					if (size(flds) == 0) {
						errors = errors + < l, "Field <fid.name> not defined in record type" >;
						return Invalid();
					} 
					if (size(flds) == 1) {
						return getTypeFor(flds[0], tail(selectors), l, ctx);
					}		
					errors = errors + < l, "Multiple fields with name <fid.name> defined in record type" >;
					return Invalid();
				} 
				errors = errors + < l, "You cannot use subscripts on values of record type" >;
				return Invalid();
			}
			case User(tid): {
				OType unwound = unwind(ot);
				if (Invalid() := unwound) {
					errors = errors + < l, "Named type <tid.name> cannot be resolved to a valid Oberon type" >;
					return Invalid();
				}
				return unwound;
			}
			case Boolean(): {
				errors = errors + < l, "BOOLEAN cannot be used explicitly as a type" >;
				return Invalid();
			}
			case Invalid(): return ot;
			default: throw "Unhandled type: <ot>";
		}
	}
	
	//
	// Check lists of expected types against lists of given types, returning
	// the result type if the comparisons all succeed and none of the given
	// types are invalid. This abstracts checking unary and binary operations.
	//
	OType opTypes(list[OType] expected, list[OType] given, OType resType, loc l) {
		if (Invalid() in given) {
			return Invalid();
		}
		for (n <- [0..size(expected)-1]) {
			if (expected[n] != given[n]) {
				errors = errors + < l, "Operand <n+1>, expected type <prettyPrint(expected[n])>, but given type <prettyPrint(given[n])>" >;
				resType = Invalid();				
			}
		}
		return resType;
	}
	
	//
	// A number of wrappers calling the above function with preset expected and result types.
	//
	OType uI2I(OType operand, loc l) {
		return opTypes([Integer()],[operand],Integer(),l);
	}
	
	OType uB2B(OType operand, loc l) {
		return opTypes([Boolean()],[operand],Boolean(),l);
	}
	
	OType bII2I(OType left, OType right, loc l) {
		return opTypes([Integer(),Integer()],[left,right],Integer(),l);
	}
	
	OType bBB2B(OType left, OType right, loc l) {
		return opTypes([Boolean(),Boolean()],[left,right],Boolean(),l);
	}
	
	OType bII2B(OType left, OType right, loc l) {
		return opTypes([Integer(),Integer()],[left,right],Boolean(),l);
	}
	
	//
	// Check to see if the expression can be written into, i.e., is a variable or formal
	// parameter, but not a constant, procedure, etc. This is mainly used to check that
	// an expression can be used with a var parameter, meaning it has an address that can
	// be written into (i.e., in C parlance is an lvalue or object).
	//
	bool expIsWritable(Expression e) {
		return (lookup(v,ss) := e && (Variable(_,_,_) := v@item || FormalParameter(_,_,_,_) := v@item));
	}
	
	// Here we actually compute the checked AST, which is the original AST
	// decorated with type annotations. Any errors are tracked in the errors
	// related defined above. Note that we check for and propagage Invalid() 
	// types to make sure one invalid expression does not cause a cascade of
	// error messages.
	checkedAst = bottom-up visit(ast) {
		// Expressions actually carry types
		case e:nat(n) => e[@otype = Integer()]
		case e:lookup(v,ss) => e[@otype = getTypeFor(v,ss,e@location)]
		case e:neg(uop) => e[@otype = uI2I(uop@otype,e@location)]
		case e:pos(uop) => e[@otype = uI2I(uop@otype,e@location)]
		case e:not(uop) => e[@otype = uB2B(uop@otype,e@location)]
		case e:mul(lop,rop) => e[@otype = bII2I(lop@otype,rop@otype,e@location)]
		case e:div(lop,rop) => e[@otype = bII2I(lop@otype,rop@otype,e@location)]
		case e:mod(lop,rop) => e[@otype = bII2I(lop@otype,rop@otype,e@location)]
		case e:amp(lop,rop) => e[@otype = bBB2B(lop@otype,rop@otype,e@location)]
		case e:add(lop,rop) => e[@otype = bII2I(lop@otype,rop@otype,e@location)]
		case e:sub(lop,rop) => e[@otype = bII2I(lop@otype,rop@otype,e@location)]
		case e:or(lop,rop) => e[@otype = bBB2B(lop@otype,rop@otype,e@location)]
		case e:eq(lop,rop) => e[@otype = bII2B(lop@otype,rop@otype,e@location)]
		case e:neq(lop,rop) => e[@otype = bII2B(lop@otype,rop@otype,e@location)]
		case e:lt(lop,rop) => e[@otype = bII2B(lop@otype,rop@otype,e@location)]
		case e:gt(lop,rop) => e[@otype = bII2B(lop@otype,rop@otype,e@location)]
		case e:leq(lop,rop) => e[@otype = bII2B(lop@otype,rop@otype,e@location)]
		case e:geq(lop,rop) => e[@otype = bII2B(lop@otype,rop@otype,e@location)]

		// Statements do not carry types, but do have type rules needed for correctness
		case s:assign(v,ss,e) : {
			// Make sure the target, v, is not a constant. If it is not, make sure the type
			// of variable v with selectors ss is the same as the type of e. Both types
			// should be unwound, so we can just do an equality check.
			Item vItem = v@item;
			if (Constant(_,_,_) := vItem) {
				errors = errors + < s@location, "A constant cannot be an assignment target" >;
			} else {
				OType ot = getTypeFor(v,ss,s@location);
				if (Invalid() != ot && Invalid() != e@otype && ot != e@otype) {
					errors = errors + < s@location, "Cannot assign value of type <prettyPrint(e@otype)>, expected type <prettyPrint(ot)>" >; 
				}
			}		
		}
		case s:call(p,args) : {
			// Make sure p is either a procedure or built-in procedure. If so, we ensure the
			// arities of the formals and actuals match, and then make sure the types match
			// as well. Finally, we make sure that the actual is a lookup expression for
			// any VAR parameters, and that the looked-up item is not a constant, since we
			// need to make sure we can write back into that location.
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
		
		case s:ifThen(c,bs,elifs,ep) : {
			// Make sure any conditional guards are booleans
			if (Boolean() != c@otype && Invalid() != c@otype) {
				errors = errors + < c@location, "The guard of a conditional must have type BOOLEAN, not <prettyPrint(c@otype)>" >;
			}
			for (<ec,ebs> <- elifs, Boolean() != ec@otype && Invalid() != ec@otype) {
				errors = errors + < ec@location, "The guard of a conditional must have type BOOLEAN, not <prettyPrint(ec@otype)>" >;
			}
		}
		
		case s:whileDo(c,bs) : 
			// Make sure the while guard is a boolean
			if (Boolean() != c@otype && Invalid() != c@otype) {
				errors = errors + < c@location, "The guard of a while loop must have type BOOLEAN, not <prettyPrint(c@otype)>" >;
			}
	};

	// At this point, we have gathered all type errors. Add these messages to the top node of the AST,
	// returning it as the final result of the checker.	
	return checkedAst[@typeErrors = errors];
}
