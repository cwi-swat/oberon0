module ldta::oberon0::l4::normalize::ConstantElimination

import ldta::oberon0::l1::AST;
import ldta::oberon0::l3::AST;
import String;
import List;
import IO;
import Set;
import Map;

alias ConstantMap = map[Ident,int];


public Module eliminateConstants(Module m) {
    constantMap = getConstants(m.decls.consts,());
    m.decls.consts = [];
    m.body = top-down-break visit(m.body){
        case Expression e => evaluate(constantMap,e)
    };
    return m;
}

ConstantMap getConstants(list[ConstDecl] constants, ConstantMap constantMap){ 
    for(constDecl(name,exp) <- constants){
        if (nat(i) := evaluate(constantMap,exp)) {
            constantMap[name]=i;
        }
    }
    return constantMap;
}

Expression evaluate(ConstantMap constants, Expression exp){
    return innermost visit(exp){
        case lookup(var,[])         => nat(constants[var]) when (var in constants)
        
        case amp(_, \false())       => \false()
        case amp(\false(), _)       => \false()
        case amp(\true(), \true())  => \true()

        case or(_, \true())         => \true()
        case or(\true(), _)         => \true()
        case or(\false(), \false()) => \false()
        
        case not(\false())          => \true()
        case not(\true())           => \false()
        
        
        case neg(nat(val))          => nat(- val)
        case pos(nat(val))          => nat(val)
        case mul(lhs,nat(0))        => nat(0)
        case mul(nat(0),rhs)        => nat(0)
        case mul(nat(1),rhs)        => rhs
        case mul(lhs,nat(1))        => lhs
        case add(lhs,nat(0))        => lhs
        case add(nat(0),rhs)        => rhs
        case div(lhs,nat(1))        => lhs
        case sub(lhs,nat(0))        => lhs
        case sub(nat(0),rhs)        => neg(rhs)
        case mul(nat(lhs),nat(rhs)) => nat(lhs * rhs)
        case div(nat(lhs),nat(rhs)) => nat(lhs / rhs)
        case \mod(nat(lhs),nat(rhs)) => nat(lhs % rhs)
        case add(nat(lhs),nat(rhs)) => nat(lhs + rhs)
        case sub(nat(lhs),nat(rhs)) => nat(lhs - rhs)
        
        // no side effects in exps, so must be true
        case eq(x,x)                => \true()
        
        case neq(nat(lhs),nat(rhs)) => lhs != rhs ? \true() : \false()
        case lt(nat(lhs),nat(rhs)) => lhs < rhs ? \true() : \false()
        case gt(nat(lhs),nat(rhs)) => lhs > rhs ? \true() : \false()
        case leq(nat(lhs),nat(rhs)) => lhs <= rhs ? \true() : \false()
        case geq(nat(lhs),nat(rhs)) => lhs >= rhs ? \true() : \false()
        case geq(nat(lhs),nat(rhs)) => nat(bool2int(lhs >= rhs))

        // some rewrite rules for cases with unkown variables, like (x + 2) + 3
        case add(add(lhs,nat(v1)),nat(v2)) => add(lhs,nat(v1+v2))
        case add(add(nat(v1),lhs),nat(v2)) => add(lhs,nat(v1+v2))
        case add(nat(v2),add(lhs,nat(v1))) => add(nat(v1+v2),lhs)
        case add(nat(v2),add(nat(v1),lhs)) => add(nat(v1+v2),lhs)
        case mul(mul(lhs,nat(v1)),nat(v2)) => mul(lhs,nat(v1+v2))
        case mul(mul(nat(v1),lhs),nat(v2)) => mul(lhs,nat(v1+v2))
        case mul(nat(v2),mul(lhs,nat(v1))) => mul(nat(v1+v2),lhs)
        case mul(nat(v2),mul(nat(v1),lhs)) => mul(nat(v1+v2),lhs)
        case sub(sub(lhs,nat(v1)),nat(v2)) => sub(lhs,nat(v1+v2))
        case sub(sub(nat(v1),lhs),nat(v2)) => sub(nat(v1-v2),lhs)
        case sub(nat(v2),sub(lhs,nat(v1))) => sub(nat(v1+v2),lhs)
        case sub(nat(v2),sub(nat(v1),lhs)) => add(nat(v1-v2),lhs)
        case div(div(lhs,nat(v1)),nat(v2)) => div(lhs,nat(v1*v2))
        case div(div(nat(v1),lhs),nat(v2)) => div(nat(v1/v2),lhs)
        case div(nat(v1),div(lhs,nat(v2))) => div(nat(v1*v2),lhs)
        case div(nat(v1),div(nat(v2),lhs)) => mul(nat(v1v2),lhs)
    }
}




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