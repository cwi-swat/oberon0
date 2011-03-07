module lang::oberon0::l1::resolve::SymbolTable

import List;
import Set;
import String;
import Node;
import Relation;
import IO;

import lang::oberon0::l1::ast::Oberon0;
import lang::oberon0::l1::resolve::Types;

//
// Flag different namespaces for names. Oberon0 ony has two: one for module
// names, and one for everything else.
//
data Namespace = UserNames() | Modules();
	
//
// Scope items, representing either scopes (Top), items in the scope (Variable),
// or both (Procedure, Module).
//
data Item =
	  Top()
	| Variable(Ident name, OType otype, loc definedAt)
	| Constant(Ident name, int val, loc definedAt)
	| Module(Ident name, loc definedAt)
	| Type(Ident name, OType otype, loc definedAt)
	| BuiltInType(Ident name)
	;

	
public str prettyPrint(Variable(n,t,_)) = "VAR <n.name> : <prettyPrint(t)>";
public str prettyPrint(Constant(n,v,_)) = "CONST <n.name> = <v>";
public str prettyPrint(Type(n,t,_)) = "TYPE <n.name> = <prettyPrint(t)>";
public str prettyPrint(BuiltInType(n)) = "TYPE <n.name>";
public str prettyPrint(Top()) = "TOP SCOPE";
public str prettyPrint(Module(n,_)) = "MODULE <n.name>";


//
// This is the final version of the symbol table, not including all
// the stuff that is needed to build it.
//
alias SymbolTable = rel[Item parent, Item child];

//
// General symbol table for Oberon0 programs.
//
alias SymbolTableBuilder = tuple[    
    SymbolTable symbolTable,
    rel[Item parent, Ident name, Item child] scopeNames,
    rel[Item usedItems, loc useLoc] itemUses, 
    rel[loc, str] scopeErrors, 
    list[Item] scopeStack
	];

public SymbolTableBuilder createNewSymbolTableBuilder() {
	return < { }, { }, { }, { }, [ Top() ] >;
}                    
	
//
// Push a scope onto the scope stack. This opens a new scope.
//
public SymbolTableBuilder pushScope(SymbolTableBuilder stBuilder, Item item) {
	stBuilder.scopeStack = [ item ] + stBuilder.scopeStack;
	return stBuilder;
}

//
// Pop the scope stack, going back to the prior scope.
//
public SymbolTableBuilder popScope(SymbolTableBuilder stBuilder) {
	if (size(stBuilder.scopeStack) == 0) {
		throw "popScope: Scope Stack is empty, cannot pop!";
	}
	stBuilder.scopeStack = tail(stBuilder.scopeStack);
	return stBuilder;
}

//
// Add a named item into the symbol table
//
public SymbolTableBuilder addNamedItem(SymbolTableBuilder stBuilder, Item item, loc l) {
	stBuilder.symbolTable = stBuilder.symbolTable + < stBuilder.scopeStack[0], item >;
	stBuilder.scopeNames = stBuilder.scopeNames + < stBuilder.scopeStack[0], item.name, item >;
	stBuilder.itemUses = stBuilder.itemUses + < item, l >;
	return stBuilder;	
}

//
// Add a named built-in item into the top scope of the symbol table
//
public SymbolTableBuilder addNamedBuiltIn(SymbolTableBuilder stBuilder, Item item) {
	stBuilder.symbolTable = stBuilder.symbolTable + < stBuilder.scopeStack[size(stBuilder.scopeStack)-1], item >;
	stBuilder.scopeNames = stBuilder.scopeNames + < stBuilder.scopeStack[size(stBuilder.scopeStack)-1], item.name, item >; 
	return stBuilder;	
}

//
// Add a new module. Modules create a new scope, and must be added at the top (no nesting).
//
public SymbolTableBuilder pushNewModuleScope(SymbolTableBuilder stBuilder, Ident name, loc l) {
	if (Top() !:= stBuilder.scopeStack[0]) { 
		throw "Modules cannot be added inside another scope!";
	}
	
	// Wire the new module into the scope structure. Note that we add the module name into the visible
	// names for both the current scope and the module's scope, since the module name is visible within
	// the module iteself.
	Item mi = Module(name, l);
	stBuilder.symbolTable = stBuilder.symbolTable + < stBuilder.scopeStack[0], mi >;
	stBuilder.scopeNames = stBuilder.scopeNames + < stBuilder.scopeStack[0], mi.name, mi > + < mi, mi.name, mi >;
	stBuilder.itemUses = stBuilder.itemUses + < mi, name@location >; 
	stBuilder = pushScope(stBuilder, mi);

	return stBuilder;	
}

//
// Add a new variable into the scope
//
public SymbolTableBuilder addVariable(SymbolTableBuilder stBuilder, Ident name, OType otype, loc l) {
	//if (Module(_,_) !:= stBuilder.scopeStack[0] && Procedure(_,_,_) !:= stBuilder.scopeStack[0]) 
	//	throw "Variables can only be added into the scope of a module or procedure";
	return addNamedItem(stBuilder, Variable(name, otype, l), name@location);
}

//
// Add a new constant into the scope
//
public SymbolTableBuilder addConstant(SymbolTableBuilder stBuilder, Ident name, int val, loc l) {
	//if (Module(_,_) !:= stBuilder.scopeStack[0] && Procedure(_,_,_) !:= stBuilder.scopeStack[0]) 
	//	throw "Named constants can only be added into the scope of a module or procedure";
	return addNamedItem(stBuilder, Constant(name, val, l), name@location);
}

//
// Add a new type into the scope
//
public SymbolTableBuilder addType(SymbolTableBuilder stBuilder, Ident name, OType otype, loc l) {
	//if (Module(_,_) !:= stBuilder.scopeStack[0] && Procedure(_,_,_) !:= stBuilder.scopeStack[0]) 
	//	throw "Named types can only be added into the scope of a module or procedure";
	return addNamedItem(stBuilder, Type(name, otype, l), name@location);
}

//
// Add a new built-in type into the scope
//
public SymbolTableBuilder addBuiltInType(SymbolTableBuilder stBuilder, Ident name) {
	return addNamedBuiltIn(stBuilder, BuiltInType(name));
}

//
// Register scope-level errors (e.g., illegal repetitions of variable names)
//
public SymbolTableBuilder addScopeError(SymbolTableBuilder stBuilder, loc l, str msg) {
	return stBuilder[scopeErrors = stBuilder.scopeErrors + < l, "<stBuilder.scopeStack[0]>:<msg>" >];
}

//
// Lookup a name in the given scope. The lookup rule here is simple -- it always starts at the given
// scope and goes all the way to the top.
//
public set[Item] getItems(SymbolTableBuilder stBuilder, Item startingScope, Ident name, Namespace ns) {
	set[Item] foundItems = { i | i <- stBuilder.scopeNames[startingScope,name],
			(Module() := ns) ? getName(i) == "Module" : getName(i) != "Module"  };
	if (size(foundItems) == 0 && Top() !:= startingScope) {
		return getItems(stBuilder,getOneFrom(invert(stBuilder.symbolTable)[startingScope]),name,ns);
	} 	
	return foundItems;
}

//
// Lots of helpers to look up specific types of items. This just saves the caller from a filtering step.
//

public set[Item] getVariables(SymbolTableBuilder stBuilder, Ident name) {
	return { i | i:Variable(_, _, _) <- getItems(stBuilder, stBuilder.scopeStack[0], name, UserNames()) };
}

public set[Item] getConstants(SymbolTableBuilder stBuilder, Ident name) {
	return { i | i:Constant(_, _, _) <- getItems(stBuilder, stBuilder.scopeStack[0], name, UserNames()) };
}

public set[Item] getTypes(SymbolTableBuilder stBuilder, Ident name) {
	return getTypesAt(stBuilder, name, stBuilder.scopeStack[0]);
}

public set[Item] getTypesAt(SymbolTableBuilder stBuilder, Ident name, Item ctx) {
	items = getItems(stBuilder, ctx, name, UserNames()) ;
	return { i | i:Type(_, _, _) <- items } + { i | i:BuiltinType(_) <- items };
}

public set[Item] getModules(SymbolTableBuilder stBuilder, Ident name) {
	return { i | i:Module(_, _) <- getItems(stBuilder, stBuilder.scopeStack[0], name, Modules()) };
}
