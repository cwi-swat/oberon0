module lang::oberon0::l3::normalize::NormalizeL3

import lang::oberon0::l3::normalize::LiftConsts;
import lang::oberon0::l3::normalize::LiftTypes;
import lang::oberon0::l3::normalize::LiftProcs;
import lang::oberon0::l3::normalize::ResolveConsts;
import lang::oberon0::l3::normalize::ResolveTypes;
import lang::oberon0::l3::normalize::ResolveProcs;
import lang::oberon0::l3::ast::Oberon0;

public Module normalize(Module \mod) {
	return (normalizeDecls 
			o resolveConsts 
			o resolveTypes 
			o resolveProcs 
			o extendSignatures 
			o liftConsts 
			o liftTypes 
			o liftProcs)(\mod);
}

Module normalizeDecls(Module \mod) {
	return visit (\mod) {
		case decls(c, t, v) => decls(c, t, v, [])
	}
}