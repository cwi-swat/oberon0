module ldta::oberon0::l4::normalize::LiftConsts

import ldta::oberon0::l4::AST;

public Module liftConsts(Module \mod) {
	\mod.decls.procs = visit (\mod.decls.procs) {
		case Declarations decls: {
			\mod.decls.consts = decls.consts + \mod.decls.consts;
			decls.consts = [];
			insert decls;
		}
	}
	return \mod;
}

