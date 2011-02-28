module Plugin

import SourceEditor;
import languages::oberon0::syntax::Oberon0;
import languages::oberon0::syntax::Declarations;
import languages::oberon0::syntax::Expressions;
import languages::oberon0::syntax::Layout;
import languages::oberon0::syntax::Types;
import languages::oberon0::syntax::Lexical;
import languages::oberon0::syntax::Statements;

import ParseTree;

public void main() {
  registerLanguage("Oberon-0", "oberon0", Tree (str x, loc l) {
    return parse(#Module, x, l);
  });
  registerOutliner("Oberon-0", outline);
}   

node outline(Module x) {
  return "MODULE"("PROCEDURES"(["proc"()[@label="<p.name>"][@\loc=p@\loc] | /ProcedureDecl p := x]))[@label="<x.name>"];
}