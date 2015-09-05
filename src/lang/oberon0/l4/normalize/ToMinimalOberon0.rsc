module lang::oberon0::l4::normalize::ToMinimalOberon0

import lang::oberon0::l4::ast::Oberon0;
import lang::oberon0::l4::normalize::Normalize;
import lang::oberon0::l4::normalize::RemoveTypeAliases;
import lang::oberon0::l4::normalize::ExplicitStack;
import lang::oberon0::l3::optimize::ConstantElimination;
import lang::oberon0::l4::normalize::SingleWordAssign;

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