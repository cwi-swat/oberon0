module lang::oberon0::l3::ide::Format

import lang::oberon0::l1::syntax::Modules;
import lang::oberon0::l3::format::Oberon0;
import lang::oberon0::l3::utils::Implode;
import lang::box::util::Box2Text;

import String;
import IO;

public str formatModule(Module x, loc l) {
	return trim(format(mod2box(implode(x))));
}

