module languages::oberon0::resolve::SymbolTable

import List;
import Set;
import String;

import languages::oberon0::ast::Oberon0;
import languages::oberon0::check::Types;

//
// Flag different namespaces for names.
//
// TODO: Do we have more than one?
//
data Namespace =
	  UserNames()
	| Modules()
	;
	
//
// Identifiers for scope items and layers
//
alias STItemId = int;

//
// Scope items and layers. It is easier to use one data type for both, since we can
// then put them into the same maps, etc.
//
data STItem =
	  VariableItem(Ident variableName, OType variableType, STItemId parentId)
	| ConstantItem(Ident constantName, int constantVal, STItemId parentId)
	| ProcedureItem(Ident procedureName, list[STItemId] parameters, STItemId parentId)
	| FormalParameterItem(Ident parameterName, OType parameterType, bool isVar, STItemId parentId)
	| ModuleItem(Ident moduleName, STItemId parentId)
	| TypeItem(Ident typeName, OType namedType, STItemId parentId)
	| BuiltInItem(Ident procedureName, STItemId parentId)
	| BuiltInType(Ident typeName, STItemId parentId)
	
	| TopLayer()
	| ModuleLayer(STItemId itemId, STItemId parentId)
	| ProcedureLayer(STItemId itemId, STItemId parentId)
	;

//
// Allows us to keep track of the location where the item was defined in the source
//	
anno loc STItem@at;

//
// Provide a generic way to get the (variable/procedure/etc) name for an item
//
public Ident getItemName(STItem item) {
	switch(item) {
		case VariableItem(n,_,_) : return n;
		case ConstantItem(n,_,_) : return n;
		case ProcedureItem(n,_,_) : return n;
		case FormalParameterItem(n,_,_,_) : return n;
		case ModuleItem(n,_) : return n;
		case TypeItem(n,_,_) : return n;
		case BuiltInItem(n,_) : return n;
		case BuiltInType(n,_) : return n;
	}
	
	throw "getItemName, unhandled case <item>";
}

//
// Provide a quick check to see if an item has a name. This leaves open the possibility
// for unnamed items (representing scopes inside blocks, for instance)
//
public bool itemHasName(STItem item) {
	switch(item) {
		case VariableItem(_,_,_) : return true;
		case ConstantItem(_,_,_) : return true;
		case ProcedureItem(_,_,_) : return true;
		case FormalParameterItem(_,_,_,_) : return true;
		case ModuleItem(_,_) : return true;
		case TypeItem(_,_,_) : return true;
		case BuiltInItem(_,_) : return true;
		case BuiltInType(_,_) : return true;
		
		default : return false;
	}
}

//
// Indicates if this is an item with a matching layer (like procedure items/layers)
//
public bool isLayerItem(STItem item) {
	switch(item) {
		case ProcedureItem(_,_,_) : return true;
		case ModuleItem(_,_) : return true;
		
		default : return false;
	}
}

//
// General symbol table for Oberon0 programs.
// NOTE: This is still being developed, not sure what we need yet...
//
alias SymbolTable = tuple[    
	STItemId topSTItemId,
    STItemId currentModule,	
    STItemId currentScope, 
    STItemId nextScopeId, 
    map[STItemId scopeId, STItem item] scopeItemMap, 
    rel[STItemId scopeId, STItemId itemId] scopeRel,
    rel[STItemId scopeId, Ident itemName, STItemId itemId] scopeNames,
    map[loc useLoc, set[STItemId] usedItems] itemUses, 
    rel[loc, STItemId] itemLocations, 
    map[loc, set[str]] scopeErrorMap, 
    list[STItemId] scopeStack
	];

//	
// Create an empty symbol table
//                        
public SymbolTable createNewSymbolTable() {
	return < -1, -1, -1, 0, ( ), { }, { }, ( ), { }, ( ), [ ] >;
}                    
	
alias AddedItemPair = tuple[SymbolTable symbolTable, STItemId addedId];
alias ScopeUpdatePair = tuple[SymbolTable symbolTable, STItemId oldScopeId];
alias ResultTuple = tuple[SymbolTable symbolTable, list[STItemId] addedItems];
	
//
// Add a new layer WITHOUT a parent into the scope.
//
public AddedItemPair addScopeLayer(SymbolTable symbolTable, STItem si, loc l) {
	symbolTable.scopeItemMap = symbolTable.scopeItemMap + ( symbolTable.nextScopeId : si );
	symbolTable.itemLocations = symbolTable.itemLocations + < l, symbolTable.nextScopeId >;	
	symbolTable.nextScopeId = symbolTable.nextScopeId + 1;
	return < symbolTable, symbolTable.nextScopeId-1 >;
}

//
// Add a new layer WITH a parent into the scope. 
//
public AddedItemPair addScopeLayerWithParent(SymbolTable symbolTable, STItem si, STItemId parentId, loc l) {
	symbolTable.scopeItemMap = symbolTable.scopeItemMap + ( symbolTable.nextScopeId : si );
	symbolTable.itemLocations = symbolTable.itemLocations + < l, symbolTable.nextScopeId >;	
	symbolTable.scopeRel = symbolTable.scopeRel + < parentId, symbolTable.nextScopeId >;
	symbolTable.nextScopeId = symbolTable.nextScopeId + 1;
	return < symbolTable, symbolTable.nextScopeId-1 >;
}

//
// Add a new symbol table item (NOT a layer) within a scope layer.
//
public AddedItemPair addSTItemWithParent(SymbolTable symbolTable, STItem si, STItemId parentId, loc l) {
	symbolTable.scopeRel = symbolTable.scopeRel + < parentId, symbolTable.nextScopeId >;
	symbolTable.scopeItemMap = symbolTable.scopeItemMap + ( symbolTable.nextScopeId : si );
	symbolTable.itemLocations = symbolTable.itemLocations + < l, symbolTable.nextScopeId >;
	if (itemHasName(si)) {
		if (isLayerItem(si)) {
			symbolTable.scopeNames = symbolTable.scopeNames + < symbolTable.scopeItemMap[parentId].parentId, getItemName(si), symbolTable.nextScopeId >;
		} else {
			symbolTable.scopeNames = symbolTable.scopeNames + < parentId, getItemName(si), symbolTable.nextScopeId >;		
		}
	}
	
	symbolTable.nextScopeId = symbolTable.nextScopeId + 1;
	return < symbolTable, symbolTable.nextScopeId-1 >;
}

//
// Push a new top scope
//
// NOTE: There should be only one of these. Should we check for that here?
//	
public ResultTuple pushNewTopScope(SymbolTable symbolTable, loc l) {
	AddedItemPair aipTop = addScopeLayer(symbolTable, TopLayer()[@at=l], l);
	symbolTable = aipTop.symbolTable[topSTItemId = aipTop.addedId];
	symbolTable.scopeStack = [ aipTop.addedId ] + symbolTable.scopeStack;
	symbolTable.currentScope = aipTop.addedId;

	return <symbolTable,[aipTop.addedId]>; 	
}

//
// Push a new module scope, which is always under the top scope
//
public ResultTuple pushNewModuleScope(SymbolTable symbolTable, Ident moduleName, loc l) {
	AddedItemPair aip = addScopeLayerWithParent(symbolTable, ModuleLayer(-1, symbolTable.currentScope)[@at=l], symbolTable.currentScope, l);
	aip.symbolTable.scopeStack = [ aip.addedId ] + aip.symbolTable.scopeStack;
	aip.symbolTable.currentScope = aip.addedId;

	AddedItemPair aip2 = addSTItemWithParent(aip.symbolTable, ModuleItem(moduleName, aip.symbolTable.currentScope)[@at=l], aip.symbolTable.currentScope, l);
	aip2.symbolTable.scopeItemMap[aip.addedId].itemId = aip2.addedId;
	
	return <aip2.symbolTable,[aip.addedId,aip2.addedId]>; 	
}

//
// Pop the scope stack
//
public SymbolTable popScope(SymbolTable symbolTable) {
	if (size(symbolTable.scopeStack) == 0) throw "popScope: Scope Stack is empty, cannot pop!";
	symbolTable.scopeStack = tail(symbolTable.scopeStack);
	symbolTable.currentScope = head(symbolTable.scopeStack);
	return symbolTable;
}

//
// Push an arbitrary scope onto the scope stack
//
public SymbolTable pushScope(SymbolTable symbolTable, STItemId newScope) {
	symbolTable.scopeStack = [ newScope ] + symbolTable.scopeStack;
	symbolTable.currentScope = newScope;
	return symbolTable;
}

//
// Push a new procedure scope located inside an arbitrary scope
//
public ResultTuple pushNewProcedureScopeAt(SymbolTable symbolTable, Ident name, list[tuple[Ident pname, OType ptype, loc ploc, loc nloc, bool isvar]] params, loc l, STItemId scopeToUse) {
	// Create the procedure layer, adding it to the scope stack and making it the current scope
	AddedItemPair aipLayer = addScopeLayerWithParent(symbolTable, ProcedureLayer(-1, scopeToUse)[@at=l], scopeToUse, l);
	aipLayer.symbolTable.scopeStack = [ aipLayer.addedId ] + aipLayer.symbolTable.scopeStack;
	aipLayer.symbolTable.currentScope = aipLayer.addedId;

	// Create scope items for each of the parameters
	symbolTable = aipLayer.symbolTable;
	list[STItemId] paramIds = [ ];
	set[Ident] namesSeen = { name };
	for (tuple[Ident pname, OType ptype, loc ploc, loc nloc, bool isvar] pt <- params) {
		if (pt.pname in namesSeen) {
			symbolTable = addScopeError(symbolTable, pt.nloc, "Illegal redefinition of <pt.pname.name>. Parameter names must be different from other parameter names and from the name of the function.");
		}
		namesSeen += pt.pname;
		AddedItemPair aipParam = addSTItemWithParent(symbolTable, FormalParameterItem(pt.pname, pt.ptype, pt.isvar, symbolTable.currentScope)[@at=pt.ploc], symbolTable.currentScope, pt.ploc);
		paramIds += aipParam.addedId; symbolTable = aipParam.symbolTable;
	}

	// Add the actual procedure item associated with the scope layer
	AddedItemPair aipItem = addSTItemWithParent(symbolTable, ProcedureItem(name, paramIds, symbolTable.currentScope)[@at=l], symbolTable.currentScope, l);
	aipItem.symbolTable.scopeItemMap[aipLayer.addedId].itemId = aipItem.addedId;
	
	return <aipItem.symbolTable,[aipLayer.addedId] + [aipItem.addedId] + paramIds>;
}

//
// Push a new procedure scope inside the current scope
//
public ResultTuple pushNewProcedureScope(SymbolTable symbolTable, Ident name, list[tuple[Ident pname, OType ptype, loc ploc, loc nloc, bool isvar]] params, loc l) {
	return pushNewProcedureScopeAt(symbolTable, name, params, l, symbolTable.currentScope);
}

//
// Add a new variable item into an arbitrary scope
//
public ResultTuple addVariableToScopeAt(SymbolTable symbolTable, Ident varName, OType varType, loc l, STItemId scopeToUse) {
	AddedItemPair aip = addSTItemWithParent(symbolTable, VariableItem(varName, varType, scopeToUse)[@at=l], scopeToUse, l);
	return <aip.symbolTable,[aip.addedId]>;
}

//
// Add a new variable item into the current scope
//
public ResultTuple addVariableToScope(SymbolTable symbolTable, Ident varName, OType varType, loc l) {
	return addVariableToScopeAt(symbolTable, varName, varType, l, symbolTable.currentScope);
}

//
// Add a new constant item into an arbitrary scope
//
public ResultTuple addConstantToScopeAt(SymbolTable symbolTable, Ident constName, int constVal, loc l, STItemId scopeToUse) {
	AddedItemPair aip = addSTItemWithParent(symbolTable, ConstantItem(constName, constVal, scopeToUse)[@at=l], scopeToUse, l);
	return <aip.symbolTable,[aip.addedId]>;
}

//
// Add a new constant item into the current scope
//
public ResultTuple addConstantToScope(SymbolTable symbolTable, Ident constName, int constVal, loc l) {
	return addConstantToScopeAt(symbolTable, constName, constVal, l, symbolTable.currentScope);
}

//
// Add a new type item into an arbitrary scope
//
public ResultTuple addTypeToScopeAt(SymbolTable symbolTable, Ident typeName, OType namedType, loc l, STItemId scopeToUse) {
	AddedItemPair aip = addSTItemWithParent(symbolTable, TypeItem(typeName, namedType, scopeToUse)[@at=l], scopeToUse, l);
	return <aip.symbolTable,[aip.addedId]>;
}

//
// Add a new type item into the current scope
//
public ResultTuple addTypeToScope(SymbolTable symbolTable, Ident typeName, OType namedType, loc l) {
	return addTypeToScopeAt(symbolTable, typeName, namedType, l, symbolTable.currentScope);
}

//
// Add a new built-in item into an arbitrary scope
//
public ResultTuple addBuiltInItemToScopeAt(SymbolTable symbolTable, Ident builtInName, STItemId scopeToUse) {
	loc l = |file://dev/null|;
	
	AddedItemPair aip = addSTItemWithParent(symbolTable, BuiltInItem(builtInName, scopeToUse)[@at=l], scopeToUse, l);
	return <aip.symbolTable,[aip.addedId]>;
}

//
// Add a new built-in item into the current scope
//
public ResultTuple addBuiltInItemToScope(SymbolTable symbolTable, Ident builtInName) {
	return addBuiltInItemToScopeAt(symbolTable, builtInName, symbolTable.currentScope);
}

//
// Add a new built-in type into an arbitrary scope
//
public ResultTuple addBuiltInTypeToScopeAt(SymbolTable symbolTable, Ident builtInName, STItemId scopeToUse) {
	loc l = |file://dev/null|;
	
	AddedItemPair aip = addSTItemWithParent(symbolTable, BuiltInType(builtInName, scopeToUse)[@at=l], scopeToUse, l);
	return <aip.symbolTable,[aip.addedId]>;
}

//
// Add a new built-in type into the current scope
//
public ResultTuple addBuiltInTypeToScope(SymbolTable symbolTable, Ident builtInName) {
	return addBuiltInTypeToScopeAt(symbolTable, builtInName, symbolTable.currentScope);
}

//
// Extract just the symbol table from a result tuple
//
public SymbolTable justSymbolTable(ResultTuple result) {
	return result.symbolTable;
}

public ResultTuple setCurrentModule(ResultTuple result) {
	SymbolTable symbolTable = result.symbolTable;
	symbolTable.currentModule = result.addedItems[0];
	return <symbolTable, result.addedItems>;
}

public ResultTuple addSTItemUses(ResultTuple result, list[tuple[bool flagUse, loc useloc]] useLocs) {
	SymbolTable symbolTable = result.symbolTable;
	for (n <- [0..size(useLocs)-1]) if (useLocs[n].flagUse) symbolTable = addItemUse(symbolTable, result.addedItems[n], useLocs[n].useloc);
	return <symbolTable, result.addedItems>;
}

public SymbolTable addItemUse(SymbolTable symbolTable, STItemId scopeItem, loc l) {
	if (l in symbolTable.itemUses)
		symbolTable.itemUses[l] = symbolTable.itemUses[l] + scopeItem;
	else
		symbolTable.itemUses += (l : { scopeItem });
	return symbolTable;
}

public SymbolTable addItemUses(SymbolTable symbolTable, set[STItemId] scopeItems, loc l) {
	if (l in symbolTable.itemUses)
		symbolTable.itemUses[l] += scopeItems;
	else
		symbolTable.itemUses += (l : scopeItems );
	return symbolTable;
}

//
// Register scope-level errors (e.g., illegal repetitions of variable names)
//
public SymbolTable addScopeError(SymbolTable symbolTable, loc l, str msg) {
	if (l in symbolTable.scopeErrorMap)
		symbolTable.scopeErrorMap[l] = symbolTable.scopeErrorMap[l] + msg;
	else
		symbolTable.scopeErrorMap += (l : { msg } );
	return symbolTable;
}

public set[STItemId] filterNamesForNamespace(SymbolTable symbolTable, set[STItemId] scopeItems, Namespace namespace) {
	switch(namespace) {
		case UserNames() : 
			return { i | i <- scopeItems, si := symbolTable.scopeItemMap[i], VariableItem(_,_,_) := si ||
				ProcedureItem(_,_,_) := si || FormalParameterItem(_,_,_,_) := si || BuiltInItem(_,_) := si ||
				TypeItem(_,_,_) := si || ConstantItem(_,_,_) := si || BuiltInType(_,_) := si };
					
		case Modules() : 
			return { i | i <- scopeItems, si := symbolTable.scopeItemMap[i], ModuleItem(_,_) := si };
	}

	throw "Unmatched namespace in filterNamesForNamespace: <namespace>";
}

//
// Find the names visible at the current level of scoping. This provides a standard
// lookup based on nested scopes -- if the name is not found at the current level,
// the parent is tried until either the name is found or the top of the symbol
// table scope tree is reached.
//
public set[STItemId] getItemsForName(SymbolTable symbolTable, STItemId currentScopeId, Ident x, set[Namespace] containingNamespaces) {
	set[STItemId] foundItems = { };

	// Get back the items at this level with the given name
	foundItems += symbolTable.scopeNames[currentScopeId,x];

	// Now, filter it down based on the namespaces we are looking for
	foundItems = { f | ns <- containingNamespaces, f <- filterNamesForNamespace(symbolTable, foundItems, ns) };

	// If no names were found at this level, step back up one level to find them
	// in the parent scope. This will recurse until either the names are found
	// or the top level is reached. If this is a bounded search, don't pass through 
	// function and/or module boundaries.
	if (size(foundItems) == 0) {
		STItem cl = symbolTable.scopeItemMap[currentScopeId];
		if (TopLayer() !:= cl) {
			foundItems = getItemsForName(symbolTable,cl.parentId,x,containingNamespaces);
		}
	}

	// NOTE: This can be empty (for instance, when looking up a declaration of a variable that is not declared)	
	return foundItems;	
}

//
// These are specialized versions of the above function to make it easier to get back the
// right names.
//
public set[STItemId] getItemsForName(SymbolTable symbolTable, STItemId currentScopeId, Ident x) {
	return getItemsForName(symbolTable, currentScopeId, x, { UserNames() });
}

public set[STItemId] getItemsForName(SymbolTable symbolTable, Ident x) {
	return getItemsForName(symbolTable, symbolTable.currentScope, x, { UserNames() });
}
