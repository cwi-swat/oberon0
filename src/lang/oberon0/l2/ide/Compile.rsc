module lang::oberon0::l2::ide::Compile

import lang::oberon0::l1::syntax::Modules;
import lang::oberon0::l2::desugar::Desugar;
import lang::oberon0::l2::utils::Implode;
import lang::oberon0::l1::compile::Oberon0ToC;

import IO;

public void compileModuleToC(Module x, loc l) {
	m = implode(x);
	m = desugar(m);
	s = compile2c(m);
	cfile = |<l.scheme>://<l.host><l.path>.c|;
	writeFile(cfile, s);
}