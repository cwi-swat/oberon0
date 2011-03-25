module lang::oberon0::l4::resolve::ResolveNames

extend lang::oberon0::l3::resolve::ResolveNames;

import lang::oberon0::l3::resolve::SymbolTable;
import lang::oberon0::l4::ast::Oberon0;
import lang::oberon0::l4::resolve::Types;
import lang::oberon0::l4::resolve::TypeEvaluator;


public SymbolTableBuilder resolveExpressionNames(SymbolTableBuilder stBuilder, lookup(v, sels)) = 
	resolveVariableNames(( stBuilder | resolveSelectorNames(it, sel) | sel <- sels), v);


public SymbolTableBuilder resolveStatementNames(SymbolTableBuilder stBuilder, assign(v, sels, e)) = 
	resolveExpressionNames(resolveVariableNames(( stBuilder | resolveSelectorNames(it, sel) | sel <- sels), v), e);

//
// Selectors are either fields (for records) or subscripts (for arrays).
// Array selectors are expressions, so we recurse. We do nothing with
// the fields, since we need to know the type of the var being selected
// against to know whether the name is in scope or not.
//
public SymbolTableBuilder resolveSelectorNames(SymbolTableBuilder stBuilder, Selector sel) {
	switch(sel) {
		case field(fid) : return stBuilder;
		case subscript(e) : return resolveExpressionNames(stBuilder,e);
	}
	throw "resolveNames: Unhandled selector <sel> at <sel@location>";
}

