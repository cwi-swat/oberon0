module lang::oberon0::l1::ide::Compile

import lang::oberon0::l1::syntax::Modules;
import lang::oberon0::l1::compile::Oberon0ToC;
import lang::oberon0::l1::utils::Implode;

import IO;

public void compileModuleToC(Module x, loc l) {
	s = compile2c(implode(x));
	cfile = |<l.scheme>://<l.host><l.path>.c|;
	writeFile(cfile, s);
}