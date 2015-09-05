module lang::oberon0::l1::ide::Format

import lang::oberon0::l1::\syntax::Modules;
import lang::oberon0::l1::format::Oberon0;
import lang::oberon0::l1::utils::Implode;
import lang::box::util::Box2Text;

import String;

public str formatModule(Module x, loc selection) {
	return trim(format(mod2box(implode(x))));
}

