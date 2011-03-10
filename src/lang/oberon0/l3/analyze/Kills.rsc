module lang::oberon0::l3::analyze::Kills

import lang::oberon0::l3::ast::Oberon0;
import lang::oberon0::l3::resolve::SymbolTable;
import lang::oberon0::l3::extract::ControlFlow;
import lang::oberon0::l3::analyze::Defs;
import lang::oberon0::l1::resolve::NameAnnotator;

//
// Get kills for a CF node.
//
public set[Def] IKill(nd:statement(_,assign(v,_)), defs) = { k | k:<i,_> <- defs, i := v@item } - {<v@item,nd>};
public set[Def] IKill(nd:statement(_,forDo(v,_,_,_)), defs) = { k | k:<i,_> <- defs, i := v@item } - {<v@item,nd>};
public set[Def] default IKill(_,_) = { };

