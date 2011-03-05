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

import SourceEditor;
import ParseTree;


private str L1_NAME = "Oberon-0/L1";
private str L1_EXT = "l1";

public set[Contribution] L1_CONTRIBS = {
	popup(
		menu("Oberon",[
    		action("Run", runModule) 
	    ])
  	)
};

public void registerL1() {
  registerLanguage(L1_NAME, L1_EXT, parser);
  registerOutliner(L1_NAME, outlineModule);
  registerContributions(L1_NAME, L1_CONTRIBS);
}   

Tree parser(str x, loc l) {
    return parse(#lang::oberon0::l1::syntax::Modules::Module, x, l);
}
 
