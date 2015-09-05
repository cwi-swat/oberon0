module lang::oberon0::l4::ide::JavCompile

import lang::oberon0::l1::\syntax::Modules;
import lang::oberon0::l2::desugar::Desugar;
import lang::oberon0::l4::utils::Implode;
import lang::oberon0::l4::normalize::ToMinimalOberon0;
import lang::oberon0::l4::compile::Oberon0ToJavaBytecode;
import lang::jvm::run::RunClassFile;
import lang::jvm::transform::SerializeClass;
import lang::oberon0::l4::compile::Oberon0ToJava;

import IO;

public void compileToJavaBytecodeAndRun(Module x,loc l) {
	loc classFile = |project://oberon0/src/test/output/<x.name>.class|;
	serialize(compile2JavaBytecode(toMinimalOberon0(desugar(implode(x)))),classFile);
	runClassFile(classFile,|project://oberon0/src/test/output/BaseProgram.class|);
	
}

public void compileModuleToJava(Module x, loc l) {
	jfile = |project://oberon0/src/test/output/<x.name>.java|;
	writeFile(jfile, compile2Java(toMinimalOberon0(desugar(implode(x)))));
}