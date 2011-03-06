module lang::oberon0::l2::utils::Parse

import lang::oberon0::l1::syntax::Layout;
import lang::oberon0::l1::syntax::Lexical;
import lang::oberon0::l1::syntax::Expressions;
import lang::oberon0::l1::syntax::Types;
import lang::oberon0::l1::syntax::Statements;
import lang::oberon0::l1::syntax::Declarations;
import lang::oberon0::l1::syntax::Modules;

import lang::oberon0::l2::syntax::Statements;

import ParseTree;

public Module parse(loc l) {
	return parse(#Module, l);
}

public Module parse(str s, loc l) {
	return parse(#Module, s, l);
}







