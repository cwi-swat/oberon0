module lang::oberon0::l3::ide::Compile

import lang::oberon0::l1::\syntax::Modules;
import lang::oberon0::l2::desugar::Desugar;
import lang::oberon0::l3::utils::Implode;
import lang::oberon0::l3::compile::Oberon0ToC;
import lang::oberon0::l3::compile::AnnotateByRefs;
import lang::oberon0::l3::normalize::Normalize;

import IO;

public void compileModuleToC(Module x, loc l) {
	cfile = |project://oberon0/src/test/output/<x.name>.c|;
	writeFile(cfile, compileL3toC(annotateByRefs(normalize(desugar(implode(x))))));
}