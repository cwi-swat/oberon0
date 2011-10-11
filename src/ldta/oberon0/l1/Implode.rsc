module ldta::oberon0::l1::Implode

import ldta::oberon0::l1::AST;

import ParseTree;

public  Module implode(Tree x) {
	return implode(#Module, x);
}
