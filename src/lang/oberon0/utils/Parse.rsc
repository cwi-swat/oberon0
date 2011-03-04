module lang::oberon0::utils::Parse

import lang::oberon0::syntax::Layout;
import lang::oberon0::syntax::Statements;
import lang::oberon0::syntax::Types;
import lang::oberon0::syntax::Lexical;
import lang::oberon0::syntax::Declarations;
import lang::oberon0::syntax::Expressions;
import lang::oberon0::syntax::Oberon0;

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

public Module parseQuickSort() {
  return parseOberon0Module(|project://oberon0/src/quicksort.oberon0|);
}

public Module parseCollatz() {
  return parseOberon0Module(|project://oberon0/src/collatz.oberon0|);
}

