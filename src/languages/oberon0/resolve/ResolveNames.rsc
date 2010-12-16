module languages::oberon0::resolve::ResolveNames

import IO;
import List;
import Set;

import languages::oberon0::ast::Oberon0;
import languages::oberon0::check::Types;
import languages::oberon0::resolve::SymbolTable;
import languages::oberon0::resolve::ConstantEvaluator;
import languages::oberon0::resolve::TypeEvaluator;

//
// Selectors are either fields (for records) or subscripts (for arrays).
// For fields, we don't check the name here, since we don't necessarily
// know the type of the value being accessed, or which (if any) fields
// it has. For subscripts, these can be arbitrary expressions, so we
// resolve the names present in the expression.
//
// TODO: Do we need a check here to ensure that reserved words are not
// used as field names? Or, does the parser currently handle this for us?
//
public SymbolTable resolveSelectorNames(SymbolTable symbolTable, Selector sel) {
	switch(sel) {
		case field(_) : return symbolTable;
		case subscript(e) : return resolveExpressionNames(symbolTable,e);
	}
	throw "resolveNames: Unhandled selector <sel> at <sel@location>";
}

//
// Variables are used in expressions (names in lookups) and in statements
// (assignments and calls). We need to check that the name is in scope as
// well as process any selectors.
//
// TODO: Do we need a check here to ensure that reserved words are not
// used as variable names? Or, does the parser currently handle this for us?
//
public SymbolTable resolveVariableNames(SymbolTable symbolTable, Variable v) {
	if (var(Ident name, list[Selector] selectors) := v) {
		if (size(getItemsForName(symbolTable, name)) > 0) {
			symbolTable = addItemUses(symbolTable, getItemsForName(symbolTable, name), name@location);
		} else {
			symbolTable = addScopeError(symbolTable, name@location, "<name.name> not defined before use");
		}
		for (sel <- selectors) symbolTable = resolveSelectorNames(symbolTable,sel);
		return symbolTable;
	}
		
	throw "resolveNames: Unhandled variable <v> at location <v@location>";
}

//
// Expressions are handled mainly by picking them apart and recursively handling
// the pieces. The cases that differ are for natural numbers, where we do nothing,
// and for name lookups, where we need to handle the variable given in the lookup
// (which may or may not have selectors). This logic is contained in
// resolveVariableNames, not here.
//
public SymbolTable resolveExpressionNames(SymbolTable symbolTable, Expression exp) {
	switch(exp) {
		case nat(_) : return symbolTable;
		case lookup(v) : return resolveVariableNames(symbolTable,v);
		case neg(e) : return resolveExpressionNames(symbolTable,e);
		case pos(e) : return resolveExpressionNames(symbolTable,e);
		case not(e) : return resolveExpressionNames(symbolTable,e);
		case mul(l,r) : return resolveExpressionNames(resolveExpressionNames(symbolTable,l),r);
		case div(l,r) : return resolveExpressionNames(resolveExpressionNames(symbolTable,l),r);
		case mod(l,r) : return resolveExpressionNames(resolveExpressionNames(symbolTable,l),r);
		case amp(l,r) : return resolveExpressionNames(resolveExpressionNames(symbolTable,l),r);
		case add(l,r) : return resolveExpressionNames(resolveExpressionNames(symbolTable,l),r);
		case sub(l,r) : return resolveExpressionNames(resolveExpressionNames(symbolTable,l),r);
		case or(l,r) : return resolveExpressionNames(resolveExpressionNames(symbolTable,l),r);
		case eq(l,r) : return resolveExpressionNames(resolveExpressionNames(symbolTable,l),r);
		case neq(l,r) : return resolveExpressionNames(resolveExpressionNames(symbolTable,l),r);
		case lt(l,r) : return resolveExpressionNames(resolveExpressionNames(symbolTable,l),r);
		case gt(l,r) : return resolveExpressionNames(resolveExpressionNames(symbolTable,l),r);
		case leq(l,r) : return resolveExpressionNames(resolveExpressionNames(symbolTable,l),r);
		case geq(l,r) : return resolveExpressionNames(resolveExpressionNames(symbolTable,l),r);
	}
		
	throw "resolveNames: Unhandled expression <exp> at location <exp@location>";
}

//
// A version of the above which handles lists of expressions. Lists are processed
// in a left-to-right ordering.
//
public SymbolTable resolveExpressionNames(SymbolTable symbolTable, list[Expression] exps) {
	for (exp <- exps) symbolTable = resolveExpressionNames(symbolTable, exp);
	return symbolTable;
}

//
// Resolve names in statements. Both the assignment and the call statement contain
// variables. Note that, in Oberon-0, the if and the while do not start a new
// scope, so we can handle the bodies without worrying about creating a new
// scope in the symbol table, dealing with shadowing, etc.
//
public SymbolTable resolveStatementNames(SymbolTable symbolTable, Statement stmt) {
	switch(stmt) {
		case assign(v,e) : return resolveVariableNames(resolveExpressionNames(symbolTable,e),v);
		case call(v,es) : return resolveVariableNames(resolveExpressionNames(symbolTable,es),v);
		case ifThen(e,bs,eifs,ep) : {
			symbolTable = resolveStatementNames(resolveExpressionNames(symbolTable,e),bs);
			for (<e2,bs2> <- eifs) symbolTable = resolveStatementNames(resolveExpressionNames(symbolTable,e2),bs2);
			return resolveStatementNames(symbolTable,ep);
		}
		case whileDo(e,bs) : return resolveStatementNames(resolveExpressionNames(symbolTable,e),bs);
	}
	
	throw "resolveNames: Unhandled statement <stmt> at location <stmt@location>";
}

//
// Handle lists of statements (such as are found in if bodies). These are processed in a left
// to right (or, as on the page, top to bottom) order.
//
public SymbolTable resolveStatementNames(SymbolTable symbolTable, list[Statement] stmts) {
	for (stmt <- stmts) symbolTable = resolveStatementNames(symbolTable, stmt);
	return symbolTable;
}

//
// Resolve names in types. Note that the type declaration is a separate
// syntactic strucure, so we expect type names used here to be already
// defined. Note also that there is no separate INTEGER type in the
// abstract syntax, so we need to check for that explicitly as one
// variant of a user-defined type name. Types appear in fields,
// formal parameters, variable declarations, and type declarations.
//
// TODO: Do we need a check here to ensure that reserved words are not
// used as type names? Or, does the parser currently handle this for us?
//
public SymbolTable resolveTypeNames(SymbolTable symbolTable, Type t) {
	// INTEGER type
	if (user(name) := t, /^integer$/i := name.name) return symbolTable;

	// Other named types: the name should already be defined
	if (user(name) := t) {
		if (size(getItemsForTypeName(symbolTable, symbolTable.currentScope, name)) > 0) {
			return addItemUses(symbolTable, getItemsForTypeName(symbolTable, symbolTable.currentScope, name), name@location);
		} else {
			return addScopeError(symbolTable, name@location, "<name.name> not defined before use");
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
		symbolTable = resolveTypeNames(symbolTable,ty);
		< symbolTable, evalResult, evalValue > = evaluateConstantExp(symbolTable,e);
		if (evalResult && evalValue < 1)
			symbolTable = addScopeError(symbolTable, t@location, "type invalid, array size must be larger than 0");
		//if (!evalResult)
		//	symbolTable = addScopeError(symbolTable, t@location, "type invalid, cannot compute constant result for array size expression");
		return symbolTable;
	}
	
	// Record types. We need to resolve names in the types of the fields, but
	// otherwise do nothing here.	
	if (record(fs) := t) return resolveFieldNames(symbolTable,fs);

	throw "resolveNames: Unhandled type <t> at location <t@location>";
}

//
// For fields, we resolve the names in the field type, which should only
// use already-declared names. We do NOT resolve the names in the IDs,
// since they can be arbitrary.
//
// TODO: Do we need a check here to ensure that reserved words are not
// used as field names? Or, does the parser currently handle this for us?
//
public SymbolTable resolveFieldNames(SymbolTable symbolTable, Field f) {
	if (field(ids,ty) := f) return resolveTypeNames(symbolTable,ty);
	throw "resolveNames: Unhandled field <f> at location <f@location>";
}

//
// Handle lists of fields, as found in record type declarations.
//
public SymbolTable resolveFieldNames(SymbolTable symbolTable, list[Field] fs) {
	for (f <- fs) symbolTable = resolveFieldNames(symbolTable,f);
	return symbolTable;
}

//
// Resolve names in procedure declarations. We need to ensure that the procedure name
// is new (in this level of scope), add items for the procedure and its parameters,
// then process the procedure declarations and body. We also do some checking to ensure
// the procedure name and the end name are the same.
//
// TODO: Do we need a check here to ensure that reserved words are not
// used as procedure and/or parameter names? Or, does the parser currently 
// handle this for us?
//
public SymbolTable resolveProcedureNames(SymbolTable symbolTable, Procedure pr) {
	if (proc(pid,fs,ds,bs,eid) := pr) {
		// First sanity check -- we aren't redefining an existing type name, are we?
		if (/^integer$/i := pid.name)
			return addScopeError(symbolTable, pid@location, "Procedure name <id.name> redefines a predefined identifier");

		// conflicts will contain all items of the same name defined in the same scope
		set[STItemId] conflicts = { c | c <- getItemsForName(symbolTable, pid), symbolTable.scopeItemMap[c].parentId == symbolTable.currentScope };

		// NOTE: If we have conflicts, we don't process the procedure body, we enforce the surrounding scope to be
		// correct before enforcing inner scope correctness.
		if (size(conflicts) > 0)
			return addScopeError(symbolTable, pid@location, "A variable, constant, or procedure with name <pid.name> is already defined in the current scope");

		// Next, get back the needed information for each of the parameters
		list[tuple[Ident pname, OType ptype, loc ploc, loc nloc, bool isvar]] params = [];
		for (f <- fs) {
			if (formal(hasv,ids,ty) := f) {
				symbolTable = resolveTypeNames(symbolTable, ty);
				<symbolTable, cres, ot> = otype(symbolTable, ty);
				for (id <- ids) {
						params += < id, ot, id@location, f@location, hasv >;
				}
			} else {
				throw "resolveNames: Unhandled formal <f> at location <f@location>";
			}
		}
		
		// Then, add the new procedure into the scope
		ResultTuple rt = pushNewProcedureScope(symbolTable,pid,params,pr@location);
		symbolTable = justSymbolTable(addSTItemUses(rt,([<false,pr@location>, <true,pid@location>] + [<true,nloc> | <_,_,_,nloc,_> <- params])));
		
		// Next, process all declarations before the procedure body
		symbolTable = resolveDeclarationNames(symbolTable, ds);
		
		// Then, process the procedure body
		symbolTable = resolveStatementNames(symbolTable, bs);
		
		// Sanity check, ensure the final name is the same as the procedure name
		if (pid.name != eid.name) {
			symbolTable = addScopeError(symbolTable,pr@location,"The procedure name <pid.name> and the procedure end name <eid.name> do not match");
		}
		
		// Finally, pop the scope and return
		return popScope(symbolTable);
	}
	
	throw "resolveNames: Unhandled procedure <pr> at location <proc@location>";
}

//
// Handle lists of procedures from top to bottom, as found in the procedure declarations
// section of a module or another procedure.
//
public SymbolTable resolveProcedureNames(SymbolTable symbolTable, list[Procedure] procs) {
	for (pr <- procs) symbolTable = resolveProcedureNames(symbolTable,pr);
	return symbolTable;
}

//
// Process the declarations section of a module or procedure. This just involves
// processing the sub-sections: constants, types, variables, and procedures.
//
public SymbolTable resolveDeclarationNames(SymbolTable symbolTable, Declarations d) {
	if (decls(cds, ts, vs, ps) := d) {
		symbolTable = resolveConstDeclNames(symbolTable, cds);
		symbolTable = resolveTypeDeclNames(symbolTable, ts);
		symbolTable = resolveVarDeclNames(symbolTable, vs);
		symbolTable = resolveProcedureNames(symbolTable, ps);
		return symbolTable;
	}
	throw "resolveNames: Unhandled declarations <d> at location <d@location>";
}

//
// Process constant declarations. We need to ensure that the name is
// not already defined in this scope, and we also need to ensure that
// the defining expression is really a constant expression returning
// an INTEGER result.
//
// TODO: Do we need a check here to ensure that reserved words are not
// used as constant names? Or, does the parser currently handle this for us?
//
public SymbolTable resolveConstDeclNames(SymbolTable symbolTable, ConstDecl cd) {
	if (constDecl(cid,val) := cd) {
		// Make sure we evaluate the constant expression before we add the constant
		// to scope, definitions cannot be recursive.
		< symbolTable, evalResult, evalValue > = evaluateConstantExp(symbolTable,val);
		
		// First sanity check -- we aren't redefining an existing name, are we?
		if (/^integer$/i := cid.name)
			return addScopeError(symbolTable, cid@location, "Name <cid.name> redefines a predefined identifier");
			 
		// Note that we need to check for conflicts here, since we cannot define the
		// same constant/variable/procedure name more than once in the same scope. If 
		// we do have conflicts, we do NOT add a new item for this constant.
		set[STItemId] conflicts = { c | c <- getItemsForName(symbolTable, cid), symbolTable.scopeItemMap[c].parentId == symbolTable.currentScope };
		
		if (!evalResult)
			evalValue = 0; // we still want to add the item, so we will find future scope problems, so just put in a default
		
		if (size(conflicts) > 0)
			symbolTable = addScopeError(symbolTable, cid@location, "A variable, constant, or procedure with name <cid.name> is already defined in the current scope");
		else
			symbolTable = justSymbolTable(addSTItemUses(addConstantToScope(symbolTable,cid,evalValue,cd@location),[<true,cid@location>]));

		return symbolTable;
	}

	throw "resolveNames: Unhandled constant declaration <cd> at location <cd@location>";
}

//
// Handles constants in a top to bottom ordering.
//
public SymbolTable resolveConstDeclNames(SymbolTable symbolTable, list[ConstDecl] cds) {
	for (cd <- cds) symbolTable = resolveConstDeclNames(symbolTable, cd);
	return symbolTable;
}

//
// Process type definitions. In error cases, these are given an
// undefined type. This allows us to progress (we would get spurious
// errors if we didn't add the type into the scope) without inadvertently
// allowing broken programs to type.
//
// TODO: Do we need a check here to ensure that reserved words are not
// used as type names? Or, does the parser currently handle this for us?
//
public SymbolTable resolveTypeDeclNames(SymbolTable symbolTable, TypeDecl td) {
	if (typeDecl(tid,ty) := td) {
		// Make sure we evaluate the type expression on the right before we add
		// the type name to scope, definitions cannot be recursive
		symbolTable = resolveTypeNames(symbolTable,ty);

		// First sanity check -- we aren't redefining an existing type name, are we?
		if (/^integer$/i := tid.name)
			return addScopeError(symbolTable, tid@location, "Type name <tid.name> redefines a predefined identifier");
			 
		// Note that we need to check for conflicts here, since we cannot define
		// the same type more than once in the same scope. If we do have conflicts,
		// we do NOT add a new item for this type.
		set[STItemId] conflicts = { c | c <- getItemsForTypeName(symbolTable, tid), symbolTable.scopeItemMap[c].parentId == symbolTable.currentScope };
		
		if (size(conflicts) > 0)
			symbolTable = addScopeError(symbolTable, tid@location, "Type <tid.name> is already defined in the current scope");
		else {
			<symbolTable, cres, ot> = otype(symbolTable, ty); // NOTE: ot may be Invalid()
			symbolTable = justSymbolTable(addSTItemUses(addTypeToScope(symbolTable,tid,ot,td@location),[<true,tid@location>]));
		}
		return symbolTable;
	}
	throw "resolveNames: Unhandled type declaration <td> at location <td@location>";
}

//
// Process lists of type declarations in top to bottom textual order. This enforces
// the default scoping rule of Oberon-0, which enforces scope in the textual order
// of the program.
//
public SymbolTable resolveTypeDeclNames(SymbolTable symbolTable, list[TypeDecl] tds) {
	for (td <- tds) symbolTable = resolveTypeDeclNames(symbolTable,td);
	return symbolTable;
}

//
// Process variable names.
//
// TODO: Add check to ensure we aren't defining an existing keyword
//
public SymbolTable resolveVarDeclNames(SymbolTable symbolTable, VarDecl vd) {
	if (varDecl(ids,ty) := vd) {
		// NOTE: Check the type first, in case the variable shadows a constant used
		// in the type declaration.
		symbolTable = resolveTypeNames(symbolTable,ty);

		// Now actually get the computed type back. ot could be Invalid() in cases where
		// the type cannot be computed.
		<symbolTable, cres, ot> = otype(symbolTable, ty);
		// For each id in the var decl, we add a new variable item into the symbol table.
		// Note that we need to check for conflicts here as well, since we cannot define
		// the same name more than once in the same scope. If we do have conflicts,
		// we do NOT add a new item for this variable.
		for (vid <- ids) {
			set[STItemId] conflicts = { c | c <- getItemsForName(symbolTable, vid), symbolTable.scopeItemMap[c].parentId == symbolTable.currentScope };
			if (size(conflicts) > 0)
				symbolTable = addScopeError(symbolTable, vid@location, "A variable, constant, or procedure with name <vid.name> is already defined in the current scope");
			else
				symbolTable = justSymbolTable(addSTItemUses(addVariableToScope(symbolTable,vid,ot,vd@location),[<true,vid@location>]));
		}
		return symbolTable;
	}
	throw "resolveNames: Unhandled variable declaration <vd> at location <vd@location>";
}

//
// Process variable declarations in top to down (lexical) order.
//
public SymbolTable resolveVarDeclNames(SymbolTable symbolTable, list[VarDecl] vds) {
	for (vd <- vds) symbolTable = resolveVarDeclNames(symbolTable,vd);
	return symbolTable;
}

//
// Resolve names for Oberon-0 Modules
//
// TODO: Add check to ensure we aren't defining an existing keyword as the module name
//
public SymbolTable resolveModuleNames(SymbolTable symbolTable, Module m) {
	if (mod(mn, ds, bs, en) := m) {
		symbolTable = justSymbolTable(setCurrentModule(addSTItemUses(pushNewModuleScope(symbolTable, mn, m@location),[<false,m@location>,<true,mn@location>])));
		symbolTable = resolveDeclarationNames(symbolTable, ds);
		symbolTable = resolveStatementNames(symbolTable, bs);
		if (mn.name != en.name) {
			symbolTable = addScopeError(symbolTable,m@location,"The module name <mn.name> and the module end name <en.name> do not match");
		}
		return popScope(symbolTable);
	}

	throw "resolveNames: Unhandled module <m> at <m@location>";
}

@doc{Entry module for the name resolver, this will give back a symbol table representing the module passed in.}
public SymbolTable resolveNames(Module m) {
	SymbolTable symbolTable = createNewSymbolTable();
	symbolTable = justSymbolTable(pushNewTopScope(symbolTable, m@location));
	
	// Add built-in names
	symbolTable = justSymbolTable(addBuiltInToScope(symbolTable,id("writeln")));
	symbolTable = justSymbolTable(addBuiltInToScope(symbolTable,id("write")));
	symbolTable = justSymbolTable(addBuiltInToScope(symbolTable,id("readln")));
	symbolTable = justSymbolTable(addBuiltInToScope(symbolTable,id("read")));
	
	symbolTable = resolveModuleNames(symbolTable, m);
	return symbolTable;
}