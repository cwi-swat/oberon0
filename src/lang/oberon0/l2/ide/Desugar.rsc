module lang::oberon0::l2::ide::Desugar

import lang::oberon0::l2::desugar::Desugar;

import lang::oberon0::l1::\syntax::Modules;
import lang::oberon0::l2::format::Oberon0;
import lang::oberon0::l2::utils::Implode;
import lang::box::util::Box2Text;

import String;

public str desugarModule(Module x, loc l) {
	return trim(format(mod2box(desugar(implode(x)))));
}
