module languages::oberon0::normalize::LiftConsts

import languages::oberon0::ast::Oberon0;

public Module liftConsts(Module mod) {
	mod.decls.procs = visit (mod.decls.procs) {
		case Declarations decls: {
			mod.decls.consts += decls.consts;
			decls.consts = [];
			insert decls;
		}
	}
	return mod;
}

