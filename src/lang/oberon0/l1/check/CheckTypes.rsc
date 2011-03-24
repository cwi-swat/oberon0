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
private set[Message] errors = {} ;

public tuple[Module mod, set[Message] errors] checkTypes(Module ast, SymbolTable st) {
	// reset global
	errors = {};
	
	// Here we actually compute the checked AST, which is the original AST
	// decorated with type annotations. Any errors are tracked in the errors
	// related defined above. Note that we check for and propagage Invalid() 
	// types to make sure one invalid expression does not cause a cascade of
	// error messages.
	checkedAst = bottom-up visit(ast) {
		case Expression e => checkExp(e,st)
		case Statement s: checkStat(s,st);
	};

	// At this point, we have gathered all type errors. Add these messages to the top node of the AST,
	// returning it as the final result of the checker.	
	return <checkedAst, errors>;
}


//
// Given a name, return the type for the name based upon the Item information
// associated with the name.
//
OType getTypeFor(Ident v, loc l, SymbolTable st) = getTypeFor(v@item, l, st);

//
// Given the Item, either resolve the type name (for variables, for instance, which
// could have aliases) or return the type directly (for constants, for instance,
// which must have type INTEGER)
//
public OType getTypeFor(item:Variable(_, ot, _), loc l, SymbolTable st) = getTypeFor(ot, l, item, st);
public OType getTypeFor(Constant(_, _, _), loc l, SymbolTable st) = Integer();

public OType default getTypeFor(Item x, loc l, SymbolTable st) {
  println("WTF? <x> @ <l>");
  return Invalid();
}
//
// Given the type, resolve any type declarations used inside.
//
public OType getTypeFor(Integer(), loc l, Item ctx, SymbolTable st) = Integer();
public OType getTypeFor(Boolean(), loc l, Item ctx, SymbolTable st) = Boolean();
public OType getTypeFor(Invalid(), loc l, Item ctx, SymbolTable st) = Invalid();

public OType getTypeFor(User(tid), loc l, Item ctx, SymbolTable st) {
	OType unwound = unwind(ot, ctx, st);
	if (Invalid() := unwound) {
		errors += error(l, "Named type <tid.name> cannot be resolved to a valid Oberon type");
	}
	return unwound;
}

//
// Unwind all the type aliases in a type. This ensures that we can compare two types
// just by checking to see if their representations are equal (we have no subtyping).
// At this level, only User types can have type aliases.
//
OType unwind(User(n), Item ctx, SymbolTable st) {
	if ({tItem} := getTypesAt(st,n,ctx)) {
		switch (tItem) {
			case BuiltInType(_,ot): return ot;
			case Type(_,ut,_): return unwind(ut, tItem, st);
		}
	}
	return Invalid();
}

OType default unwind(OType t, Item ctx) = t;

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
			errors += error(l, "Operand <n+1>, expected type <prettyPrint(expected[n])>, but given type <prettyPrint(given[n])>");
			resType = Invalid();				
		}
	}
	return resType;
}

//
// TODO: It would be nicer to have some way of combining functions to specify constraints.
// Instead, this is a simple solution to handle the one case (equality, inequality) where
// it is possible to have multiple operand types. If we have an interest in adding additional
// comparable Oberon types, we need to revisit this.
//
OType bSS2B(OType left, OType right, loc l) {
	if (Invalid() in { left, right }) return Invalid();
	if (Integer() == left && Integer() == right) return Boolean();
	if (Boolean() == left && Boolean() == right) return Boolean();
	if (Integer() == left || Boolean() == left) {
		errors += error(l, "The type of the right operand, <prettyPrint(right)>, should be identical to the type of the left, <prettyPrint(left)>");
		return Invalid();
	}
	errors += error(l, "The type of the left operand must be either INTEGER or BOOLEAN, and must be identical to the type of the right operand");
	return Invalid();
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
bool expIsWritable(lookup(v)) = isWritableKind(v@item);

bool isWritableKind(Variable(_, _, _)) = true;
bool default isWritableKind(_) = false;
//
// Actually check the various forms of expression
//
public Expression checkExp(e:nat(n), SymbolTable st) 		= e[@otype = Integer()];
public Expression checkExp(e:\true(), SymbolTable st) 		= e[@otype = Boolean()];
public Expression checkExp(e:\false(), SymbolTable st) 		= e[@otype = Boolean()];
public Expression checkExp(e:lookup(v), SymbolTable st) 	= e[@otype = getTypeFor(v, e@location, st)];
public Expression checkExp(e:neg(uop), SymbolTable st) 		= e[@otype = uI2I(uop@otype,e@location)];
public Expression checkExp(e:pos(uop), SymbolTable st) 		= e[@otype = uI2I(uop@otype,e@location)];
public Expression checkExp(e:not(uop), SymbolTable st) 		= e[@otype = uB2B(uop@otype,e@location)];
public Expression checkExp(e:mul(lop,rop), SymbolTable st) 	= e[@otype = bII2I(lop@otype,rop@otype,e@location)];
public Expression checkExp(e:div(lop,rop), SymbolTable st) 	= e[@otype = bII2I(lop@otype,rop@otype,e@location)];
public Expression checkExp(e:Expression::mod(lop,rop), SymbolTable st) 	= e[@otype = bII2I(lop@otype,rop@otype,e@location)];
public Expression checkExp(e:amp(lop,rop), SymbolTable st) 	= e[@otype = bBB2B(lop@otype,rop@otype,e@location)];
public Expression checkExp(e:add(lop,rop), SymbolTable st) 	= e[@otype = bII2I(lop@otype,rop@otype,e@location)];
public Expression checkExp(e:sub(lop,rop), SymbolTable st) 	= e[@otype = bII2I(lop@otype,rop@otype,e@location)];
public Expression checkExp(e:or(lop,rop), SymbolTable st) 	= e[@otype = bBB2B(lop@otype,rop@otype,e@location)];
public Expression checkExp(e:eq(lop,rop), SymbolTable st) 	= e[@otype = bSS2B(lop@otype,rop@otype,e@location)];
public Expression checkExp(e:neq(lop,rop), SymbolTable st) 	= e[@otype = bSS2B(lop@otype,rop@otype,e@location)];
public Expression checkExp(e:lt(lop,rop), SymbolTable st) 	= e[@otype = bII2B(lop@otype,rop@otype,e@location)];
public Expression checkExp(e:gt(lop,rop), SymbolTable st) 	= e[@otype = bII2B(lop@otype,rop@otype,e@location)];
public Expression checkExp(e:leq(lop,rop), SymbolTable st) 	= e[@otype = bII2B(lop@otype,rop@otype,e@location)];
public Expression checkExp(e:geq(lop,rop), SymbolTable st) 	= e[@otype = bII2B(lop@otype,rop@otype,e@location)];


public void checkStat(s:assign(v, e), SymbolTable st) {
	Item vItem = v@item;
	if (Constant(_,_,_) := vItem) 
		errors += error(s@location, "A constant cannot be an assignment target");
	else {
		OType ot = getTypeFor(v, s@location, st);
		if (Invalid() != ot && Invalid() != e@otype && ot != e@otype) 
			errors += error(s@location, "Cannot assign value of type <prettyPrint(e@otype)>, expected type <prettyPrint(ot)>"); 
	}		
}
		
public void checkStat(s:ifThen(c,bs,elifs,ep), SymbolTable st) {
	if (Boolean() != c@otype && Invalid() != c@otype) 
		errors += error(c@location, "The guard of a conditional must have type BOOLEAN, not <prettyPrint(c@otype)>");
	for (<ec,ebs> <- elifs, Boolean() != ec@otype && Invalid() != ec@otype) 
		errors += error(ec@location, "The guard of a conditional must have type BOOLEAN, not <prettyPrint(ec@otype)>");
}
		
public void checkStat(s:whileDo(c,bs), SymbolTable st) {
	if (Boolean() != c@otype && Invalid() != c@otype) 
		errors += error(c@location, "The guard of a while loop must have type BOOLEAN, not <prettyPrint(c@otype)>");
}

