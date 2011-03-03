module languages::oberon0::normalize::Normalize

import languages::oberon0::normalize::LiftConsts;
import languages::oberon0::normalize::LiftTypes;
import languages::oberon0::normalize::LiftProcs;
import languages::oberon0::normalize::ResolveConsts;
import languages::oberon0::normalize::ResolveTypes;
import languages::oberon0::normalize::ResolveProcs;
import languages::oberon0::normalize::RemoveTypeAliases;
import languages::oberon0::normalize::ExplicitStack;
import languages::oberon0::compile::AnnotateByRefs;
import languages::oberon0::optimize::ConstantElimination;
import languages::oberon0::ast::Oberon0;

public Module normalize(Module mod) {
	return (resolveConsts o resolveTypes o resolveProcs o extendSignatures o liftConsts o liftTypes o liftProcs)(mod);
}

public Module normalizeMore(Module mod) {
	return (constantElimination o normalize o removeTypeAliases  o explicitStack o constantElimination)(mod);
}
