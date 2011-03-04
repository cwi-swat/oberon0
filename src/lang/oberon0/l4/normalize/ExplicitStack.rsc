module lang::oberon0::l4::normalize::ExplicitStack

import lang::oberon0::l1::ast::Oberon0;
import lang::oberon0::l3::ast::Oberon0;
import lang::oberon0::l4::ast::Oberon0;

import lang::oberon0::l3::compile::AnnotateByRefs;
import IO;
import List;

data StackLocation = stackLocation(int offset, bool \global, Type \type, bool byRef);   
data Env = env(int frameSize, map[Ident,StackLocation] offsetMap);


/* Rewrites a oberon0 program such that it uses an explicit stack
   i.e. it uses exactly 2 global variables: an array representing the stack
   and a stack pointer. This eliminates all global variables and all local variables.
   
   Notice that this also changes the semantics of the builtins Read and Write
   
   stack[0] is reserved as a temp variable for use when copying multiple words
*/

Ident stack = id("stack");
Ident sp = id("sp");
Expression tempVarIndex = nat(0);


/* Assumes: resolve, lift, removeTypeAliases, annotateByRefs */

int stackSize = 100000;

public Module explicitStack(Module mod){
	mod = annotateByRefs(mod);
	Env env = globalEnvironment(mod);
	mod.decls.vars = [varDecl([stack],array(nat(stackSize),user(id("INTEGER"))))
	                 ,varDecl([sp],user(id("INTEGER")))];
	mod.decls.procs = explicitStackInProcedures(mod.decls.procs,env);
	mod.body = explicitStackInStatements(mod.body,env);
	return mod;
}

list[Procedure] explicitStackInProcedures(list[Procedure] procs, Env env){
	return [ explicitStackInProcedure(p,env) | p <- procs ];
}

Procedure explicitStackInProcedure(Procedure proc, Env env) {
	env = envOfProcedure(proc,env);
	proc.body = explicitStackInStatements(proc.body,env);
	proc.formals = [];
	proc.decls.vars = [];
	return proc;
}

list[Statement] explicitStackInStatements(list[Statement] statements, Env env) {
	// use auto-splice
	return [ explicitStackInStatement(statement,env) | statement <- statements];
}

list[Statement] explicitStackInStatement(Statement statement,Env env) {
	switch(statement) {
		case assign(varTo,selectorsTo,lookup(varFrom,selectorsFrom)) : {
				return copyVar(varTo,selectorsTo,varFrom,selectorsFrom,env);
		}
		case assign(varTo,selectorsTo,exp) : {
			exp = rewriteLookups(exp,env);
			i = subscript(varUseOffset(varTo,selectorsTo,env));
			return [assign(stack,[i],exp)];
		}
		case call(p,args) : {
			return rewriteCall(p,args,env);
		}
		default : {
			statement = top-down-break visit(statement) {
				case list[Statement] s => explicitStackInStatements(s,env) when s != []
				case Expression exp    => rewriteLookups(exp,env)
			}
			return [statement];
		}
	}
}

list[Statement] rewriteCall(Ident procName,list[Expression] args, Env env){
	int argOffset = 0;
	list[Statement] result = [];
	for(arg <- args) {
		offset = add(lookup(sp,[]),nat(env.frameSize + argOffset));
		switch(arg) {
			case lookup(var,selectors) : {
				offsetFrom = varUseOffset(var,selectors,env);
				if(arg@passByRef) {
					result+= [assign(stack,[subscript(offset)],offsetFrom)];
					argOffset+=1;
				} else {
					int size = sizeOf(varUseType(var,selectors,env));
					result+= copy(offset,offsetFrom,size,env);
					argOffset+=size;
				}
			}
			default : {
				arg = rewriteLookups(arg,env);
				result+= [assign(stack,[subscript(offset)],arg)];
				argOffset+=1;
			}
		}
	}
	result+= [assign(sp,[],add(lookup(sp,[]),nat(env.frameSize)))];
	result+= [call(procName,[])];
	result+= [assign(sp,[],sub(lookup(sp,[]),nat(env.frameSize)))];
	return result;
}

Expression rewriteLookups(Expression exp, Env env) {
	return top-down-break visit(exp) {
		case lookup(var,selectors) => {
			i = subscript(varUseOffset(var,selectors,env));
			insert lookup(stack,[i]);
		}
	};
}

list[Statement] copyVar(Ident varTo,list[Selector] selectorsTo, Ident varFrom, list[Selector] selectorsFrom, Env env) {
	offsetTo = varUseOffset(varTo,selectorsTo,env);
	offsetFrom = varUseOffset(varFrom,selectorsFrom,env);
	copySize = sizeOf(varUseType(varTo,selectorsTo,env));
	return copy(offsetTo,offsetFrom,copySize,env);
}

list[Statement] copy(Expression destinationPointer, Expression sourcePointer, int copySize, Env env){
	if(copySize == 1) {
		return [assign(stack,[subscript(destinationPointer)],lookup(stack,[subscript(sourcePointer)]))];
	} 
	return [assign(stack,[subscript(tempVarIndex)],nat(copySize-1)),
			whileDo(geq(lookup(stack,[subscript(tempVarIndex)]),nat(0)),
				[assign(stack,
				    [subscript(add(destinationPointer,lookup(stack,[subscript(tempVarIndex)])))],
					lookup(stack,[subscript(add(sourcePointer,lookup(stack,[subscript(tempVarIndex)])))])),
				 assign(stack,[subscript(tempVarIndex)],add(lookup(stack,[subscript(tempVarIndex)]),nat(1)))
				]
			 )
			];
}

Env globalEnvironment(Module mod) {
	return envOfDecls(mod.decls,true,env(1,()));
}
	 
Env envOfProcedure(Procedure p,Env env) {
	env.frameSize = 0;
	for(f <- p.formals, name <- f.names){
        env.offsetMap+=(name : stackLocation(env.frameSize,false, f.\type,f.hasVar));
        env.frameSize+=f.hasVar? 1 : sizeOf(f.\type);
    }
    return envOfDecls(p.decls,false,env);
}

Env envOfDecls(Declarations decls, bool \global, Env env) {
	for(var <- decls.vars, name <- var.names){
        env.offsetMap+=(name : stackLocation(env.frameSize,\global,var.\type,false));
        env.frameSize+=sizeOf(var.\type);
    }
    return env;
}

Expression varUseOffset(Ident var, list[Selector] selectors, Env env){
	StackLocation stackLocation = env.offsetMap[var];
	result = nat(stackLocation.offset);
	if(!stackLocation.\global) {
		result = add(lookup(sp,[]),result);
	}
	if(stackLocation.byRef) {
		result = lookup(stack,[subscript(result)]);
	} 
	if(selectors != []) {
		result = add(result,offsetOfSelectors(selectors,stackLocation.\type,env));
	}
	return result;
}
	
Expression offsetOfSelectors([selector], Type \type,Env env) {
	return offsetOfSelector(selector,\type,env);
}
Expression offsetOfSelectors([selector,l*],Type \type,Env env) {
	nextType = getSelectorType(selector,\type);
	offset = offsetOfSelector(selector,\type,env);
	return add(offset,offsetOfSelectors(l,nextType));
}

Expression offsetOfSelector(Selector selector, Type \type,Env env) {
	switch(<selector,\type>) {
		case <field(name)     , record(fields)> : return offsetOfRecordField(name,\type);
		case <subscript(i), array(_,innerType)> : return mul(rewriteLookups(i,env),nat(sizeOf(innerType)));
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

Type varUseType(Ident var,list[Selector] selectors, Env env){
	return selectorsType(selectors,env.offsetMap[var].\type);
}

Type selectorsType(list[Selector] selectors,Type \type) {
	if(selectors == [] ) return \type;
	return selectorsType(tail(selectors),selectorType(head(selectors),\type));
}
	
Type selectorType(Selector selector, Type \type) {
	switch(<selector,\type>) {
		case <field(name) , record(fields)  > : return recordFieldType(name,\type);
		case <subscript(_), array(_,innerType)> : return innerType;
		default : throw "Selector does not match type!";
	}
}

Type recordFieldType(str fieldName,Type recordType){
	for(field <- recordType.fields) {
		if(field.name == name) return field.\type;
	}
	throw "Field <fieldName> not present!";
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

/*
Procedure copyProc() {
*/
	/* returns a oberon0 function which copies words on the stack
	   (arguments: sp+0 = destPointer, sp+1 = sourcePointer, sp+2 = size)
  PROCEDURE copy_();
    BEGIN
      WHILE(stack[sp+2] # 0) DO
	    stack[stack[sp+0] + stack[sp+2]] :=  stack[stack[sp+1] + stack[sp+2]];
	    stack[sp+2] := stack[sp+2] - 1;
	  END
   END copy_;
	*/
/*
	list[Selector] variableIndex(int offset) {
		return [subscript(add(lookup(sp,[]),nat(offset)))];
	}
	Statement increment(Selector pointer) {
		return assign(stack,lookup(stack,pointer),add(lookup(stack,pointer),nat(1)));
	}
	list[Selector] offsetOfPointer(list[Selector] pointer,list[Selector] offset) {
		return  [subscript(add(lookup(stack,pointer),lookup(stack,offset)))];
	}
	destPointerIndex = variableIndex(0);
	sourcePointerIndex = variableIndex(1);
	sizeIndex = variableIndex(2);
	body = [
			whileDo(neq(lookup(stack,sizeIndex), nat(0)),
				[assign(stack,offsetOfPointer(destPointerIndex,sizeIndex), 
		                      lookup(stack,offsetOfPointer(sourcePointerIndex,sizeIndex))),
		         assign(stack,sizeIndex,sub(lookup(stack,sizeIndex),nat(1)))]
		    )
		  ];
	
	emptyDecls = decls([],[], [], []);
	return proc(id("copy_"), [], emptyDecls , body, id("copy_"));
}
*/