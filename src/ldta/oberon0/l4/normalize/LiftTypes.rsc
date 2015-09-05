module ldta::oberon0::l4::normalize::LiftTypes

import ldta::oberon0::l4::AST;

public Module liftTypes(Module \mod) {
	\mod.decls.procs = visit (\mod.decls.procs) {
		case Declarations decls: {
			\mod.decls.types = decls.types + \mod.decls.types;
			decls.types = [];
			insert decls;
		}
	}
	return \mod;
}

