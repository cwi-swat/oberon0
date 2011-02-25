module languages::oberon0::resolve::ResolveNames

import IO;
import List;
import Set;
import Node;

import languages::oberon0::ast::Oberon0;
import languages::oberon0::check::Types;
import languages::oberon0::resolve::SymbolTable;
import languages::oberon0::resolve::ConstantEvaluator;
import languages::oberon0::resolve::TypeEvaluator;

//
// TODO: Check in which cases we should verify that a given name is not a duplicate of
// an existing predefined name (INTEGER, etc)
//

//
// Selectors are either fields (for records) or subscripts (for arrays).
// Array selectors are expressions, so we recurse. We do nothing with
// the fields, since we need to know the type of the var being selected
// against to know whether the name is in scope or not.
//
public SymbolTableBuilder resolveSelectorNames(SymbolTableBuilder stBuilder, Selector sel) {
	switch(sel) {
		case field(fid) : return stBuilder;
		case subscript(e) : return resolveExpressionNames(stBuilder,e);
	}
	throw "resolveNames: Unhandled selector <sel> at <sel@location>";
}

//
// Variables are used in expressions (names in lookups) and in statements
// (assignments and calls). We need to check that the name is in scope as
// well as process any selectors.
//
public SymbolTableBuilder resolveVariableNames(SymbolTableBuilder stBuilder, Ident name, list[Selector] selectors) {
	set[Item] vars = lookupItems(stBuilder, name);
	if (size(vars) > 0) {
		for (v <- vars) stBuilder.itemUses = stBuilder.itemUses + <v, name@location>;
	} else {
		stBuilder = addScopeError(stBuilder, name@location, "<name.name> not defined before use");
	}
	for (sel <- selectors) stBuilder = resolveSelectorNames(stBuilder,sel);
	return stBuilder;
}

//
// Expressions are handled mainly by picking them apart and recursively handling
// the pieces. The cases that differ are for natural numbers, where we do nothing,
// and for name lookups, where we need to handle the variable given in the lookup
// (which may or may not have selectors). This logic is contained in
// resolveVariableNames, not here.
//
public SymbolTableBuilder resolveExpressionNames(SymbolTableBuilder stBuilder, Expression exp) {
	switch(exp) {
		case nat(_) : return stBuilder;
		case lookup(v,sl) : return resolveVariableNames(stBuilder,v,sl);
		case neg(e) : return resolveExpressionNames(stBuilder,e);
		case pos(e) : return resolveExpressionNames(stBuilder,e);
		case not(e) : return resolveExpressionNames(stBuilder,e);
		case mul(l,r) : return resolveExpressionNames(resolveExpressionNames(stBuilder,l),r);
		case div(l,r) : return resolveExpressionNames(resolveExpressionNames(stBuilder,l),r);
		case mod(l,r) : return resolveExpressionNames(resolveExpressionNames(stBuilder,l),r);
		case amp(l,r) : return resolveExpressionNames(resolveExpressionNames(stBuilder,l),r);
		case add(l,r) : return resolveExpressionNames(resolveExpressionNames(stBuilder,l),r);
		case sub(l,r) : return resolveExpressionNames(resolveExpressionNames(stBuilder,l),r);
		case or(l,r) : return resolveExpressionNames(resolveExpressionNames(stBuilder,l),r);
		case eq(l,r) : return resolveExpressionNames(resolveExpressionNames(stBuilder,l),r);
		case neq(l,r) : return resolveExpressionNames(resolveExpressionNames(stBuilder,l),r);
		case lt(l,r) : return resolveExpressionNames(resolveExpressionNames(stBuilder,l),r);
		case gt(l,r) : return resolveExpressionNames(resolveExpressionNames(stBuilder,l),r);
		case leq(l,r) : return resolveExpressionNames(resolveExpressionNames(stBuilder,l),r);
		case geq(l,r) : return resolveExpressionNames(resolveExpressionNames(stBuilder,l),r);
	}
		
	throw "resolveNames: Unhandled expression <exp> at location <exp@location>";
}

//
// A version of the above which handles lists of expressions. Lists are processed
// in a left-to-right ordering.
//
public SymbolTableBuilder resolveExpressionNames(SymbolTableBuilder stBuilder, list[Expression] exps) {
	for (exp <- exps) stBuilder = resolveExpressionNames(stBuilder, exp);
	return stBuilder;
}

//
// Resolve names in statements. Both the assignment and the call statement contain
// variables. Note that, in Oberon-0, the if and the while do not start a new
// scope, so we can handle the bodies without worrying about creating a new
// scope in the symbol table, dealing with shadowing, etc.
//
public SymbolTableBuilder resolveStatementNames(SymbolTableBuilder stBuilder, Statement stmt) {
	switch(stmt) {
		case assign(v,sl,e) : return resolveVariableNames(resolveExpressionNames(stBuilder,e),v,sl);
		case call(v,es) : return resolveVariableNames(resolveExpressionNames(stBuilder,es),v,[]);
		case ifThen(e,bs,eifs,ep) : {
			stBuilder = resolveStatementNames(resolveExpressionNames(stBuilder,e),bs);
			for (<e2,bs2> <- eifs) stBuilder = resolveStatementNames(resolveExpressionNames(stBuilder,e2),bs2);
			return resolveStatementNames(stBuilder,ep);
		}
		case whileDo(e,bs) : return resolveStatementNames(resolveExpressionNames(stBuilder,e),bs);
	}
	
	throw "resolveNames: Unhandled statement <stmt> at location <stmt@location>";
}

//
// Handle lists of statements (such as are found in if bodies). These are processed in a left
// to right (or, as on the page, top to bottom) order.
//
public SymbolTableBuilder resolveStatementNames(SymbolTableBuilder stBuilder, list[Statement] stmts) {
	for (stmt <- stmts) stBuilder = resolveStatementNames(stBuilder, stmt);
	return stBuilder;
}

//
// Resolve names in types. Note that the type declaration is a separate
// syntactic strucure, so we expect type names used here to be already
// defined. Types appear in fields, formal parameters, variable declarations, 
// and type declarations.
//
public SymbolTableBuilder resolveTypeNames(SymbolTableBuilder stBuilder, Type t) {
	// Named types, including built-in types.	
	if (user(name) := t) {
		set[Item] types = getTypes(stBuilder, name);
		if (size(types) > 0) {
			for (ty <- types) stBuilder.itemUses = stBuilder.itemUses + <ty, name@location>;
			return stBuilder;
		} else {
			return addScopeError(stBuilder, name@location, "Type <name.name> not defined before use");
		}
	}
	
	// Array types. This includes both an array index expression and the array type.
	// We need to check two things here -- first, we need to resolve any names in the
	// type, and second, we need to resolve names in the index expression AND make sure
	// that it is an evaluatable constant, since Oberon-0 requires this value to
	// be computable at compile time. This combination of resolving and computing is
	// done using evaluateConstantExp, which is why we don't use resolveExpressionNames
	// here instead.			
	if (array(e,ty) := t) {
		stBuilder = resolveTypeNames(stBuilder,ty);
		< stBuilder, evalResult, evalValue > = evaluateConstantExp(stBuilder,e);
		if (evalResult && evalValue < 1)
			stBuilder = addScopeError(stBuilder, t@location, "type invalid, array size must be larger than 0");
		return stBuilder;
	}
	
	// Record types. We need to resolve names in the types of the fields, but
	// otherwise do nothing here.	
	if (record(fs) := t) return resolveFieldNames(stBuilder,fs);

	throw "resolveNames: Unhandled type <t> at location <t@location>";
}

//
// For fields, we resolve the names in the field type, which should only
// use already-declared names. We do NOT resolve the names in the IDs,
// since they can be arbitrary, and they aren't visible in scope unless
// we access them through a field dereference of a record variable (in
// other words, if we have field f, we never want to return a field item
// when we see f, we only check it when we see r.f, r[0].f, etc).
//
public SymbolTableBuilder resolveFieldNames(SymbolTableBuilder stBuilder, Field f) {
	if (field(ids,ty) := f) return resolveTypeNames(stBuilder,ty);
	throw "resolveNames: Unhandled field <f> at location <f@location>";
}

//
// Handle lists of fields, as found in record type declarations.
//
public SymbolTableBuilder resolveFieldNames(SymbolTableBuilder stBuilder, list[Field] fs) {
	for (f <- fs) stBuilder = resolveFieldNames(stBuilder,f);
	return stBuilder;
}

//
// Resolve names in procedure declarations. We need to ensure that the procedure name
// is new (in this level of scope), add items for the procedure and its parameters,
// then process the procedure declarations and body. We also do some checking to ensure
// the procedure name and the end name are the same.
//
public SymbolTableBuilder resolveProcedureNames(SymbolTableBuilder stBuilder, Procedure pr) {
	if (proc(pid,fs,ds,bs,eid) := pr) {
		// Find any conflicting items -- these are items in the same namespace as procedure names
		// defined at either this level or at the top level (for builtins)
		set[Item] conflicts = { x | x <- stBuilder.scopeNames[stBuilder.scopeStack[0],pid], getName(x) in namespaceItems[UserNames()] } + 
							  { x | x <- stBuilder.scopeNames[stBuilder.scopeStack[size(stBuilder.scopeStack)-1],pid], getName(x) in namespaceItems[UserNames()] };
		if (size(conflicts) > 0)
			stBuilder = addScopeError(stBuilder, pid@location, "A variable, constant, parameter, or procedure with name <pid.name> is already defined in the current scope");

		// Next, check the parameters. We want to make sure here that the types are fine and
		// that we don't have name collisions between the parameters and the procedure name.
		// We will not add them into scope yet, this instead occurs once we know they are
		// all fine and we push the procedure scope.
		set[Ident] foundIds = { pid };
		list[Formal] validFormals = [ ];
		map[Ident,OType] otypes = ( );
		for (f:formal(hasv,ids,ty) <- fs) {
			stBuilder = resolveTypeNames(stBuilder, ty);
			<stBuilder, cres, ot> = otype(stBuilder, ty); 
			for (fpid <- ids) {
				if (fpid in foundIds) {
					if (fpid.name == pid.name)
						stBuilder = addScopeError(stBuilder, fpid@location, "Parameter names cannot be the same as the name of the procedure");
					else
						stBuilder = addScopeError(stBuilder, fpid@location, "All parameters must have distinct names");
				} else {
					foundIds = foundIds + fpid;
					validFormals = validFormals + formal(hasv,[fpid],ty)[@location = f@location];
					otypes = otypes + ( fpid : ot );
				}
			}			
		}
		
		// Now, add the procedure into scope. Two items of note. First, if we had a conflict with the name, just
		// add the name as __INVALID, which is not a valid Oberon-0 identifier. Second, we pass the validFormals
		// list instead of the formals that came in. This includes only those formals that did not collide
		// with either the name of the procedure or the names of the other formals.
		stBuilder = pushNewProcedureScope(stBuilder, size(conflicts)>0 ? id("__INVALID") : pid, validFormals, otypes, pr@location);
				
		// Next, process all declarations before the procedure body
		stBuilder = resolveDeclarationNames(stBuilder, ds);
		
		// Then, process the procedure body
		stBuilder = resolveStatementNames(stBuilder, bs);
		
		// Sanity check, ensure the final name is the same as the procedure name
		if (pid.name != eid.name) {
			stBuilder = addScopeError(stBuilder,pr@location,"The procedure name <pid.name> and the procedure end name <eid.name> do not match");
		} else {
			stBuilder.itemUses = stBuilder.itemUses + < stBuilder.scopeStack[0], eid@location>;
		}
		
		// Finally, pop the scope and return
		return popScope(stBuilder);
	}
	
	throw "resolveNames: Unhandled procedure <pr> at location <proc@location>";
}

//
// Handle lists of procedures from top to bottom, as found in the procedure declarations
// section of a module or another procedure.
//
public SymbolTableBuilder resolveProcedureNames(SymbolTableBuilder stBuilder, list[Procedure] procs) {
	for (pr <- procs) stBuilder = resolveProcedureNames(stBuilder,pr);
	return stBuilder;
}

//
// Process the declarations section of a module or procedure. This just involves
// processing the sub-sections: constants, types, variables, and procedures.
//
public SymbolTableBuilder resolveDeclarationNames(SymbolTableBuilder stBuilder, Declarations d) {
	if (decls(cds, ts, vs, ps) := d) {
		stBuilder = resolveConstDeclNames(stBuilder, cds);
		stBuilder = resolveTypeDeclNames(stBuilder, ts);
		stBuilder = resolveVarDeclNames(stBuilder, vs);
		stBuilder = resolveProcedureNames(stBuilder, ps);
		return stBuilder;
	}
	throw "resolveNames: Unhandled declarations <d> at location <d@location>";
}

//
// Process constant declarations. We need to ensure that the name is
// not already defined in this scope, and we also need to ensure that
// the defining expression is really a constant expression returning
// an INTEGER result.
//
public SymbolTableBuilder resolveConstDeclNames(SymbolTableBuilder stBuilder, ConstDecl cd) {
	if (constDecl(cid,val) := cd) {
		// Make sure we evaluate the constant expression before we add the constant
		// to scope, definitions cannot be recursive (i.e., a constant cannot be
		// defined in terms of itself).
		< stBuilder, evalResult, evalValue > = evaluateConstantExp(stBuilder,val);

		if (!evalResult) evalValue = 0; // the eval proc will have flagged the errors, just provide a default value here
		
		// Find any conflicting items -- these are items in the same namespace as constant names
		// defined at either this level or at the top level (for builtins)
		set[Item] conflicts = { x | x <- stBuilder.scopeNames[stBuilder.scopeStack[0],cid], getName(x) in namespaceItems[UserNames()] } + 
							  { x | x <- stBuilder.scopeNames[stBuilder.scopeStack[size(stBuilder.scopeStack)-1],cid], getName(x) in namespaceItems[UserNames()] };
		if (size(conflicts) > 0)
			stBuilder = addScopeError(stBuilder, cid@location, "A variable, constant, parameter, or procedure with name <cid.name> is already defined in the current scope");
		else
			stBuilder = addConstant(stBuilder,cid,evalValue,cd@location);

		return stBuilder;
	}

	throw "resolveNames: Unhandled constant declaration <cd> at location <cd@location>";
}

//
// Handles constants in a top to bottom ordering.
//
public SymbolTableBuilder resolveConstDeclNames(SymbolTableBuilder stBuilder, list[ConstDecl] cds) {
	for (cd <- cds) stBuilder = resolveConstDeclNames(stBuilder, cd);
	return stBuilder;
}

//
// Process type definitions. In error cases, these are given an
// undefined type. This allows us to progress (we would get spurious
// errors if we didn't add the type into the scope) without inadvertently
// allowing broken programs to type.
//
public SymbolTableBuilder resolveTypeDeclNames(SymbolTableBuilder stBuilder, TypeDecl td) {
	if (typeDecl(tid,ty) := td) {
		// Make sure we evaluate the type expression on the right before we add
		// the type name to scope, definitions cannot be recursive
		stBuilder = resolveTypeNames(stBuilder,ty);
		<stBuilder, cres, ot> = otype(stBuilder, ty); // NOTE: ot may be Invalid()

		// Find any conflicting items -- these are items in the same namespace as type names
		// defined at either this level or at the top level (for builtins)
		set[Item] conflicts = { x | x <- stBuilder.scopeNames[stBuilder.scopeStack[0],tid], getName(x) in namespaceItems[UserNames()] } + 
							  { x | x <- stBuilder.scopeNames[stBuilder.scopeStack[size(stBuilder.scopeStack)-1],tid], getName(x) in namespaceItems[UserNames()] };
		if (size(conflicts) > 0)
			stBuilder = addScopeError(stBuilder, tid@location, "A variable, constant, parameter, or procedure with name <tid.name> is already defined in the current scope");
		else
			stBuilder = addType(stBuilder,tid,ot,td@location);
		
		return stBuilder;
	}
	throw "resolveNames: Unhandled type declaration <td> at location <td@location>";
}

//
// Process lists of type declarations in top to bottom textual order. This enforces
// the default scoping rule of Oberon-0, which enforces scope in the textual order
// of the program.
//
public SymbolTableBuilder resolveTypeDeclNames(SymbolTableBuilder stBuilder, list[TypeDecl] tds) {
	for (td <- tds) stBuilder = resolveTypeDeclNames(stBuilder,td);
	return stBuilder;
}

//
// Process variable names.
//
public SymbolTableBuilder resolveVarDeclNames(SymbolTableBuilder stBuilder, VarDecl vd) {
	if (varDecl(ids,ty) := vd) {
		// NOTE: Check the type first, in case the variable shadows a constant used
		// in the type declaration.
		stBuilder = resolveTypeNames(stBuilder,ty);

		// Now actually get the computed type back. ot could be Invalid() in cases where
		// the type cannot be computed.
		<stBuilder, cres, ot> = otype(stBuilder, ty);
		
		// For each id in the var decl, we add a new variable item into the symbol table.
		// Note that we need to check for conflicts here as well, since we cannot define
		// the same name more than once in the same scope. If we do have conflicts,
		// we do NOT add a new item for this variable.
		for (vid <- ids) {
			set[Item] conflicts = { x | x <- stBuilder.scopeNames[stBuilder.scopeStack[0],vid], getName(x) in namespaceItems[UserNames()] } + 
								  { x | x <- stBuilder.scopeNames[stBuilder.scopeStack[size(stBuilder.scopeStack)-1],vid], getName(x) in namespaceItems[UserNames()] };
			if (size(conflicts) > 0)
				stBuilder = addScopeError(stBuilder, vid@location, "A variable, constant, parameter, or procedure with name <vid.name> is already defined in the current scope");
			else
				stBuilder = addVariable(stBuilder,vid,ot,vd@location);
		}

		return stBuilder;
	}
	throw "resolveNames: Unhandled variable declaration <vd> at location <vd@location>";
}

//
// Process variable declarations in top to down (lexical) order.
//
public SymbolTableBuilder resolveVarDeclNames(SymbolTableBuilder stBuilder, list[VarDecl] vds) {
	for (vd <- vds) stBuilder = resolveVarDeclNames(stBuilder,vd);
	return stBuilder;
}

//
// Resolve names for Oberon-0 Modules
//
public SymbolTableBuilder resolveModuleNames(SymbolTableBuilder stBuilder, Module m) {
	if (mod(mn, ds, bs, en) := m) {
		// First step -- add the new module into scope. This keeps open the possibility for
		// having multiple modules, but, as of the current version, this is a redundant check,
		// since we will never have more than one module at this point in time.
		set[Item] conflicts = { x | x <- stBuilder.scopeNames[stBuilder.scopeStack[0],mn], getName(x) in namespaceItems[Modules()] } + 
							  { x | x <- stBuilder.scopeNames[stBuilder.scopeStack[size(stBuilder.scopeStack)-1],mn], getName(x) in namespaceItems[Modules()] };
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

	throw "resolveNames: Unhandled module <m> at <m@location>";
}

@doc{Entry module for the name resolver, this will give back a symbol table builder representing the module passed in.}
public SymbolTableBuilder resolveNames(Module m) {
	SymbolTableBuilder stBuilder = createNewSymbolTableBuilder();
	
	// Add built-in names
	// TODO: Do we have more of these?
	stBuilder = addBuiltInProcedure(stBuilder,id("WriteLn"));
	stBuilder = addBuiltInProcedure(stBuilder,id("Write"));
	stBuilder = addBuiltInProcedure(stBuilder,id("ReadLn"));
	stBuilder = addBuiltInProcedure(stBuilder,id("Read"));
	
	// Add built-in types
	stBuilder = addBuiltInType(stBuilder,id("INTEGER"));
	
	stBuilder = resolveModuleNames(stBuilder, m);
	return stBuilder;
}