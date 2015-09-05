module ldta::oberon0::l4::normalize::ToMinimalOberon0

import ldta::oberon0::l4::AST;
import ldta::oberon0::l4::normalize::NormalizeL4;
import ldta::oberon0::l4::normalize::RemoveTypeAliases;
import ldta::oberon0::l4::normalize::ExplicitStack;
import ldta::oberon0::l4::normalize::ConstantElimination;
import ldta::oberon0::l4::normalize::SingleWordAssign;

public Module toMinimalOberon0(Module m) {
	return 
	(normalizeL4 o
	 normalizeBooleans o 
	 removeTypeAliases o
	 eliminateConstantsL3 o
	 toSingleWordAssign o
	 toExplicitStack o  
	 eliminateConstantsL3)(m);
}