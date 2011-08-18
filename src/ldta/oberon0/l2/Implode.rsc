module ldta::oberon0::l2::Implode

import ldta::oberon0::l2::AST;
import ldta::oberon0::l2::Syntax;

import ParseTree;

public  ldta::oberon0::l2::AST::Module implode(ldta::oberon0::l2::Syntax::Module x) {
	return implode(#ldta::oberon0::l2::AST::Module, x);
}
