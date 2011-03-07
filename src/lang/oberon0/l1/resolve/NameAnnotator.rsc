module lang::oberon0::l1::resolve::NameAnnotator

import Set;

import lang::oberon0::l1::ast::Oberon0;
import lang::oberon0::l1::resolve::SymbolTable;

import Relation;

anno Item Ident@item;
anno loc Ident@definedAt;

public Module annotateModule(Module ast, SymbolTableBuilder stBuilder) {
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
