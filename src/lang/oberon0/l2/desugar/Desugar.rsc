module lang::oberon0::l2::desugar::Desugar

import lang::oberon0::l2::ast::Oberon0;

import IO;
import List;

data Statement 
	= begin(list[Statement] body)
	;

alias DeclsBody = tuple[Declarations decls, list[Statement] body];

public Module desugar(Module mod) {
	mod.body = (for2while o repeat2while o case2ifs o flattenBegin)(mod.body);
	return mod;
}

public list[Statement] case2ifs(list[Statement] stats) {
	Statement cases2if(Expression e, list[Case] cs, list[Statement] es) {
		list[tuple[Expression condition, list[Statement] body]] eis = [ <eq(e, c.guard), c.body> | c <- tail(cs) ];
		c = head(cs);
		return ifThen(eq(e, c.guard), c.body, eis, es); 
	}
	
	return visit (stats) {
		case caseOf(e, [], es) => begin(es)
		case caseOf(e, cs, es) => cases2if(e, cs, es)
	}
}


public list[Statement] repeat2while(list[Statement] stats) {
	return visit (stats) {
		case repeatUntil(b, c) => begin([b, whileDo(not(c), b)]) 
	}
}

public list[Statement] for2while(list[Statement] stats) {
	return visit (stats) {
		case forDo(n, f, t, b) => 
			begin([assign(n, f), whileDo(geq(lookup(n), t), 
					[b, assign(n, add(lookup(n), nat(1)))])]) 
	}
}




public list[Statement] flattenBegin(list[Statement] stats) {
	return innermost visit (stats) {
		case [s1*, begin(b), s2*] => [s1, b, s2]
	}
}