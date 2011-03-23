module lang::oberon0::l1::ide::Compile

import lang::oberon0::l1::syntax::Modules;
import lang::oberon0::l1::compile::Oberon0ToC;
import lang::oberon0::l1::utils::Implode;

import IO;

public void compileModuleToC(Module x, loc l) {
	m = implode(x);
	s = compile2c(m);
	cfile = |project://oberon0/src/test/output/<m.name.name>.c|;
	writeFile(cfile, s);
}