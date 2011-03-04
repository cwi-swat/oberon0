module lang::oberon0::l3::resolve::SymbolTable

import List;
import Set;
import String;
import Node;
import Relation;

import lang::oberon0::l1::ast::Oberon0;
import lang::oberon0::l3::ast::Oberon0;
import lang::oberon0::l1::resolve::Types;
import lang::oberon0::l1::resolve::SymbolTable;

data Item 
	= Procedure(Ident name, list[Item] parameters, loc definedAt)
	| FormalParameter(Ident name, OType otype, bool isVar, loc definedAt)
	| BuiltInProcedure(Ident name, list[tuple[OType paramType, bool isVar]] params)
	;
	
public str prettyPrint(Variable(n,t,_)) = "VAR <n.name> : <prettyPrint(t)>";
public str prettyPrint(Constant(n,v,_)) = "CONST <n.name> = <v>";
public str prettyPrint(Type(n,t,_)) = "TYPE <n.name> = <prettyPrint(t)>";
public str prettyPrint(BuiltInType(n)) = "TYPE <n.name>";
public str prettyPrint(Top()) = "TOP SCOPE";

public str prettyPrint(Procedure(n,pl, _)) = "PROCEDURE <n.name>(<prettyPrint(pl)>)";
public str prettyPrint(BuildInProcedure(n, _)) = "PROC <n.name>";
public str prettyPrint(FormalParameter(n, t, v, _)) = "";


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
			if (Top() := item || Module(_,_) := item || Procedure(_,_,_) := item)
				res = res + dumpTableAux(item, spaces + "  ");
		}
		return res;
	}
	return dumpTableAux(Top(), "  ");
}

//
// Push a new procedure scope located inside a module or procedure. Procedures also create a new scope.
// Note that we add all the parameters in as well, so they are visible if looked up in the scope.
//
public SymbolTableBuilder pushNewProcedureScope(SymbolTableBuilder stBuilder, Ident name, list[Formal] formals, map[Ident,OType] otypes, loc l) {
	if (Module(_,_) !:= stBuilder.scopeStack[0] && Procedure(_,_,_) !:= stBuilder.scopeStack[0]) 
		throw "Procedures can only be added into modules or other procedures.";
		
	// Create the items for the parameters. We assume that any errors with these (duplicate names, bad
	// types) are handled elsewhere, and that we can just add them here.
	params = for(f:formal(hasv,ids,ty) <- formals, pid <- ids) {
		Item paramItem = FormalParameter(pid,otypes[pid],hasv,f@location);
		append(paramItem);
		stBuilder.itemUses = stBuilder.itemUses + < paramItem, pid@location >;
	}
	
	// Create the item for the procedure, which also includes its parameters.		 
	Item pi = Procedure(name, params, l);
	
	// Wire the new procedure into the scope structure. Note that we add the procedure name into the visible
	// names for both the current scope and the procedure's scope, since the procedure name is visible within
	// the procedure itself as well as within the scope in which it is defined. 
	stBuilder.symbolTable = stBuilder.symbolTable + < stBuilder.scopeStack[0], pi > + { <pi, p> | p <- params };
	stBuilder.scopeNames = stBuilder.scopeNames + < stBuilder.scopeStack[0], pi.name, pi > + < pi, pi.name, pi > + { <pi,p.name,p> | p <- params };
	stBuilder.itemUses = stBuilder.itemUses + < pi, name@location >;
	stBuilder = pushScope(stBuilder, pi);

	return stBuilder;	
}

//
// Add a new built-in procedure into the scope
//
public SymbolTableBuilder addBuiltInProcedure(SymbolTableBuilder stBuilder, Ident name, list[tuple[OType paramType, bool isVar]] params) {
	return addNamedBuiltIn(stBuilder, BuiltInProcedure(name,params));
}

