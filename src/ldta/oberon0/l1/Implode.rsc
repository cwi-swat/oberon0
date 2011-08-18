module ldta::oberon0::l1::Implode

import ldta::oberon0::l1::AST;
import ldta::oberon0::l1::Syntax;

import ParseTree;

public  ldta::oberon0::l1::AST::Module implode(ldta::oberon0::l1::Syntax::Module x) {
	return implode(#ldta::oberon0::l1::AST::Module, x);
}
