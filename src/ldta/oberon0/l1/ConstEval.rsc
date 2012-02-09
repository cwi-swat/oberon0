module ldta::oberon0::l1::ConstEval

import ldta::oberon0::l1::AST;
import ldta::oberon0::l1::Scope;

data DivByZero = divByZero(loc l);

public default Expression eval(Expression e) = e;

public Expression eval(neg(e)) = neg(eval(e)) when !(e is nat);

public Expression eval(pos(e)) = pos(eval(e)) when !(e is nat);

public Expression eval(add(e1, e2)) = add(eval(e1), eval(e2))
  when !(e1 is nat), !(e2 is nat);

public Expression eval(sub(e1, e2)) = sub(eval(e1), eval(e2))
  when !(e1 is nat), !(e2 is nat);

public Expression eval(mul(e1, e2)) = mul(eval(e1), eval(e2))
  when !(e1 is nat), !(e2 is nat);

public Expression eval(div(e1, e2)) = div(eval(e1), eval(e2))
  when !(e1 is nat), !(e2 is nat);

public Expression eval(Expression::\mod(e1, e2)) = Expression::\mod(eval(e1), eval(e2))
  when !(e1 is nat), !(e2 is nat);

public Expression eval(lookup(x)) = eval((x@decl).exp) when x@decl is const;
public Expression eval(neg(nat(n))) = nat(-n);
public Expression eval(pos(nat(n))) = nat(n);
public Expression eval(add(nat(n1), nat(n2))) = nat(n1 + n2);
public Expression eval(sub(nat(n1), nat(n2))) = nat(n1 - n2);
public Expression eval(mul(nat(n1), nat(n2))) = nat(n1 * n2);
public Expression eval(div(nat(n1), nat(n2))) = nat(n1 / n2) when n2 != 0;
public Expression eval(Expression::\mod(nat(n1), nat(n2))) = nat(n1 mod n2) when n2 != 0;

public Expression eval(e:div(nat(n1), nat(0))) = { throw divByZero(e@location); };
public Expression eval(e:Expression::\mod(nat(n1), nat(0))) = { throw divByZero(e@location); };
