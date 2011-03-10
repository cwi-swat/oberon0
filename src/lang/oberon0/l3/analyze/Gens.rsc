module lang::oberon0::l3::analyze::Gens

import lang::oberon0::l3::ast::Oberon0;
import lang::oberon0::l3::resolve::SymbolTable;
import lang::oberon0::l3::extract::ControlFlow;
import lang::oberon0::l3::analyze::Defs;
import Relation;
//
// Calculate gens for a CF node. This logic works under the assumption that
// a node cannot kill anything it defines. If the language changes to allow
// this (e.g., functions with VAR parameters) then we will need to calculate
// gens differently.
//
public set[Def] IGen(nd, defs) = { <i,nd> | i <- invert(defs)[nd] };

