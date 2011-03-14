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
import lang::oberon0::l4::ast::Oberon0;

import IO;

public void compileModuleToC(lang::oberon0::l1::syntax::Modules::Module x, loc l) {
	cfile = |<l.scheme>://<l.host><l.path>.c|;
	writeFile(cfile, compileL4toC(annotateByRefs(normalizeL4(desugar(implode(x))))));
}


public void compileToJavaBytecodeAndRun(lang::oberon0::l1::syntax::Modules::Module x,loc l) {
	lang::oberon0::l4::ast::Oberon0::Module mod = desugar(implode(x));
	loc classFile = |project://oberon0/src/<mod.name.name>.class|;
	serialize(jBytecodeCompilerPipeline(mod),classFile);
	runClassFile(classFile,|project://oberon0/src/BaseProgram.class|);
	
}