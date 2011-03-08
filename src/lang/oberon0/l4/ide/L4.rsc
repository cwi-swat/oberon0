module lang::oberon0::l4::ide::L4

import lang::oberon0::l1::syntax::Modules;
import lang::oberon0::l4::ide::Compile;
import lang::oberon0::l4::ide::Format;
import lang::oberon0::l4::ide::Check;

import lang::oberon0::l3::ide::VisualizeCFG;
import lang::oberon0::l3::ide::Outline;

import lang::oberon0::l4::utils::Parse;

import SourceEditor;


private str L4_NAME = "Oberon-0/L4";
private str L4_EXT = "l4";

public set[Contribution] L4_CONTRIBS = {
	popup(
		menu("Oberon",[
    		action("Compile", compileModuleToC),
    		edit("Format", formatModule), 
	   		action("CFlow", visualizeCFG) 
	    ])
  	)
};

public void registerL4() {
  registerLanguage(L4_NAME, L4_EXT, parse);
  registerOutliner(L4_NAME, outlineModule);
  registerAnnotator(L4_NAME, checkModule);
  registerContributions(L4_NAME, L4_CONTRIBS);
}   


