module languages::oberon0::resolve::SymbolTable

import List;
import Set;
import String;
import Node;
import Relation;

import languages::oberon0::ast::Oberon0;
import languages::oberon0::check::Types;

//
// Flag different namespaces for names.
//
data Namespace = UserNames() | Modules();
	
//
// Scope items, which represent either scope layers (created for modules and procedures)
// or named items (types, variables, procedures, etc).
//
data Item =
	  TopLayer()
	| Variable(Ident name, OType otype, loc definedAt)
	| Constant(Ident name, int val, loc definedAt)
	| Procedure(Ident name, list[Item] parameters, loc definedAt)
	| FormalParameter(Ident name, OType otype, bool isVar, loc definedAt)
	| Module(Ident name, loc definedAt)
	| Type(Ident name, OType otype, loc definedAt)
	| BuiltInProcedure(Ident name)
	| BuiltInType(Ident name)
	;
	
public str prettyPrint(Item i) {
	switch(i) {
		case Variable(n,t,_) : return "VAR <n.name> : <prettyPrint(t)>";
		case Constant(n,v,_) : return "CONST <n.name> = <v>";
		case FormalParameter(n,t,v,_) : return "";
		case Type(n,t,_) : return "TYPE <n.name> = <prettyPrint(t)>";
		case BuiltInProcedure(n) : return "PROC <n.name>";
		case BuiltInType(n) : return "TYPE <n.name>";
		
		case TopLayer() : return "TOP SCOPE";
		case Module(n,_) : return "MODULE <n.name>";
		case Procedure(n,pl,_) : return "PROCEDURE <n.name>(<prettyPrint(pl)>)";
	}
}

str prettyPrint(list[Item] il) {
	bool first = true;
	str res = "";
	for (FormalParameter(n,t,v,_) <- il) {
		res += "< first ? "" : "," ><v ? "VAR " : ""><n.name> : <prettyPrint(t)>";
		if (first) first = false;
	}
	return res;
}

public str dumpTable(SymbolTable st) {
	str dumpTableAux(Item currentScope, str spaces) {
		str res = "";
		set[Item] items = st[currentScope];
		for (item <- items) {
			if (getName(item) notin {"FormalParameter"}) res = res + "<spaces><prettyPrint(item)>\n";
			if (TopLayer() := item || Module(_,_) := item || Procedure(_,_,_) := item)
				res = res + dumpTableAux(item, spaces + "  ");
		}
		return res;
	}
	return dumpTableAux(TopLayer(), "  ");
}

public rel[Namespace,str] namespaceItems = { < UserNames(), "Variable" >, < UserNames(), "Constant" >,
	< UserNames(), "Procedure" >, < UserNames(), "FormalParameter" >, < UserNames(), "Type" >,
	< UserNames(), "BuiltInProcedure" >, < UserNames(), "BuiltInType" >, < Modules(), "Module" > };
	
//
// This is the final version of the symbol table, not including all
// the stuff that is needed to build it.
//
alias SymbolTable = rel[Item parent, Item child];

//
// General symbol table for Oberon0 programs.
// NOTE: This is still being developed, not sure what we need yet...
//
alias SymbolTableBuilder = tuple[    
    SymbolTable symbolTable,
    rel[Item parent, Ident name, Item child] scopeNames,
    rel[Item usedItems, loc useLoc] itemUses, 
    rel[loc, str] scopeErrors, 
    list[Item] scopeStack
	];

//	
// Create an empty symbol table
//                        
public SymbolTableBuilder createNewSymbolTableBuilder() {
	return < { }, { }, { }, { }, [ TopLayer() ] >;
}                    
	
//
// Push an item onto the scope stack
//
public SymbolTableBuilder pushScope(SymbolTableBuilder stBuilder, Item item) {
	stBuilder.scopeStack = [ item ] + stBuilder.scopeStack;
	return stBuilder;
}

//
// Pop the scope stack
//
public SymbolTableBuilder popScope(SymbolTableBuilder stBuilder) {
	if (size(stBuilder.scopeStack) == 0) throw "popScope: Scope Stack is empty, cannot pop!";
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
// Add a new module
//
public SymbolTableBuilder pushNewModuleScope(SymbolTableBuilder stBuilder, Ident name, loc l) {
	if (TopLayer() !:= stBuilder.scopeStack[0]) 
		throw "Modules cannot be added inside another scope!";
	
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
// Push a new procedure scope located inside a module or procedure
//
public SymbolTableBuilder pushNewProcedureScope(SymbolTableBuilder stBuilder, Ident name, list[Formal] formals, map[Ident,OType] otypes, loc l) {
	if (Module(_,_) !:= stBuilder.scopeStack[0] && Procedure(_,_,_) !:= stBuilder.scopeStack[0]) 
		throw "Procedures can only be added into modules or other procedures.";
		
	// Create the items for the parameters
	// NOTE: We don't bother checking for type errors here, but assume instead that those are checked
	// in the caller.
	params = for(f:formal(hasv,ids,ty) <- formals, pid <- ids) {
		Item paramItem = FormalParameter(pid,otypes[pid],hasv,f@location);
		append(paramItem);
		stBuilder.itemUses = stBuilder.itemUses + < paramItem, pid@location >;
	}
	
	// Create the items representing the named entity (procedure) and the scope		 
	Item pi = Procedure(name, params, l);
	
	// Wire the new procedure into the scope structure. Note that we add the procedure name into the visible
	// names for both the current scope and the procedure's scope, since the procedure name is visible within
	// the procedure iteself. 
	stBuilder.symbolTable = stBuilder.symbolTable + < stBuilder.scopeStack[0], pi > + { <pi, p> | p <- params };
	stBuilder.scopeNames = stBuilder.scopeNames + < stBuilder.scopeStack[0], pi.name, pi > + < pi, pi.name, pi > + { <pi,p.name,p> | p <- params };
	stBuilder.itemUses = stBuilder.itemUses + < pi, name@location >;
	stBuilder = pushScope(stBuilder, pi);

	return stBuilder;	
}

//
// Add a new variable into the scope
//
public SymbolTableBuilder addVariable(SymbolTableBuilder stBuilder, Ident name, OType otype, loc l) {
	if (Module(_,_) !:= stBuilder.scopeStack[0] && Procedure(_,_,_) !:= stBuilder.scopeStack[0]) 
		throw "Variables can only be added into the scope of a module or procedure";

	// Create the item and add it into the scope
	return addNamedItem(stBuilder, Variable(name, otype, l), name@location);
}

//
// Add a new constant into the scope
//
public SymbolTableBuilder addConstant(SymbolTableBuilder stBuilder, Ident name, int val, loc l) {
	if (Module(_,_) !:= stBuilder.scopeStack[0] && Procedure(_,_,_) !:= stBuilder.scopeStack[0]) 
		throw "Named constants can only be added into the scope of a module or procedure";

	// Create the item and add it into the scope
	return addNamedItem(stBuilder, Constant(name, val, l), name@location);
}

//
// Add a new type into the scope
//
public SymbolTableBuilder addType(SymbolTableBuilder stBuilder, Ident name, OType otype, loc l) {
	if (Module(_,_) !:= stBuilder.scopeStack[0] && Procedure(_,_,_) !:= stBuilder.scopeStack[0]) 
		throw "Named types can only be added into the scope of a module or procedure";

	// Create the item and add it into the scope		 
	return addNamedItem(stBuilder, Type(name, otype, l), name@location);
}

//
// Add a new built-in procedure into the scope
//
public SymbolTableBuilder addBuiltInProcedure(SymbolTableBuilder stBuilder, Ident name) {
	return addNamedBuiltIn(stBuilder, BuiltInProcedure(name));
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
	set[Item] foundItems = { i | i <- stBuilder.scopeNames[startingScope,name], getName(i) in namespaceItems[ns] };
	if (size(foundItems) == 0 && TopLayer() !:= startingScope)
		return getItems(stBuilder,getOneFrom(invert(stBuilder.symbolTable)[startingScope]),name,ns); 	
	return foundItems;
}

public set[Item] lookupItems(SymbolTableBuilder stBuilder, Ident name) {
	return { i | i <- getItems(stBuilder, stBuilder.scopeStack[0], name, UserNames()), getName(i) in {"Variable","Constant","Procedure","BuiltInProcedure","FormalParameter"} };
}

public set[Item] getVariables(SymbolTableBuilder stBuilder, Ident name) {
	return { i | i <- getItems(stBuilder, stBuilder.scopeStack[0], name, UserNames()), getName(i) == "Variable" };
}

public set[Item] getConstants(SymbolTableBuilder stBuilder, Ident name) {
	return { i | i <- getItems(stBuilder, stBuilder.scopeStack[0], name, UserNames()), getName(i) == "Constant" };
}

public set[Item] getProcedures(SymbolTableBuilder stBuilder, Ident name) {
	return { i | i <- getItems(stBuilder, stBuilder.scopeStack[0], name, UserNames()), getName(i) == "Procedure" || getName(i) == "BuiltInProcedure" };
}

public set[Item] getTypes(SymbolTableBuilder stBuilder, Ident name) {
	return { i | i <- getItems(stBuilder, stBuilder.scopeStack[0], name, UserNames()), getName(i) == "Type" || getName(i) == "BuiltInType"};
}

public set[Item] getParameters(SymbolTableBuilder stBuilder, Ident name) {
	return { i | i <- getItems(stBuilder, stBuilder.scopeStack[0], name, UserNames()), getName(i) == "FormalParameter" };
}

public set[Item] getModules(SymbolTableBuilder stBuilder, Ident name) {
	return { i | i <- getItems(stBuilder, stBuilder.scopeStack[0], name, Modules()), getName(i) == "Module" };
}
