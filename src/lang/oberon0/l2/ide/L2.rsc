module lang::oberon0::l2::ide::L2

import lang::oberon0::l1::syntax::Modules;
import lang::oberon0::l1::syntax::Declarations;
import lang::oberon0::l1::syntax::Expressions;
import lang::oberon0::l1::syntax::Statements;
import lang::oberon0::l1::syntax::Types;
import lang::oberon0::l1::syntax::Lexical;
import lang::oberon0::l1::syntax::Layout;

import lang::oberon0::l2::syntax::Statements;
import lang::oberon0::l2::ide::Run;
import lang::oberon0::l2::ide::Format;

import lang::oberon0::l1::ide::Outline;

//import lang::oberon0::l2::ide::Run;
//import lang::oberon0::l1::ide::Format;
//import lang::oberon0::l1::ide::VisualizeCFG;

import SourceEditor;
import ParseTree;


private str L2_NAME = "Oberon-0/L2";
private str L2_EXT = "l2";

public set[Contribution] L2_CONTRIBS = {
	popup(
		menu("Oberon",[
    		action("Run", runModule),
    		action("Format", formatModule) 
//   		action("CFlow", visualizeCFG) 
	    ])
  	)
};

public void registerL2() {
  registerLanguage(L2_NAME, L2_EXT, parser);
  registerOutliner(L2_NAME, outlineModule);
  registerContributions(L2_NAME, L2_CONTRIBS);
}   

Tree parser(str x, loc l) {
    return parse(#lang::oberon0::l1::syntax::Modules::Module, x, l);
}

