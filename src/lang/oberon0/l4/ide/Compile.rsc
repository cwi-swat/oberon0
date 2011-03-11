module lang::oberon0::l4::ide::Compile

import lang::oberon0::l1::syntax::Modules;
import lang::oberon0::l2::desugar::Desugar;
import lang::oberon0::l4::utils::Implode;
import lang::oberon0::l4::compile::Oberon0ToC;
import lang::oberon0::l4::compile::AnnotateByRefs;
import lang::oberon0::l4::normalize::Normalize;
import lang::oberon0::l4::compile::Oberon0ToJavaBytecode;
import lang::jvm::run::RunClassFile;
import lang::jvm::transform::SerializeClass;

import IO;

public void compileModuleToC(Module x, loc l) {
	cfile = |<l.scheme>://<l.host><l.path>.c|;
	writeFile(cfile, compileL4toC(annotateByRefs(normalizeL4(desugar(implode(x))))));
}

void compileToJavaBytecodeAndRun(Module x,loc l) {
	file = |file:///project/oberon0/src/x.name.name|;
	print("hallo!");
	serialize(|file:///project/oberon0/src/x.name.name|, jBytecodeCompilerPipeline(desugar(implode(x))));
	runClassFile(file,|file:///project/oberon0/src/BaseProgram.class|);
	
}