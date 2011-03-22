module lang::oberon0::l1::ide::L1

import lang::oberon0::l1::syntax::Modules;
import lang::oberon0::l1::syntax::Declarations;
import lang::oberon0::l1::syntax::Expressions;
import lang::oberon0::l1::syntax::Statements;
import lang::oberon0::l1::syntax::Types;
import lang::oberon0::l1::syntax::Lexical;
import lang::oberon0::l1::syntax::Layout;
import lang::oberon0::l1::ide::Outline;
import lang::oberon0::l1::ide::Run;
import lang::oberon0::l1::ide::Compile;
import lang::oberon0::l1::ide::Check;
import lang::oberon0::l1::ide::Format;
import lang::oberon0::l1::ide::VisualizeCFG;

import util::IDE;
import ParseTree;


private str L1_NAME = "Oberon-0/L1";
private str L1_EXT = "l1";

public set[Contribution] L1_CONTRIBS = {
	popup(
		menu("Oberon",[
    		action("Run", runModule),
    		edit("Format", formatModule), 
    		action("CFlow", visualizeCFG),
    		action("To C", compileModuleToC) 
	    ])
  	)
};

public void registerL1() {
  registerLanguage(L1_NAME, L1_EXT, parser);
  registerOutliner(L1_NAME, outlineModule);
  registerAnnotator(L1_NAME, checkModule);
  registerContributions(L1_NAME, L1_CONTRIBS);
}   

Tree parser(str x, loc l) {
    return parse(#lang::oberon0::l1::syntax::Modules::Module, x, l);
}

