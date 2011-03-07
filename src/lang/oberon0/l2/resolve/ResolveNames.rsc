module lang::oberon0::l2::resolve::ResolveNames

import List;
import Set;
import Node;

import lang::oberon0::l2::ast::Oberon0;
import lang::oberon0::l1::resolve::Types;
import lang::oberon0::l1::resolve::SymbolTable;
import lang::oberon0::l1::resolve::ConstantEvaluator;
import lang::oberon0::l1::resolve::TypeEvaluator;

extend lang::oberon0::l1::resolve::ResolveNames;

public SymbolTableBuilder resolveStatementNames(SymbolTableBuilder stBuilder, forDo(n, f, t, b)) {
 	stBuilder = resolveVariableNames(stBuilder, n);
 	stBuilder = resolveExpressionNames(stBuilder, f);
 	stBuilder = resolveExpressionNames(stBuilder, t);
	return resolveStatementNames(stBuilder, b);
}

public SymbolTableBuilder resolveStatementNames(SymbolTableBuilder stBuilder, repeatUntil(bs, e)) =
	resolveStatementNames(resolveExpressionNames(stBuilder,e),bs);

public SymbolTableBuilder resolveStatementNames(SymbolTableBuilder stBuilder, caseOf(e, cs, es)) {
	stBuilder = resolveExpressionNames(stBuilder, e);
	for (guard(g, b) <- cs) {
		stBuilder = resolveExpressionNames(stBuilder, g);
		stBuilder = resolveStatementNames(stBuilder, b);
	}
 	return resolveStatementNames(stBuilder, es);
}

