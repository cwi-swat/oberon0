module lang::oberon0::l3::normalize::Normalize

import lang::oberon0::l3::normalize::LiftConsts;
import lang::oberon0::l3::normalize::LiftTypes;
import lang::oberon0::l3::normalize::LiftProcs;
import lang::oberon0::l3::normalize::ResolveConsts;
import lang::oberon0::l3::normalize::ResolveTypes;
import lang::oberon0::l3::normalize::ResolveProcs;
import lang::oberon0::l3::ast::Oberon0;

public Module normalize(Module mod) {
	return (resolveConsts o resolveTypes o resolveProcs o extendSignatures o liftConsts o liftTypes o liftProcs)(mod);
}

