module lang::oberon0::l4::ide::ToExplicitStack

import lang::oberon0::l1::syntax::Modules;
import lang::oberon0::l4::format::Oberon0;
import lang::oberon0::l4::utils::Implode;
import lang::oberon0::l4::ast::Oberon0;
import lang::oberon0::l3::compile::AnnotateByRefs;
import lang::oberon0::l4::normalize::Normalize;
import lang::oberon0::l4::normalize::RemoveTypeAliases;
import lang::oberon0::l4::normalize::ExplicitStack;
import lang::oberon0::l3::optimize::ConstantElimination;
import lang::box::util::Box2Text;

import String;

public str toExplicitStack(lang::oberon0::l1::syntax::Modules::Module x, loc l) {
	lang::oberon0::l4::ast::Oberon0::Module mod = implode(x);
	mod = (normalizeBooleans o normalizeL4  o removeTypeAliases o eliminateConstantsL3  o explicitStack)(mod);
	return trim(format(mod2box(mod)));
}