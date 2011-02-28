module Plugin

import SourceEditor;
import languages::oberon0::syntax::Oberon0;
import languages::oberon0::syntax::Declarations;
import languages::oberon0::syntax::Expressions;
import languages::oberon0::syntax::Layout;
import languages::oberon0::syntax::Types;
import languages::oberon0::syntax::Lexical;
import languages::oberon0::syntax::Statements;
import languages::oberon0::extract::ControlFlow;
import IO;
import ParseTree;

public void main() {
  registerLanguage("Oberon-0", "oberon0", parser);
  registerOutliner("Oberon-0", outline);
  registerContributions("Oberon-0", contribs);
}   

Tree parser(str x, loc l) {
    return parse(#Module, x, l);
}
 
node outline(Module x) {
  return "MODULE"("PROCEDURES"(["proc"()[@label="<p.name>"][@\loc=p@\loc] | /ProcedureDecl p := x]))[@label="<x.name>"];
}

private set[Contribution] contribs = {
  popup(menu("Oberon",[
    action("Control flow graph", Module (Module x, loc selection) { 
      visControlFlow(getControlFlow(implode(#languages::oberon0::ast::Oberon0::Module, x)));
      return x;
    }) 
    ])
  )
};