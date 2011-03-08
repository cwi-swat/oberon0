module lang::oberon0::l1::optimize::ConstantElimination

import lang::oberon0::l1::ast::Oberon0;

import String;
import List;
import IO;
import Set;
import Map;

alias ConstantMap = map[str,int];

public Module eliminateConstants(Module m) {
	constantMap = getConstants(m.decls.consts,());
	m.decls.consts = [];
	m.body = top-down-break visit(m.body){
		case Expression e => evaluate(constantMap,e)
    };
    return m;
}

ConstantMap getConstants(list[ConstDecl] constants, ConstantMap constantMap){ 
	for(constDecl(id(name),exp) <- constants){
		if (nat(i) := evaluate(constantMap,exp)) {
			constantMap+=(name:i);
		}
 	}
	return constantMap;
}


int bool2int(bool truth){
	return truth? 1 :0;
}

bool int2bool(int truth){
	return truth!=0;
}

Expression evaluate(ConstantMap constants, Expression exp){
	return innermost visit(exp){
		case lookup(id(var),[])     :  if(var in constants) insert nat(constants[var]);
		case neg(nat(val))          => nat(val)
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
		case mod(nat(lhs),nat(rhs)) => nat(lhs % rhs)
		case add(nat(lhs),nat(rhs)) => nat(lhs + rhs)
		case sub(nat(lhs),nat(rhs)) => nat(lhs - rhs)
		case amp(nat(lhs),nat(rhs)) => nat(bool2int(int2bool(lhs) && int2bool(rhs)))
		case or(nat(lhs),nat(rhs))  => nat(bool2int(int2bool(lhs) || int2bool(rhs)))
		case eq(nat(lhs),nat(rhs))  => nat(bool2int(lhs == rhs))
		case neq(nat(lhs),nat(rhs)) => nat(bool2int(lhs == rhs))
		case lt(nat(lhs),nat(rhs))  => nat(bool2int(lhs < rhs))
		case gt(nat(lhs),nat(rhs))  => nat(bool2int(lhs > rhs))
		case leq(nat(lhs),nat(rhs)) => nat(bool2int(lhs <= rhs))
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







	
