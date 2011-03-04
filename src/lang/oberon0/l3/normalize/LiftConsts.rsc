module lang::oberon0::l3::normalize::LiftConsts

import lang::oberon0::l3::ast::Oberon0;

public Module liftConsts(Module mod) {
	mod.decls.procs = visit (mod.decls.procs) {
		case Declarations decls: {
			mod.decls.consts = decls.consts + mod.decls.consts;
			decls.consts = [];
			insert decls;
		}
	}
	return mod;
}

