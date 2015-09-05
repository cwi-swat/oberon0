module ldta::oberon0::l4::normalize::SingleWordAssign

import ldta::oberon0::l1::Syntax;
import ldta::oberon0::l4::AST;
import ldta::oberon0::l4::normalize::AnnotateByRefs;
import ldta::oberon0::l4::normalize::NormalizeL3;
import List;
import IO;
/* Ensures that all assignments copy a single word.
   In oberon0 an assignment entails a copy of multiple words, 
   when the assignee is an array or record. Such assignments
   are expanded into multiple single-word assignments.
  
   After this transformation, arguments to functions are
   also single words. This is archieved by making all 
   composite(non-single word) parameters by reference and then 
   copying the argument at the call-sites.
*/

alias Envr = map[Ident,Type];

public Module toSingleWordAssign(Module m) {

	Envr getVariableTypesOfDecls(Declarations decls) {
		return ( name : var.\type | var <- decls.vars, name <- var.names);
	}
	
	Envr getVariableTypesOfProc(Procedure p){
		bla = ( name : f.\type | f <- p.formals, name <- f.names) ;
		return bla + getVariableTypesOfDecls(p.decls);
	}
	
	Procedure toSingleWordAssignInProc(Procedure p,Envr env){
		env = env + getVariableTypesOfProc(p);
		p.body = explicitCopyCompositeArguments(p.body,env);
		p.body = explicitCopyMultipleWords(p.body,env);
		return p;
	}

	m = annotateByRefs(m);
	m = makeCompositeFormalsByRef(m);
	env = getVariableTypesOfDecls(m.decls);
	m.body = explicitCopyCompositeArguments(m.body,env);
	m.body = explicitCopyMultipleWords(m.body,env);
	m.decls.procs = [toSingleWordAssignInProc(p,env) | p <- m.decls.procs ];
	return flattenBegins(liftLets(m));
}

	

Module makeCompositeFormalsByRef(Module m){
	return bottom-up-break visit(m) {
		case formal(false,names,\type) => 
			formal(true,names,\type) when isCompositeType(\type)
	};
}


list[Statement] explicitCopyCompositeArguments(list[Statement] stats, Envr env){

	Statement rewriteCall(call(procName,args)) {
		tempCopyVars = [];
		tempCopyAssigns = [];
		newArgs = [];
		for(arg <- args) {
			if (lookup(varName,selectors) := arg 
			    && !(arg@passByRef) 
			    && \type := varUseType(varName,selectors,env) && isCompositeType(\type)){
			    	tempCopyName = id("_copyVar_<size(tempCopyVars)>");
			    	tempCopyVars+= varDecl([tempCopyName],\type);
					tempCopyAssigns+= assign(tempCopyName,[],arg);
					newArgs+=lookup(tempCopyName,[]);
			} else  newArgs+=arg;
		}
		return let(tempCopyVars, tempCopyAssigns + [call(procName,newArgs)]);
	}

	return visit(stats){
		case c:call(_,_) => rewriteCall(c) 
	}
}


list[Statement] explicitCopyMultipleWords(list[Statement] statements,Envr env) {

	Statement rewriteAssignment(Ident toName, list[Selector] toSelectors, Ident fromName, list[Selector] fromSelectors, Type assignType) {
		switch(assignType){
			case array(nat(l),nestedType) : return copyArray(toName,toSelectors,fromName,fromSelectors,assignType);
			case record(fields)           : return copyRecordFields(toName,toSelectors,fromName,fromSelectors,assignType);
		}
	}
	
	
	Statement copyRecordFields(Ident toName, list[Selector] toSelectors, Ident fromName, list[Selector] fromSelectors,list[Field] fields){
		copyStatements = for(f <- fields, n <- f.names) {
			sel = field(n);
			append assign(toName,toSelectors + [sel] ,lookup(fromName,fromSelectors + [sel]));
		}
		return let([],copyStatements);
	}
	
	Statement copyArray(Ident toName, list[Selector] toSelectors, Ident fromName, list[Selector] fromSelectors, array(nat(l),nestedType)) {
		tempCopyCounter = id("tempCopyCounter_");
		tempCopy = id("tempCopy_");
		sel = subscript(lookup(tempCopyCounter,[]));
		return let(
			 [ varDecl([tempCopy],nestedType),
			   varDecl([tempCopyCounter],user(id("INTEGER"))) ],
			 [ assign(tempCopyCounter,[],nat(0)),
			   whileDo(lt(lookup(tempCopyCounter,[]),nat(l)),
				 	[assign(toName,toSelectors + [sel],lookup(fromName,fromSelectors + [sel]))]
				)]
		);
	}

	return innermost visit(statements) {
		case assign(toName,toSelectors,lookup(fromName,fromSelectors)) : {
			assignType = varUseType(fromName,fromSelectors,env);
			if(isCompositeType(assignType)) 
				insert rewriteAssignment(toName,toSelectors,fromName,fromSelectors,assignType);
			else fail;
		}
	};
}


Type varUseType(Ident var,list[Selector] selectors, Envr envir){

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
	
	return selectorsType(selectors,envir[var]);
}

bool isCompositeType(Type t){
	return array(_,_) := t || record(_) := t;
}

