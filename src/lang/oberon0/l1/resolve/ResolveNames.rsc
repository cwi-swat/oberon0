module lang::oberon0::l1::resolve::ResolveNames

import List;
import Set;
import Node;

import lang::oberon0::l1::ast::Oberon0;
import lang::oberon0::l1::resolve::Types;
import lang::oberon0::l1::resolve::SymbolTable;
import lang::oberon0::l1::resolve::ConstantEvaluator;
import lang::oberon0::l1::resolve::TypeEvaluator;

//
// Variables are used in expressions (names in lookups) and in statements
// (assignments and calls). We need to check that the name is in scope as
// well as process any selectors.
//
public SymbolTableBuilder resolveVariableNames(SymbolTableBuilder stBuilder, Ident name) {
	set[Item] vars = lookupItems(stBuilder, name);
	if (size(vars) == 1) {
		stBuilder.itemUses = stBuilder.itemUses + < getOneFrom(vars), name@location >;
	} else if (size(vars) > 1) {
		stBuilder = addScopeError(stBuilder, name@location, "<name.name> has multiple in-scope definitions");
	} else {
		stBuilder = addScopeError(stBuilder, name@location, "<name.name> not defined before use");
	}
	return stBuilder;
}

//
// Expressions are handled mainly by picking them apart and recursively handling
// the pieces. The cases that differ are for natural numbers, where we do nothing,
// and for name lookups, where we need to handle the variable given in the lookup
// (which may or may not have selectors). This logic is contained in
// resolveVariableNames, not here.
//
public SymbolTableBuilder resolveExpressionNames(SymbolTableBuilder stBuilder, nat(_)) = stBuilder;
public SymbolTableBuilder resolveExpressionNames(SymbolTableBuilder stBuilder, \true()) = stBuilder;
public SymbolTableBuilder resolveExpressionNames(SymbolTableBuilder stBuilder, \false()) = stBuilder;
public SymbolTableBuilder resolveExpressionNames(SymbolTableBuilder stBuilder, lookup(v)) = resolveVariableNames(stBuilder,v);
public SymbolTableBuilder resolveExpressionNames(SymbolTableBuilder stBuilder, neg(e)) = resolveExpressionNames(stBuilder,e);
public SymbolTableBuilder resolveExpressionNames(SymbolTableBuilder stBuilder, pos(e)) = resolveExpressionNames(stBuilder,e);
public SymbolTableBuilder resolveExpressionNames(SymbolTableBuilder stBuilder, not(e)) = resolveExpressionNames(stBuilder,e);
public SymbolTableBuilder resolveExpressionNames(SymbolTableBuilder stBuilder, mul(l,r)) = resolveExpressionNames(resolveExpressionNames(stBuilder,l),r);
public SymbolTableBuilder resolveExpressionNames(SymbolTableBuilder stBuilder, div(l,r)) = resolveExpressionNames(resolveExpressionNames(stBuilder,l),r);
public SymbolTableBuilder resolveExpressionNames(SymbolTableBuilder stBuilder, Expression::\mod(l,r)) = resolveExpressionNames(resolveExpressionNames(stBuilder,l),r);
public SymbolTableBuilder resolveExpressionNames(SymbolTableBuilder stBuilder, amp(l,r)) = resolveExpressionNames(resolveExpressionNames(stBuilder,l),r);
public SymbolTableBuilder resolveExpressionNames(SymbolTableBuilder stBuilder, add(l,r)) = resolveExpressionNames(resolveExpressionNames(stBuilder,l),r);
public SymbolTableBuilder resolveExpressionNames(SymbolTableBuilder stBuilder, sub(l,r)) = resolveExpressionNames(resolveExpressionNames(stBuilder,l),r);
public SymbolTableBuilder resolveExpressionNames(SymbolTableBuilder stBuilder, or(l,r)) = resolveExpressionNames(resolveExpressionNames(stBuilder,l),r);
public SymbolTableBuilder resolveExpressionNames(SymbolTableBuilder stBuilder, eq(l,r)) = resolveExpressionNames(resolveExpressionNames(stBuilder,l),r);
public SymbolTableBuilder resolveExpressionNames(SymbolTableBuilder stBuilder, neq(l,r)) = resolveExpressionNames(resolveExpressionNames(stBuilder,l),r);
public SymbolTableBuilder resolveExpressionNames(SymbolTableBuilder stBuilder, lt(l,r)) = resolveExpressionNames(resolveExpressionNames(stBuilder,l),r);
public SymbolTableBuilder resolveExpressionNames(SymbolTableBuilder stBuilder, gt(l,r)) = resolveExpressionNames(resolveExpressionNames(stBuilder,l),r);
public SymbolTableBuilder resolveExpressionNames(SymbolTableBuilder stBuilder, leq(l,r)) = resolveExpressionNames(resolveExpressionNames(stBuilder,l),r);
public SymbolTableBuilder resolveExpressionNames(SymbolTableBuilder stBuilder, geq(l,r)) =resolveExpressionNames(resolveExpressionNames(stBuilder,l),r);

//
// A version of the above which handles lists of expressions. Lists are processed
// in a left-to-right ordering.
//
public SymbolTableBuilder resolveExpressionNames(SymbolTableBuilder stBuilder, list[Expression] exps) {
	return (stBuilder | resolveExpressionNames(it, exp) | exp <- exps );
}

//
// Resolve names in statements. Both the assignment and the call statement contain
// variables. Note that, in Oberon-0, the if and the while do not start a new
// scope, so we can handle the bodies without worrying about creating a new
// scope in the symbol table, dealing with shadowing, etc.
//
public SymbolTableBuilder resolveStatementNames(SymbolTableBuilder stBuilder, assign(v, e)) = resolveVariableNames(resolveExpressionNames(stBuilder,e),v);

public SymbolTableBuilder resolveStatementNames(SymbolTableBuilder stBuilder, ifThen(e,bs,eifs,ep)) {
	stBuilder = resolveStatementNames(resolveExpressionNames(stBuilder,e),bs);
	stBuilder = ( stBuilder | resolveStatementNames(resolveExpressionNames(it,e2),bs2) | <e2,bs2> <- eifs ); 
	return resolveStatementNames(stBuilder,ep);
}

public SymbolTableBuilder resolveStatementNames(SymbolTableBuilder stBuilder, whileDo(e,bs)) = resolveStatementNames(resolveExpressionNames(stBuilder,e),bs);

//
// Handle lists of statements (such as are found in if bodies). These are processed in a left
// to right (or, as on the page, top to bottom) order.
//
public SymbolTableBuilder resolveStatementNames(SymbolTableBuilder stBuilder, list[Statement] stmts) {
	return ( stBuilder | resolveStatementNames(it, stmt) | stmt <- stmts );
}



//
// Process the declarations section of a module or procedure. This just involves
// processing the sub-sections: constants, types, variables, and procedures.
//
public SymbolTableBuilder resolveDeclarationNames(SymbolTableBuilder stBuilder, decls(cds, ts, vs)) {
	stBuilder = resolveConstDeclNames(stBuilder, cds);
	stBuilder = resolveTypeDeclNames(stBuilder, ts);
	stBuilder = resolveVarDeclNames(stBuilder, vs);
	return stBuilder;
}

//
// Process constant declarations. We need to ensure that the name is
// not already defined in this scope, and we also need to ensure that
// the defining expression is really a constant expression returning
// an INTEGER result.
//
public SymbolTableBuilder resolveConstDeclNames(SymbolTableBuilder stBuilder, cd:constDecl(cid, val)) {
	// Make sure we evaluate the constant expression before we add the constant
	// to scope, definitions cannot be recursive (i.e., a constant cannot be
	// defined in terms of itself).
	< stBuilder, evalResult, evalValue > = evaluateConstantExp(stBuilder,val);

	if (!evalResult) {
		evalValue = 0; // the eval proc will have flagged the errors, just provide a default value here
	}
	
	// Find any conflicting items -- these are items in the same namespace as constant names
	// defined at either this level or at the top level (for builtins)
	set[Item] conflicts = { x | x <- stBuilder.scopeNames[stBuilder.scopeStack[0],cid], Module(_,_) !:= x } + 
						  { x | x <- stBuilder.scopeNames[stBuilder.scopeStack[size(stBuilder.scopeStack)-1],cid], Module(_,_) !:= x };
	if (size(conflicts) > 0) {
		stBuilder = addScopeError(stBuilder, cid@location, "A variable, constant, parameter, or procedure with name <cid.name> is already defined in the current scope");
	}
	else {
		stBuilder = addConstant(stBuilder,cid,evalValue,cd@location);
	}

	return stBuilder;
}

//
// Handles constants in a top to bottom ordering.
//
public SymbolTableBuilder resolveConstDeclNames(SymbolTableBuilder stBuilder, list[ConstDecl] cds) {
	return (stBuilder | resolveConstDeclNames(it, cd) | cd <- cds );
}

//
// Process type definitions. In error cases, these are given an
// undefined type. This allows us to progress (we would get spurious
// errors if we didn't add the type into the scope) without inadvertently
// allowing broken programs to type.
//
public SymbolTableBuilder resolveTypeDeclNames(SymbolTableBuilder stBuilder, typeDecl(tid, ty)) {
	// Make sure we evaluate the type expression on the right before we add
	// the type name to scope, definitions cannot be recursive
	<stBuilder, cres, ot> = otype(stBuilder, ty); // NOTE: ot may be Invalid()

	// Find any conflicting items -- these are items in the same namespace as type names
	// defined at either this level or at the top level (for builtins)
	set[Item] conflicts = { x | x <- stBuilder.scopeNames[stBuilder.scopeStack[0],tid], Module(_,_) !:= x } + 
						  { x | x <- stBuilder.scopeNames[stBuilder.scopeStack[size(stBuilder.scopeStack)-1],tid], Module(_,_) !:= x };
	if (size(conflicts) > 0) {
		stBuilder = addScopeError(stBuilder, tid@location, "A variable, constant, parameter, or procedure with name <tid.name> is already defined in the current scope");
	}
	else {
		stBuilder = addType(stBuilder,tid,ot,tid@location);
	}
	
	return stBuilder;
}

//
// Process lists of type declarations in top to bottom textual order. This enforces
// the default scoping rule of Oberon-0, which enforces scope in the textual order
// of the program.
//
public SymbolTableBuilder resolveTypeDeclNames(SymbolTableBuilder stBuilder, list[TypeDecl] tds) {
	return ( stBuilder | resolveTypeDeclNames(it, td) | td <- tds );
}

//
// Process variable names.
//
public SymbolTableBuilder resolveVarDeclNames(SymbolTableBuilder stBuilder, vd:varDecl(ids, ty)) {
	// Get the computed type. ot could be Invalid() in cases where the type cannot be computed.
	<stBuilder, cres, ot> = otype(stBuilder, ty);
	
	// For each id in the var decl, we add a new variable item into the symbol table.
	// Note that we need to check for conflicts here as well, since we cannot define
	// the same name more than once in the same scope. If we do have conflicts,
	// we do NOT add a new item for this variable.
	for (vid <- ids) {
		set[Item] conflicts = { x | x <- stBuilder.scopeNames[stBuilder.scopeStack[0],vid], Module(_,_) !:= x } + 
							  { x | x <- stBuilder.scopeNames[stBuilder.scopeStack[size(stBuilder.scopeStack)-1],vid], Module(_,_) !:= x };
		if (size(conflicts) > 0) {
			stBuilder = addScopeError(stBuilder, vid@location, "A variable, constant, parameter, or procedure with name <vid.name> is already defined in the current scope");
		}
		else {
			stBuilder = addVariable(stBuilder,vid,ot,vd@location);
		}
	}

	return stBuilder;
}

//
// Process variable declarations in top to down (lexical) order.
//
public SymbolTableBuilder resolveVarDeclNames(SymbolTableBuilder stBuilder, list[VarDecl] vds) {
	return ( stBuilder | resolveVarDeclNames(it, vd) | vd <- vds );
}

//
// Resolve names for Oberon-0 Modules
//
public SymbolTableBuilder resolveModuleNames(SymbolTableBuilder stBuilder, m:Module::\mod(mn, ds, bs, en)) {
	// First step -- add the new module into scope. This keeps open the possibility for
	// having multiple modules, but, as of the current version, this is a redundant check,
	// since we will never have more than one module at this point in time.
	set[Item] conflicts = { x | x <- stBuilder.scopeNames[stBuilder.scopeStack[0],mn], Module(_,_) := x } + 
						  { x | x <- stBuilder.scopeNames[stBuilder.scopeStack[size(stBuilder.scopeStack)-1],mn], Module(_,_) := x };
	if (size(conflicts) > 0) {
		stBuilder = addScopeError(stBuilder, mn@location, "A module with name <mn.name> is already defined in the current scope");
		stBuilder = pushNewModuleScope(stBuilder, id("__INVALID"), m@location);
	} else {
		stBuilder = pushNewModuleScope(stBuilder, mn, m@location);
	}

	// Now process the module body
	stBuilder = resolveDeclarationNames(stBuilder, ds);
	stBuilder = resolveStatementNames(stBuilder, bs);
	
	// Finally, do a quick sanity check to make sure the begin and end names are identical.
	if (mn.name != en.name) {
		stBuilder = addScopeError(stBuilder,m@location,"The module name <mn.name> and the module end name <en.name> do not match");
	} else {
		stBuilder.itemUses = stBuilder.itemUses + < stBuilder.scopeStack[0], en@location>;
	}
	return popScope(stBuilder);
}

@doc{Entry module for the name resolver, this will give back a symbol table builder representing the module passed in.}
public SymbolTableBuilder resolveNames(Module m) {
	SymbolTableBuilder stBuilder = createNewSymbolTableBuilder();
		
	// Add built-in types
	stBuilder = addBuiltInType(stBuilder,id("INTEGER"),Integer());
	stBuilder = addBuiltInType(stBuilder,id("BOOLEAN"),Boolean());
	
	stBuilder = resolveModuleNames(stBuilder, m);
	return stBuilder;
}

public set[Item] lookupItems(SymbolTableBuilder stBuilder, Ident name) {
	return { i | i <- getItems(stBuilder, stBuilder.scopeStack[0], name, UserNames()), oberonVar(i) };
}


public bool oberonVar(Module(Ident name, loc definedAt)) = false;
public bool oberonVar(Type(Ident name, OType otype, loc definedAt)) = false;
public bool oberonVar(BuiltInType(Ident name)) = false;
public bool oberonVar(Item _) = true;

