module lang::oberon0::l1::ide::Compile

import lang::oberon0::l1::\syntax::Modules;
import lang::oberon0::l1::compile::Oberon0ToC;
import lang::oberon0::l1::utils::Implode;

import IO;

public void compileModuleToC(lang::oberon0::l1::\syntax::Modules::Module x, loc l) {
	cfile = |project://oberon0/src/test/output/<x.name>.c|;
	writeFile(cfile, compile2c(implode(x)));
}