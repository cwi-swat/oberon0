module lang::oberon0::l4::normalize::ExplicitStack

import lang::oberon0::l4::ast::Oberon0;

import lang::oberon0::l3::compile::AnnotateByRefs;
import IO;
import List;

data StackLocation = stackLocation(int offset, bool \global, Type \type, bool byRef);   
data Envir = envir(int frameSize, map[Ident,StackLocation] offsetMap);


/* Rewrites a oberon0 program such that it uses an explicit stack
   i.e. it uses exactly 2 global variables: an array representing the stack
   and a stack pointer. This eliminates all global variables and all local variables.
   
   Notice that this also changes the semantics of the builtins Read and Write
   
   stack[0] and stack[1] are reserved as temp variables for use when copying multiple words
*/

Ident stack = id("stack");
Ident sp = id("sp");
Expression tempVarAIndex = nat(0);
Expression tempVarBIndex = nat(1);
int nrTempVar = 2;
/* Assumes: resolve, lift, removeTypeAliases, annotateByRefs */

int stackSize = 100000;

public Module explicitStack(Module mod){
	mod = annotateByRefs(mod);
	Envir envir = globalEnvironment(mod);
	mod.decls.vars = [varDecl([stack],array(nat(stackSize),user(id("INTEGER"))))
	                 ,varDecl([sp],user(id("INTEGER")))];
	mod.decls.procs = explicitStackInProcedures(mod.decls.procs,envir);
	mod.body = explicitStackInStatements(mod.body,envir);
	return mod;
}

list[Procedure] explicitStackInProcedures(list[Procedure] procs, Envir envir){
	return [ explicitStackInProcedure(p,envir) | p <- procs ];
}

Procedure explicitStackInProcedure(Procedure proc, Envir envir) {
	envir = envOfProcedure(proc,envir);
	proc.body = explicitStackInStatements(proc.body,envir);
	proc.formals = [];
	proc.decls.vars = [];
	return proc;
}

list[Statement] explicitStackInStatements(list[Statement] statements, Envir envir) {
	// use auto-splice
	return [ explicitStackInStatement(statement,envir) | statement <- statements];
}

list[Statement] explicitStackInStatement(Statement statement,Envir envir) {
	switch(statement) {
		case assign(varTo,selectorsTo,lookup(varFrom,selectorsFrom)) : {
				return copyVar(varTo,selectorsTo,varFrom,selectorsFrom,envir);
		}
		case assign(varTo,selectorsTo,exp) : {
			exp = rewriteLookups(exp,envir);
			i = subscript(varUseOffset(varTo,selectorsTo,envir));
			return [assign(stack,[i],exp)];
		}
		case call(p,args) : {
			return rewriteCall(p,args,envir);
		}
		default : {
			statement = top-down-break visit(statement) {
				case list[Statement] s => explicitStackInStatements(s,envir) when s != []
				case Expression exp    => rewriteLookups(exp,envir)
			}
			return [statement];
		}
	}
}

list[Statement] rewriteCall(Ident procName,list[Expression] args, Envir envir){
	int argOffset = 0;
	list[Statement] result = [];
	for(arg <- args) {
		offset = add(lookup(sp,[]),nat(envir.frameSize + argOffset));
		switch(arg) {
			case lookup(var,selectors) : {
				offsetFrom = varUseOffset(var,selectors,envir);
				
				if(arg@passByRef) {
					result+= [assign(stack,[subscript(offset)],offsetFrom)];
					argOffset+=1;
				} else {
					int size = sizeOf(varUseType(var,selectors,envir));
					result+= copy(offset,offsetFrom,size,envir);
					argOffset+=size;
				}
			}
			default : {
				arg = rewriteLookups(arg,envir);
				result+= [assign(stack,[subscript(offset)],arg)];
				argOffset+=1;
			}
		}
	}
	result+= [assign(sp,[],add(lookup(sp,[]),nat(envir.frameSize)))];
	result+= [call(procName,[])];
	result+= [assign(sp,[],sub(lookup(sp,[]),nat(envir.frameSize)))];
	return result;
}

Expression rewriteLookups(Expression exp, Envir envir) {
	return top-down-break visit(exp) {
		case lookup(var,selectors) => {
			i = subscript(varUseOffset(var,selectors,envir));
			insert lookup(stack,[i]);
		}
	};
}

list[Statement] copyVar(Ident varTo,list[Selector] selectorsTo, Ident varFrom, list[Selector] selectorsFrom, Envir envir) {
	offsetTo = varUseOffset(varTo,selectorsTo,envir);
	offsetFrom = varUseOffset(varFrom,selectorsFrom,envir);
	copySize = sizeOf(varUseType(varTo,selectorsTo,envir));
	return copy(offsetTo,offsetFrom,copySize,envir);
}

list[Statement] copy(Expression destinationPointer, Expression sourcePointer, int copySize, Envir envir){
	if(copySize == 1) {
		return [assign(stack,[subscript(destinationPointer)],lookup(stack,[subscript(sourcePointer)]))];
	} 
	return [assign(stack,[subscript(tempVarAIndex)],nat(copySize-1)),
			assign(stack,[subscript(tempVarBIndex)],\true()),
			whileDo(lookup(stack,[subscript(tempVarBIndex)]),
				[assign(stack,
				    [subscript(add(destinationPointer,lookup(stack,[subscript(tempVarAIndex)])))],
					lookup(stack,[subscript(add(sourcePointer,lookup(stack,[subscript(tempVarAIndex)])))])),
				 assign(stack,[subscript(tempVarAIndex)],add(lookup(stack,[subscript(tempVarAIndex)]),nat(1))),
				 ifThen(geq(lookup(stack,[subscript(tempVarAIndex)]),nat(0)),
				 	[assign(stack,[subscript(tempVarBIndex)],\true())],
				 	[],
				 	[assign(stack,[subscript(tempVarBIndex)],\false())]
				 )
				 ])
				];
}

Envir globalEnvironment(Module mod) {
	return envOfDecls(mod.decls,true,envir(nrTempVar,())); 
}
	 
Envir envOfProcedure(Procedure p,Envir envir) {
	envir.frameSize = 0;
	for(f <- p.formals, name <- f.names){
        envir.offsetMap+=(name : stackLocation(envir.frameSize,false, f.\type,f.hasVar));
        envir.frameSize+=f.hasVar? 1 : sizeOf(f.\type);
    }
    return envOfDecls(p.decls,false,envir);
}

Envir envOfDecls(Declarations decls, bool \global, Envir envir) {
	for(var <- decls.vars, name <- var.names){
        envir.offsetMap+=(name : stackLocation(envir.frameSize,\global,var.\type,false));
        envir.frameSize+=sizeOf(var.\type);
    }
    return envir;
}

Expression varUseOffset(Ident var, list[Selector] selectors, Envir envir){
	StackLocation stackLocation = envir.offsetMap[var];
	result = nat(stackLocation.offset);
	if(!stackLocation.\global) {
		result = add(lookup(sp,[]),result);
	}
	if(stackLocation.byRef) {
		result = lookup(stack,[subscript(result)]);
	} 
	if(selectors != []) {
		result = add(result,offsetOfSelectors(selectors,stackLocation.\type,envir));
	}
	return result;
}
	
Expression offsetOfSelectors([selector], Type \type,Envir envir) {
	return offsetOfSelector(selector,\type,envir);
}
Expression offsetOfSelectors([selector,l*],Type \type,Envir envir) {
	nextType = getSelectorType(selector,\type);
	offset = offsetOfSelector(selector,\type,envir);
	return add(offset,offsetOfSelectors(l,nextType));
}

Expression offsetOfSelector(Selector selector, Type \type,Envir envir) {
	switch(<selector,\type>) {
		case <field(name)     , record(fields)> : return offsetOfRecordField(name,\type);
		case <subscript(i), array(_,innerType)> : return mul(rewriteLookups(i,envir),nat(sizeOf(innerType)));
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

Type varUseType(Ident var,list[Selector] selectors, Envir envir){
	return selectorsType(selectors,envir.offsetMap[var].\type);
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