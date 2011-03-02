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
import languages::oberon0::ast::Oberon0;
import languages::oberon0::ide::Outline;
import IO;
import ParseTree;

public void main() {
  registerLanguage("Oberon-0", "oberon0", parser);
  registerOutliner("Oberon-0", outlineModule);
  registerContributions("Oberon-0", contribs);
}   

Tree parser(str x, loc l) {
    return parse(#languages::oberon0::syntax::Oberon0::Module, x, l);
}
 
private set[Contribution] contribs = {
  popup(menu("Oberon",[
    action("Control flow graph", 
      languages::oberon0::syntax::Oberon0::Module(languages::oberon0::syntax::Oberon0::Module x, loc selection) {
        languages::oberon0::ast::Oberon0::Module m = implode(#languages::oberon0::ast::Oberon0::Module, x);
        visControlFlow(getControlFlow(m));
        for (/languages::oberon0::ast::Oberon0::Procedure p <- m)
          visControlFlow(getControlFlow(p));
        return x;
      }) 
    ])
  )
};