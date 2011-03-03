module languages::oberon0::normalize::RemoveTypeAliases

import languages::oberon0::ast::Oberon0;
import languages::oberon0::normalize::Utils;

// precondition: resolveTypes, resolveProcs, resolveConsts, liftTypes, liftProcs, constantElimination

public Module removeTypeAliases(Module m) {
    aliasMap = ( \alias : \type  | /typeDecl(\alias,\type) <- m.decls.types );
    m.decls.types = [];
    return visit(m){
        case user(id(name)) => resolveUserType(name,aliasMap)
    }
}

Type resolveUserType(str name,map[str,Type] aliasMap) {
    if(name == "INTEGER" || name == "BOOLEAN") return user(id(name));
    nextType = aliasMap[name];
    return if( user(nextName) := nextType) resolveUserType(nextName,aliasMap);
           else nextType;
} 
