module lang::oberon0::l4::ide::L4

import lang::oberon0::l1::syntax::Modules;
import lang::oberon0::l4::ide::Compile;
import lang::oberon0::l4::ide::JavCompile;
import lang::oberon0::l4::ide::Format;
import lang::oberon0::l4::ide::Obfuscate;
import lang::oberon0::l4::ide::Check;

import lang::oberon0::l3::ide::VisualizeCFG;
import lang::oberon0::l3::ide::Outline;



import lang::oberon0::l4::utils::Parse;

import util::IDE;


private str L4_NAME = "Oberon-0/L4";
private str L4_EXT = "l4";

public set[Contribution] L4_CONTRIBS = {
	popup(
		menu("Oberon",[
    		action("Compile to C", compileModuleToC),
    		action("Compile to Java", compileModuleToJava),
    		edit("Format", formatModule), 
    		edit("Obfuscate (protect your precious oberon0 code!)", obfuscate),
	   		action("Show control flow graphs", visualizeCFG),
	   		action("Compile to Java bytecode and run", compileToJavaBytecodeAndRun)
	    ])
  	)
};

public void registerL4() {
  registerLanguage(L4_NAME, L4_EXT, parse);
  registerOutliner(L4_NAME, outlineModule);
  registerAnnotator(L4_NAME, checkModule);
  registerContributions(L4_NAME, L4_CONTRIBS);
}   

public void main() {
  registerL4();
}

