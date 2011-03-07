module lang::oberon0::l3::resolve::ResolveNames

import IO;
import List;
import Set;
import Node;

import lang::oberon0::l3::ast::Oberon0;
import lang::oberon0::l1::resolve::Types;
import lang::oberon0::l1::resolve::SymbolTable;
import lang::oberon0::l3::resolve::SymbolTable;
import lang::oberon0::l1::resolve::ConstantEvaluator;
import lang::oberon0::l1::resolve::TypeEvaluator;

extend lang::oberon0::l1::resolve::ResolveNames;


public SymbolTableBuilder resolveStatementNames(SymbolTableBuilder stBuilder, call(v, es)) = 
	resolveVariableNames(resolveExpressionNames(stBuilder,es),v);

// Resolve names in procedure declarations. We need to ensure that the procedure name
// is new (in this level of scope), add items for the procedure and its parameters,
// then process the procedure declarations and body. We also do some checking to ensure
// the procedure name and the end name are the same.
//
public SymbolTableBuilder resolveProcedureNames(SymbolTableBuilder stBuilder, pr:proc(pid, fs, ds, bs, eid)) {
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
	} 
	else {
		stBuilder.itemUses = stBuilder.itemUses + < stBuilder.scopeStack[0], eid@location>;
	}
	
	// Finally, pop the scope and return
	return popScope(stBuilder);
}

//
// Handle lists of procedures from top to bottom, as found in the procedure declarations
// section of a module or another procedure.
//
public SymbolTableBuilder resolveProcedureNames(SymbolTableBuilder stBuilder, list[Procedure] procs) {
	return ( stBuilder | resolveProcedureNames(it, pr) | pr <- procs );
}

//
// Process the declarations section of a module or procedure. This just involves
// processing the sub-sections: constants, types, variables, and procedures.
//
public SymbolTableBuilder resolveDeclarationNames(SymbolTableBuilder stBuilder, decls(cds, ts, vs, ps)) {
	stBuilder = resolveConstDeclNames(stBuilder, cds);
	stBuilder = resolveTypeDeclNames(stBuilder, ts);
	stBuilder = resolveVarDeclNames(stBuilder, vs);
	stBuilder = resolveProcedureNames(stBuilder, ps);
	return stBuilder;
}


@doc{Entry module for the name resolver, this will give back a symbol table builder representing the module passed in.}
public SymbolTableBuilder resolveL3Names(Module m) {
	SymbolTableBuilder stBuilder = createNewSymbolTableBuilder();
	
	// Add built-in names
	// TODO: Do we have more of these?
	stBuilder = addBuiltInProcedure(stBuilder,id("WriteLn"),[]);
	stBuilder = addBuiltInProcedure(stBuilder,id("Write"),[<Integer(),false>]);
	stBuilder = addBuiltInProcedure(stBuilder,id("ReadLn"),[]);
	stBuilder = addBuiltInProcedure(stBuilder,id("Read"),[<Integer(),true>]);
	
	// Add built-in types
	stBuilder = addBuiltInType(stBuilder,id("INTEGER"));
	
	stBuilder = resolveModuleNames(stBuilder, m);
	return stBuilder;
}

