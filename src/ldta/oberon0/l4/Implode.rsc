module ldta::oberon0::l4::Implode

import ldta::oberon0::l4::Syntax;
import ldta::oberon0::l4::AST;

import ParseTree;

public ldta::oberon0::l4::AST::Module implode(ldta::oberon0::l4::Syntax::Module pt) {
	return implode(#ldta::oberon0::l4::AST::Module, pt);
}
