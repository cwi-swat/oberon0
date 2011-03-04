module lang::oberon0::l4::normalize::RemoveTypeAliases


import lang::oberon0::l1::ast::Oberon0;
import lang::oberon0::l3::ast::Oberon0;
import lang::oberon0::l4::ast::Oberon0;

import lang::oberon0::l3::normalize::Utils;

// precondition: resolveTypes, resolveProcs, resolveConsts, liftTypes, liftProcs, constantElimination

public Module removeTypeAliases(Module m) {
    aliasMap = ( \alias : \type  | /typeDecl(\alias,\type) <- m.decls.types );
    m.decls.types = [];
    return visit(m){
        case user(id(name)) => resolveUserType(name,aliasMap)
    }
}

Type resolveUserType(str name,map[str,Type] aliasMap) {
    if (name == "INTEGER" || name == "BOOLEAN") {
    	return user(id(name));
    }
    nextType = aliasMap[name];
    if (user(nextName) := nextType) {
    	return resolveUserType(nextName,aliasMap);
    }
	return nextType;
} 
