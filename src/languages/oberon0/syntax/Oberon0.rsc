module languages::oberon0::syntax::Oberon0

import ParseTree;
import languages::oberon0::syntax::Layout;
import languages::oberon0::syntax::Lexical;
import languages::oberon0::syntax::Declarations;


start syntax Module = mod: "MODULE" Ident name ";" Declarations decls Body? body "END" Ident ".";



