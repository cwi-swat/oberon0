module languages::oberon0::utils::Parse

import languages::oberon0::syntax::Layout;
import languages::oberon0::syntax::Statements;
import languages::oberon0::syntax::Types;
import languages::oberon0::syntax::Lexical;
import languages::oberon0::syntax::Declarations;
import languages::oberon0::syntax::Expressions;
import languages::oberon0::syntax::Oberon0;

import ParseTree;

public Module parseOberon0Module(str src) {
  return parse(#Module, src);
}

public Module parseOberon0Module(loc src) {
  return parse(#Module, src);
}

public Module parseSample() {
  return parseOberon0Module(|project://oberon0/src/sample.oberon0|);
}
