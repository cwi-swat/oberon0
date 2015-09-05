module ldta::oberon0::l4::normalize::NormalizeL3

import ldta::oberon0::l4::normalize::LiftConsts;
import ldta::oberon0::l4::normalize::LiftTypes;
import ldta::oberon0::l4::normalize::LiftProcs;
import ldta::oberon0::l4::normalize::ResolveConsts;
import ldta::oberon0::l4::normalize::ResolveTypes;
import ldta::oberon0::l4::normalize::ResolveProcs;
import ldta::oberon0::l3::AST;

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