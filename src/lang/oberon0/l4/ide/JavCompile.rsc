module lang::oberon0::l4::ide::JavCompile

import lang::oberon0::l1::syntax::Modules;
import lang::oberon0::l2::desugar::Desugar;
import lang::oberon0::l4::utils::Implode;
import lang::oberon0::l4::compile::Oberon0ToJavaBytecode;
import lang::jvm::run::RunClassFile;
import lang::jvm::transform::SerializeClass;
import lang::oberon0::l4::ast::Oberon0;
import lang::oberon0::l4::compile::Oberon0ToJava;

import IO;



public void compileToJavaBytecodeAndRun(lang::oberon0::l1::syntax::Modules::Module x,loc l) {
	lang::oberon0::l4::ast::Oberon0::Module mod = desugar(implode(x));
	loc classFile = |project://oberon0/src/<mod.name.name>.class|;
	serialize(jBytecodeCompilerPipeline(mod),classFile);
	runClassFile(classFile,|project://oberon0/src/BaseProgram.class|);
	
}

public void compileModuleToJava(lang::oberon0::l1::syntax::Modules::Module x, loc l) {
	lang::oberon0::l4::ast::Oberon0::Module mod = desugar(implode(x));
	jfile = |project://oberon0/src/<mod.name.name>.java|;
	writeFile(jfile, javBytecodeCompilerPipeline(desugar(implode(x))));
}