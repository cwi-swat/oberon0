module lang::oberon0::l3::analyze::UseDef

import lang::oberon0::l3::ast::Oberon0;
import lang::oberon0::l3::resolve::SymbolTable;
import lang::oberon0::l1::resolve::NameAnnotator;
import lang::oberon0::l3::extract::CallGraph;
import lang::oberon0::l3::extract::ControlFlow;
import lang::oberon0::l3::analyze::Aliases;
import Relation;
import List;
import Set;
import Graph;

alias Def = tuple[Item,CFNode];
anno rel[Ident,loc] Statement@defUses;
anno rel[Ident,loc] Procedure@defUses;
anno rel[Ident,loc] Module@defUses;
anno set[CFNode] Ident@useDefs;

//
// Compute the local defs, made up of all direct definitions and all
// definitions through may-aliases.
//
public set[Def] computeLocalDefs(ControlFlowGraph cfg, MayAlias ma) {
	set[Def] localDefs = { d | CFNode nd <- carrier(cfg.graph), d <- IDef(nd) };
	localDefs = localDefs + { <j,nd> | <i,nd> <- localDefs, j <- ma[i] };
	return localDefs;
}

//
// Compute all the defs contained in this CFG, which consists of the local defs
// augmented with the non-local defs created by each procedure call.
// 
public set[Def] computeAllDefs(ControlFlowGraph cfg, CallGraph cg, MayAlias ma, rel[Item,Def] procedureDefs, SymbolTable st) {
	SymbolTable ist = invert(st);
	set[Def] localDefs = computeLocalDefs(cfg,ma);
	set[Item] calledProcs = { v@item | statement(_,call(v,_)) <- carrier(cfg.graph) };
	set[Item] reachableProcs = (cg*)[calledProcs];
	rel[Item,Item] nonLocalDefs = { <pi,pd> | pi <- reachableProcs, <pd,_> <- procedureDefs[pi], pi notin ist[pd] };
	set[Def] allDefs = localDefs + { <i,nd> | nd:statement(_,call(v,_)) <- carrier(cfg.graph), i <- nonLocalDefs[v@item]};
	return allDefs;
}

//
// Compute reaching definitions for each node in the CFG.
//
public tuple[rel[CFNode,Def] IN, rel[CFNode,Def] OUT] reachingDefinitions(Item current, ControlFlowGraph cfg, CallGraph cg, MayAlias ma, rel[Item,Def] procedureDefs, SymbolTable st) {
	// First, get all DEFs in the CFG -- this is needed for calculating KILLs
	set[Def] allDefs = computeAllDefs(cfg,cg,ma,procedureDefs,st);
	
	// Initialize the KILL and GEN sets with information from the CFG
	rel[CFNode,Def] KILL = { <nd,d> |  nd <- carrier(cfg.graph), d <- IKill(nd,allDefs) };
	rel[CFNode,Def] GEN = { <nd,d> | nd <- carrier(cfg.graph), d <- IGen(nd,allDefs) };
	
	// Calculate the IN set for the start node: this will consist of the non-local vars
	// and the formal parameters used or defined in this call graph. Note that this means
	// that formal parameters that aren't actually used in the procedure are not added
	// to IN.
	set[Item] inItems = { i@item | /lookup(i) <- cfg.graph, (i@item)?, (Variable(_,_,_) := i@item && i@item notin st[current]) || FormalParameter(_,_,_,_) := i@item };
	rel[CFNode, Def] INEntry = { <cfg.start, <i,cfg.start>> | i <- inItems };
	
	// Perform the fixpoint computation to calculate IN and OUT. This calculation is based on the
	// equations given on page 355 of Appel's Modern Compiler Implementation in Java, 2nd ed.,
	// extended to add the IN entries for the entry node.
	rel[CFNode, Def] IN = { };
	rel[CFNode, Def] OUT = { };
	cfgPred = invert(cfg.graph);
	solve(IN,OUT) {
		IN  = { <nd,d> | CFNode nd <- carrier(cfgPred), p <- cfgPred[nd], d <- OUT[p] } + INEntry;
		OUT = { <nd,d> | CFNode nd <- carrier(cfgPred), d <- (GEN[nd] + (IN[nd] - KILL[nd])) };
	}
	
	return <IN, OUT>;
}

public Module useDefAnalysis(Module m, SymbolTable st) {
	// Perform analyses needed for the reaching definitions analysis
	MayAlias ma = mayAlias(m);
	CallGraph cg = generateCallGraph(m);
	map[Item,ControlFlowGraph] CFGs = ( m.name@item : getControlFlow(m)) + ( p.name@item : getControlFlow(p) | /Procedure p <- m.decls );
	rel[Item,Def] procedureDefs = { <i,d> | i:Procedure(_,_,_) <- CFGs<0>, d <- computeLocalDefs(CFGs[i],ma) };

	// Actually perform the reaching definitions analysis over all CFGs
	map[Item,tuple[rel[CFNode,Def] IN, rel[CFNode,Def] OUT]] inAndOut =
		( i : reachingDefinitions(i,CFGs[i],cg,ma,procedureDefs,st) | i <- CFGs<0> );
				 
	// Annotate the module with ud- and du-chains.
	// - For each use of a variable or formal parameter, the ud-chain will include all statements
	//   responsible for the reaching definition
	// - For each defining statement, the du-chain will include all identifiers that the statement's
	//   definition can reach
	//
	// TODO: If Expressions can ever be defs, we will need to change this appropriately 

	// Calculate the udChain information. Item itm is the procedure or module whose IN/OUT information
	// is being used. We then go through each IN tuple, which includes the CFG node (nd) and a
	// definition (di, the defined item, and dn, the defining statement node, made up of an
	// elided location and the defining statement itself, ndd). Using this, we then check each
	// identifier i in the CFG node nd, including i, the location of i, the defining statement ndd,
	// and the location of this statement when the identifier's item is the same as the defined item.
	rel[Ident,loc,CFNode] udChains = { <i,i@location,dn> | 
											  Item itm <- inAndOut<0>, 
								  	  	      <nd,<di,dn>> <- inAndOut[itm][0], 
								  	  	      /lookup(i) <- nd, (i@item)?, i@item == di };
	// Flip the udChains to get, for each defining statement, the identifiers the def reaches. 										
	rel[CFNode,Ident,loc] duChains = { <d,dl,i,l> | <i,l,d,dl> <- udChains };
	
	// Now, using the computed udChains and duChains, annotate the module
	m = visit(m) {
		case Ident i => i[@useDefs = udChains[i,i@location]]
		case Statement s => s[@defUses = duChains[statement(s@location,s)]]
		case Procedure p => p[@defUses = duChains[start(p@location,p)]]
		case Module mp => mp[@defUses = duChains[start(mp@location,mp)]]
	}
	
	return m;
}

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
public set[Def] default IDef(_) = { };

//
// Get kills for a CF node.
//
public set[Def] IKill(nd:statement(_,assign(v,_)), defs) = { k | k:<i,_> <- defs, i := v@item } - {<v@item,nd>};
public set[Def] IKill(nd:statement(_,forDo(v,_,_,_)), defs) = { k | k:<i,_> <- defs, i := v@item } - {<v@item,nd>};
public set[Def] default IKill(_,_) = { };

//
// Calculate gens for a CF node. This logic works under the assumption that
// a node cannot kill anything it defines. If the language changes to allow
// this (e.g., functions with VAR parameters) then we will need to calculate
// gens differently.
//
public set[Def] IGen(nd, defs) = { <i,nd> | i <- invert(defs)[nd] };

