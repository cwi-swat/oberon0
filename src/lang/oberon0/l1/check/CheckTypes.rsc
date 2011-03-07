module lang::oberon0::l1::check::CheckTypes

import IO;
import List;
import Set;
import Node;

import lang::oberon0::l1::ast::Oberon0;
import lang::oberon0::l1::resolve::Types;
import lang::oberon0::l1::resolve::SymbolTable;
import lang::oberon0::l1::resolve::NameAnnotator;
import lang::oberon0::l1::resolve::Resolver;

import Message;

anno OType Expression@otype;

// must be global, otherwise the local functions are not available for extension.
private list[Message] errors = [] ;

public tuple[Module mod, list[Message] errors] checkTypes(Module ast, SymbolTable st) {
	// reset global
	errors = [];

	
	// Here we actually compute the checked AST, which is the original AST
	// decorated with type annotations. Any errors are tracked in the errors
	// related defined above. Note that we check for and propagage Invalid() 
	// types to make sure one invalid expression does not cause a cascade of
	// error messages.
	checkedAst = bottom-up visit(ast) {
		case Expression e => checkExp(e)
		case Statement s: checkStat(s);
	};

	// At this point, we have gathered all type errors. Add these messages to the top node of the AST,
	// returning it as the final result of the checker.	
	return <checkedAst, sort(errors)>;
}



//
// Get the type for an item. This is in the context of lvalues, so these are items that 
// can be assigned into and read from, i.e., not names representing types, modules, or 
// procedures. Variables and Formal Parameters can represent records and arrays, while
// constants cannot, so we check here to make sure the selectors for a constant are
// empty (and give an error if they are not).
//

public OType itemType(item:Variable(_, ot, _), loc l) = getTypeFor(ot, l,item);
public OType itemType(Constant(_, _, _), loc l) = Integer();


OType getTypeFor(Ident v, loc l) {
	Item item = v@item;
	return itemType(item, l);	
}


//
// Unwind all the type aliases in a type. This ensures that we can compare two types
// just by checking to see if their representations are equal (we have no subtyping).
//
OType unwind(User(n)) {
	// where does stBuilder and ctx come from?
	if ({tItem} := getTypesAt(stBuilder,n,ctx)) {
		switch (tItem) {
			case BuiltInType(id("INTEGER")): return Integer();
			case BuiltInType(id("BOOLEAN")): return Boolean();
			case Type(_,ut,_): return unwind(ut, tItem);
		}
	}
	return Invalid();
}

OType default unwind(OType t) = t;


//
// Encode the rules constraining the use of types (e.g., no subscripts on ints).
// This detects any errors in variable expressions and returns either the resulting
// type or Invalid() if there is an error. Note that this code also fully unwinds
// the type, so we remove all type aliases (declared types).
//
OType getTypeFor(Integer(), loc l, Item ctx) = Integer();
OType getTypeFor(Boolean(), loc l, Item ctx) = Boolean();

OType getTypeFor(User(tid), loc l, Item ctx) {
	OType unwound = unwind(ot);
	if (Invalid() := unwound) {
		errors += [error(l, "Named type <tid.name> cannot be resolved to a valid Oberon type")];
		return Invalid();
	}
	return unwound;
}


OType getTypeFor(Invalid(), loc l, Item ctx) = Invalid();

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
			errors += [error(l, "Operand <n+1>, expected type <prettyPrint(expected[n])>, but given type <prettyPrint(given[n])>")];
			resType = Invalid();				
		}
	}
	return resType;
}

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
	return (lookup(v,ss) := e && isWritableKind(v@item));
}

// to be extended for formal params.
bool isWritableKind(Variable(_, _, _)) = true;



public Expression checkExp(e:nat(n)) 		= e[@otype = Integer()];
public Expression checkExp(e:lookup(v)) 	= e[@otype = getTypeFor(v, e@location)];
public Expression checkExp(e:neg(uop)) 		= e[@otype = uI2I(uop@otype,e@location)];
public Expression checkExp(e:pos(uop)) 		= e[@otype = uI2I(uop@otype,e@location)];
public Expression checkExp(e:not(uop)) 		= e[@otype = uB2B(uop@otype,e@location)];
public Expression checkExp(e:mul(lop,rop)) 	= e[@otype = bII2I(lop@otype,rop@otype,e@location)];
public Expression checkExp(e:div(lop,rop)) 	= e[@otype = bII2I(lop@otype,rop@otype,e@location)];
public Expression checkExp(e:Expression::mod(lop,rop)) 	= e[@otype = bII2I(lop@otype,rop@otype,e@location)];
public Expression checkExp(e:amp(lop,rop)) 	= e[@otype = bBB2B(lop@otype,rop@otype,e@location)];
public Expression checkExp(e:add(lop,rop)) 	= e[@otype = bII2I(lop@otype,rop@otype,e@location)];
public Expression checkExp(e:sub(lop,rop)) 	= e[@otype = bII2I(lop@otype,rop@otype,e@location)];
public Expression checkExp(e:or(lop,rop)) 	= e[@otype = bBB2B(lop@otype,rop@otype,e@location)];
public Expression checkExp(e:eq(lop,rop)) 	= e[@otype = bII2B(lop@otype,rop@otype,e@location)];
public Expression checkExp(e:neq(lop,rop)) 	= e[@otype = bII2B(lop@otype,rop@otype,e@location)];
public Expression checkExp(e:lt(lop,rop)) 	= e[@otype = bII2B(lop@otype,rop@otype,e@location)];
public Expression checkExp(e:gt(lop,rop)) 	= e[@otype = bII2B(lop@otype,rop@otype,e@location)];
public Expression checkExp(e:leq(lop,rop)) 	= e[@otype = bII2B(lop@otype,rop@otype,e@location)];
public Expression checkExp(e:geq(lop,rop)) 	= e[@otype = bII2B(lop@otype,rop@otype,e@location)];


public void checkStat(s:assign(v, e)) {
	// Make sure the target, v, is not a constant. If it is not, make sure the type
	// of variable v with selectors ss is the same as the type of e. Both types
	// should be unwound, so we can just do an equality check.
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
		
public void checkStat(s:ifThen(c,bs,elifs,ep)) {
	// Make sure any conditional guards are booleans
	if (Boolean() != c@otype && Invalid() != c@otype) {
		errors += [error(c@location, "The guard of a conditional must have type BOOLEAN, not <prettyPrint(c@otype)>")];
	}
	errors += for (<ec,ebs> <- elifs, Boolean() != ec@otype && Invalid() != ec@otype) {
		append error(ec@location, "The guard of a conditional must have type BOOLEAN, not <prettyPrint(ec@otype)>");
	}
}
		
public void checkStat(s:whileDo(c,bs)) {
	// Make sure the while guard is a boolean
	if (Boolean() != c@otype && Invalid() != c@otype) {
		errors += [error(c@location, "The guard of a while loop must have type BOOLEAN, not <prettyPrint(c@otype)>")];
	}
}

