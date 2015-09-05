module lang::oberon0::l3::ide::L3

import lang::oberon0::l1::\syntax::Modules;
import lang::oberon0::l3::ide::Compile;
import lang::oberon0::l3::ide::Format;
import lang::oberon0::l3::ide::Check;
import lang::oberon0::l3::ide::VisualizeCFG;
import lang::oberon0::l3::ide::Normalize;
import lang::oberon0::l3::ide::Outline;

import lang::oberon0::l3::utils::Parse;

import util::IDE;


private str L3_NAME = "Oberon-0/L3";
private str L3_EXT = "l3";

public set[Contribution] L3_CONTRIBS = {
	popup(
		menu("Oberon",[
    		action("Compile to C", compileModuleToC),
    		edit("Format", formatModule), 
    		edit("Normalize", normalizeModule), 
	   		action("CFlow", visualizeCFG) 
	    ])
  	)
};

public void registerL3() {
  registerLanguage(L3_NAME, L3_EXT, parse);
  registerOutliner(L3_NAME, outlineModule);
  registerAnnotator(L3_NAME, checkModule);
  registerContributions(L3_NAME, L3_CONTRIBS);
}   


