module Plugin

import SourceEditor;
import languages::oberon0::syntax::Oberon0;
import ParseTree;

public void main() {
  registerLanguage("Oberon-0", "oberon0", Tree (str x) {
    return parse(#Module, x);
  });
}