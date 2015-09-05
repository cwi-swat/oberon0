module lang::oberon0::l3::analyze::Defs

import lang::oberon0::l3::ast::Oberon0;
import lang::oberon0::l3::resolve::SymbolTable;
import lang::oberon0::l3::extract::ControlFlow;
import lang::oberon0::l1::resolve::NameAnnotator;
import List;

alias Def = tuple[Item,CFNode];

anno rel[Ident,loc] Statement@defUses;
anno rel[Ident,loc] Procedure@defUses;
anno rel[Ident,loc] Module@defUses;
anno set[CFNode] Ident@useDefs;

//
// Get defs for a CF node.
//
public set[Def] IDef(nd:statement(_,s:assign(v,_))) = { < v@item, nd > };
public set[Def] IDef(nd:statement(_,s:call(v,as))) {
	if (size(as) == 0) return { };
	if (Procedure(_,ps,_) := v@item) return { < v@item, nd > | idx <- [0..size(ps)-1], FormalParameter(_,_,true,_) := ps[idx], lookup(v) := as[idx] };
	return { }; 
}
public set[Def] IDef(nd:statement(_,s:forDo(v,_,_,_))) = { < v@item, nd > };
default set[Def]  IDef(_) = { };

