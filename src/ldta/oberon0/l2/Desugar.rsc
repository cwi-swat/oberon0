module ldta::oberon0::l2::Desugar

import ldta::oberon0::l2::AST;
import IO;

import List;

data Statement = begin(list[Statement] body);

alias DeclsBody = tuple[Declarations decls, list[Statement] body];

public Statement CASE = caseOf(nat(1), [
           guard([expression(nat(1)), range(nat(2), nat(3))], [assign(id("x"), nat(3))])
           ],
           [assign(id("x"), nat(5))]);
           


public Module desugar(Module mod) {
	  mod.body = (for2while o case2ifs o flattenBegin)(mod.body);
	  return mod;
}

public list[Statement] case2ifs(list[Statement] stats) {
  Statement cases2if(Expression e, list[Case] cs, list[Statement] es) {
    list[tuple[Expression condition,list[Statement] body]] eis = [<label2cond(e, l), c.body> | c <- cs, l <- c.labels ]; 
	    ei = head(eis);
	    return ifThen(ei[0], ei[1], tail(eis), es); 
  }
  
 		 Expression label2cond(Expression e, expression(e2)) = eq(e, e2);
 		 Expression label2cond(Expression e, range(e1, e2)) = amp(leq(e1, e), leq(e, e2));
 		 
  return visit (stats) {
	    case caseOf(e, cs, es) => cases2if(e, cs, es)
  }
}

public list[Statement] for2while(list[Statement] stats) {
  return visit (stats) {
	    case forDo(n, f, t, [by], b) => 
		             begin([assign(n, f), whileDo(leq(lookup(n), t), 
				                 [b, assign(n, add(lookup(n), by))])]) 
	    case forDo(n, f, t, [], b) => 
		             begin([assign(n, f), whileDo(leq(lookup(n), t), 
				                 [b, assign(n, add(lookup(n), nat(1)))])]) 
  }
}

public list[Statement] flattenBegin(list[Statement] stats) {
  return visit (stats) {
	    case [s1*, begin(b), s2*] => [s1, b, s2]
  }
}
