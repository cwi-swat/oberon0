module ldta::oberon0::l3::Implode

import ldta::oberon0::l3::Syntax;
import ldta::oberon0::l3::AST;

import ParseTree;

public ldta::oberon0::l3::AST::Module implode(ldta::oberon0::l1::Syntax::Module pt) {
	return implode(#ldta::oberon0::l3::AST::Module, pt);
}

