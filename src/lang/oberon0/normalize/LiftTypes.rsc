module lang::oberon0::normalize::LiftTypes

import lang::oberon0::ast::Oberon0;

public Module liftTypes(Module mod) {
	mod.decls.procs = visit (mod.decls.procs) {
		case Declarations decls: {
			mod.decls.types = decls.types + mod.decls.types;
			decls.types = [];
			insert decls;
		}
	}
	return mod;
}

