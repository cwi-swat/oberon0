module lang::oberon0::l3::analyze::Aliases

import lang::oberon0::l3::ast::Oberon0;
import lang::oberon0::l3::resolve::SymbolTable;
import lang::oberon0::l1::resolve::NameAnnotator;
import Relation;
import List;

//
// Aliasing information is kept at a very high level -- we say that two
// items (variables) may alias one another if, at any point in the program,
// they may alias one another (the analysis is flow-, path-, and 
// context-insensitive).
//
alias MayAlias = rel[Item,Item];

private list[tuple[&A,&B]] zip(list[&A] a, list[&B] b) {
	if (size(a) != size(b)) throw "zip: both lists must have the same size!";
	if (size(a) == 0) return [ ];
	return [ <a[n],b[n]> | n <- [0..size(a)-1] ];
}

public MayAlias mayAlias(Module m) {
	MayAlias maSeed = { <v,v> | /i:Ident n <- m, (i@item)?, v:Variable(_,_,_) := i@item || v:FormalParameter(_,_,_,_) := i@item };
	MayAlias ma = maSeed;
	
	solve(ma) {
		ma = ma + { < fpi1, fpi2 >, <fpi2, fpi1> | /c:call(v,as) <- m, p:Procedure(_,ps,_) := v@item, zl := zip(ps,as), [_*,<fpi1:FormalParameter(_,_,true,_),lookup(ve1)>,_*,<fpi2:FormalParameter(_,_,true,_),lookup(ve2)>,_*] := zl, <ve1@item,ve2@item> in ma };
	}

	ma = ma - maSeed;
		
	return ma;
}