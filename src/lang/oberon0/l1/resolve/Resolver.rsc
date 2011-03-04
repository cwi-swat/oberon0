module lang::oberon0::resolve::Resolver

import IO;
import List;
import Set;
import ParseTree;
import Relation;

import lang::oberon0::ast::Oberon0;
import lang::oberon0::check::Types;
import lang::oberon0::resolve::SymbolTable;
import lang::oberon0::resolve::ConstantEvaluator;
import lang::oberon0::resolve::TypeEvaluator;
import lang::oberon0::resolve::ResolveNames;
import lang::oberon0::syntax::Oberon0;
import lang::oberon0::utils::Parse;

public tuple[lang::oberon0::ast::Oberon0::Module ast, SymbolTableBuilder stBuilder] resolveAux(loc l) {
	lang::oberon0::syntax::Oberon0::Module syntaxModule = parseOberon0Module(l);
	lang::oberon0::ast::Oberon0::Module astModule = implode(#lang::oberon0::ast::Oberon0::Module, syntaxModule);
	SymbolTableBuilder stBuilder = resolveNames(astModule);
	astModule = annotateModule(astModule,stBuilder);
	
	return < astModule, stBuilder >;
}

public tuple[lang::oberon0::ast::Oberon0::Module ast, SymbolTable st] resolve(loc l) {
	< astModule, stBuilder > = resolveAux(l);
	return < astModule, stBuilder.symbolTable >;
}

public tuple[lang::oberon0::ast::Oberon0::Module ast, SymbolTable st] resolveSample() {
	return resolve(|project://Oberon0/src/sample.oberon0|);
}

anno Item Ident@item;
anno loc Ident@definedAt;

private lang::oberon0::ast::Oberon0::Module annotateModule(lang::oberon0::ast::Oberon0::Module ast, SymbolTableBuilder stBuilder) {
	rel[loc,Item] locItems = invert(stBuilder.itemUses);
	
	return visit(ast) {
		case Ident i : {
			if (i@location in locItems<0>) {
				set[Item] items = locItems[i@location];
				if (size(items) != 1) {
					throw "Should have exactly one item used at location <i@location>, not <size(items)>!";
				} else {
					Item item = getOneFrom(items);
					if ( (item.definedAt)? )
						insert i[@item = item][@definedAt = item.definedAt];
					else
						insert i[@item = item];
				}
			}
		}
	};
}
