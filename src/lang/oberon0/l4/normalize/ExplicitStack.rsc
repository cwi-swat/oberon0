module lang::oberon0::l4::normalize::ExplicitStack

import lang::oberon0::l4::ast::Oberon0;
import lang::oberon0::l4::normalize::Normalize;
import lang::oberon0::l4::compile::AnnotateByRefs;
import List;

/* Rewrites a oberon0 program such that it uses an explicit stack.
   This eliminates all global variables(except the stack and stack pointer),
   all parameters and arguments and all local variables.
   This is archieved by introducing 2 global variables: an array representing the stack
   and a stack pointer. 
   Parameter passing, local variables and global variables are then stored on this stack.
   
   Notice that this does not change the semantics of the builtins Read and Write

  Assumes: resolve, lift, removeTypeAliases, annotateByRefs    
*/

data StackLocation = stackLocation(int offset, bool \global, Type \type, bool byRef);   
data Envir = envir(int frameSize, map[Ident,StackLocation] offsetMap);
Ident stack = id("stack");
Ident sp = id("sp");
int stackSize = 100000;

public Module toExplicitStack(Module mod){

	Envir globalEnvironment() {
		return envOfDecls(mod.decls,true,envir(0,())); 
	}

	mod = annotateByRefs(mod);
	Envir envir = globalEnvironment();
	mod.decls.vars = [varDecl([sp],user(id("INTEGER"))),
					  varDecl([stack],array(nat(stackSize),user(id("INTEGER"))))];
	mod.decls.procs = [ explicitStackInProcedure(p,envir) | p <- mod.decls.procs ];
	mod.body = explicitStackInStatements(mod.body,envir);
	return flattenBegins(liftLets(mod));
}


Envir envOfDecls(Declarations decls, bool \global, Envir envir) {
	for(var <- decls.vars, name <- var.names){
        envir.offsetMap+=(name : stackLocation(envir.frameSize,\global,var.\type,false));
        envir.frameSize+=sizeOf(var.\type);
    }
    return envir;
}

Procedure explicitStackInProcedure(Procedure p, Envir envir) {

	Envir envOfProcedure() {
		envir.frameSize = 0;
		for(f <- p.formals, name <- f.names){
	        envir.offsetMap+=(name : stackLocation(envir.frameSize,false, f.\type,f.hasVar));
	        envir.frameSize+=1; // all arguments are either integer or by ref because of singleWordAssign
	    }
	    return envOfDecls(p.decls,false,envir);
	}

	envir = envOfProcedure();
	p.body = explicitStackInStatements(p.body,envir);
	p.formals = [];
	p.decls.vars = [];
	return p;
}

list[Statement] explicitStackInStatements(list[Statement] statements,Envir envir) {

	Statement rewriteCall(Ident procName,list[Expression] args){
	
		// maintain Read and Write semantics
		if(procName == id("Write")) return call(procName,args);
		if(procName == id("Read")) return call(procName, [lookup(stack,[subscript(args[0])])]);
	
		Statement addSp(int amount){
			int newValue; 
			if(amount >= 0) newValue = add(lookup(sp,[]),nat(amount));
			else newValue = sub(lookup(sp,[]),nat(-amount));
			return assign(sp,[],newValue);
		}
		
		int argOffset = 0;
		result = for(arg <- args) {
			offset = add(lookup(sp,[]),nat(envir.frameSize + argOffset));
			append assign(stack,[subscript(offset)],arg);
			argOffset+=1;
		}
		result+= [addSp(envir.frameSize), call(procName,[]), addSp(-envir.frameSize)];
		return let([],result);
	}
	
	statements = bottom-up visit(statements) {
		case l:lookup(var,selectors) => {
			stackOffset = varUseOffset(var,selectors,envir);
			// if expression is passed by ref (as argument to function), pass stackoffset 
			// instead of lookup of stackoffset
			if((l@passByRef)? && l@passByRef) insert stackOffset;
			else insert lookup(stack,[subscript(stackOffset)]);
		}
	}

	return top-down-break visit(statements) {
		case assign(varTo,selectorsTo,exp) => assign(stack,[subscript(varUseOffset(varTo,selectorsTo,envir))],exp)
		case call(p,args)                  => rewriteCall(p,args)
	}
}

Expression varUseOffset(Ident var, list[Selector] selectors, Envir envir){

	Expression offsetOfSelectors([selector], Type \type) {
		return offsetOfSelector(selector,\type);
	}
	Expression offsetOfSelectors([selector,l*],Type \type) {
		nextType = getSelectorType(selector,\type);
		offset = offsetOfSelector(selector,\type);
		return add(offset,offsetOfSelectors(l,nextType));
	}
	
	Expression offsetOfSelector(Selector selector, Type \type) {
		switch(<selector,\type>) {
			case <field(name)     , record(fields)> : return offsetOfRecordField(name,\type);
			case <subscript(i), array(_,innerType)> : return mul(i,nat(sizeOf(innerType)));
			default : throw "Selector does not match type!";
		}
	}
	
	int offsetOfRecordField(str fieldName,Type recordType){
		int offset = 0;
		for(field <- recordType.fields) {
			if(field.name == name) return offset;
			offset+= sizeOf(\field.\type);
		}
	}

	StackLocation stackLocation = envir.offsetMap[var];
	result = nat(stackLocation.offset);
	if(!stackLocation.\global) result = add(lookup(sp,[]),result);
	if(stackLocation.byRef)    result = lookup(stack,[subscript(result)]);
	if(selectors != [])        result = add(result,offsetOfSelectors(selectors,stackLocation.\type));
	return result;
}
	


int sizeOf(Type \type){
    switch(\type){
        case user(id("INTEGER")): return 1;
        case user(id("BOOLEAN")): return 1;
        case user(_)        : throw "oberon0ToJava: type alias still present!";
        case array(nat(i),nestedType) : return i * sizeOf(nestedType);
        case array(_,_)     : throw "array <\type> not of computed length"; 
        case record(fields) : return (0 | it + sizeOf(field.\type) | field <- fields);
    }
}