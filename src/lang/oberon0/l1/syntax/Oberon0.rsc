module lang::oberon0::syntax::Oberon0

import lang::oberon0::l1::syntax::Layout;
import lang::oberon0::l1::syntax::Lexical;
import lang::oberon0::l1::syntax::Declarations;


start syntax Module = mod: "MODULE" Ident name ";" Declarations decls Body? body "END" Ident ".";



