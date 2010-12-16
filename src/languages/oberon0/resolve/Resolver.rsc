module languages::oberon0::resolve::Resolver

import IO;
import List;
import Set;
import ParseTree;

import languages::oberon0::ast::Oberon0;
import languages::oberon0::check::Types;
import languages::oberon0::resolve::SymbolTable;
import languages::oberon0::resolve::ConstantEvaluator;
import languages::oberon0::resolve::TypeEvaluator;
import languages::oberon0::resolve::ResolveNames;
import languages::oberon0::syntax::Oberon0;

public tuple[languages::oberon0::ast::Oberon0::Module ast, SymbolTable st] resolve(loc l) {
	languages::oberon0::syntax::Oberon0::Module syntaxModule = parseOberon0Module(l);
	languages::oberon0::ast::Oberon0::Module astModule = implode(#languages::oberon0::ast::Oberon0::Module, syntaxModule);
	SymbolTable st = resolveNames(astModule);
	astModule = annotateModule(astModule,st);
	
	return < astModule, st >;
}

public tuple[languages::oberon0::ast::Oberon0::Module ast, SymbolTable st] resolveSample() {
	return resolve(|project://Oberon0/src/sample.oberon0|);
}

anno STItemId Ident@stId;

private languages::oberon0::ast::Oberon0::Module annotateModule(languages::oberon0::ast::Oberon0::Module ast, SymbolTable st) {
	return visit(ast) {
		case Ident i : {
			if (i@location in st.itemUses) {
				set[STItemId] items = st.itemUses[i@location];
				if (size(items) != 1) {
					throw "Should have exactly one item used at location <i@location>, not <size(items)>!";
				} else {
					insert i[@stId = getOneFrom(items)];
				}
			}
		}
	};
}
 
