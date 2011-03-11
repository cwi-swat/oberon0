module lang::oberon0::l3::optimize::ConstantElimination

import lang::oberon0::l3::ast::Oberon0;
extend lang::oberon0::l1::optimize::ConstantElimination;

public Module eliminateConstantsL3(Module m) {
	constantMap = getConstants(m.decls.consts,());
	m.decls.consts = [];
	return top-down-break visit(m){
		case Procedure p => eliminateConstantsInProcedure(p,constantMap)
		case Expression e => evaluate(constantMap,e)
    };
}

Procedure eliminateConstantsInProcedure(Procedure p,ConstantMap constantMap){
	constantMap = getConstants(p.decls.consts,constantMap);
    return top-down-break visit(p){
            case Procedure p2 => constantEliminationInProcedure(constantMap,p2) when p2 != p
            case Expression e => evaluate(constantMap,e)
    };
}