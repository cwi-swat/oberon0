module lang::oberon0::l3::ide::Normalize

import lang::oberon0::l1::\syntax::Modules;
import lang::oberon0::l2::desugar::Desugar;
import lang::oberon0::l3::utils::Implode;
import lang::oberon0::l3::normalize::Normalize;
import lang::oberon0::l3::format::Oberon0;
import lang::box::util::Box2Text;

import String;

public str normalizeModule(Module x, loc l) {
	return trim(format(mod2box(normalize(implode(x)))));
}