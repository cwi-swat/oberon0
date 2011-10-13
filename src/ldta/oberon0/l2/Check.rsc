module ldta::oberon0::l2::Check

extend ldta::oberon0::l1::Check;
import ldta::oberon0::l2::AST;


public set[Message] check(forDo(n, f, t, by, b)) = check(f) + check(t) + checkBody(b) + checkBy(by) + 
  { intErr(f@location) | !isInt(typeOf(f)) } + { intErr(t@location) | !isInt(typeOf(t)) };

private set[Message] checkBy(list[Expression] es) {
  if (e <- es) {
    return check(e) + { intErr(e@location) | !isInt(typeOf(e)) };
  }
  return {};
}

// assume case only on ints
public set[Message] check(caseOf(e, cs, o)) = check(e) + checkBody(o) +
  ( {} | it + check(ls) + checkBody(gb) | guard(ls, gb) <- cs ) +
  { intErr(e@location) | !isInt(typeOf(e)) } +
  { intErr(ge@location) | guard(ge, _) <- cs, !isInt(typeOf(ge)) };

public set[Message] check(list[Label] ls) =
  ( {} | check(l) | l <- ls );
  
public set[Message] check(expression(e)) = check(e);

public set[Message] check(range(e1, e2)) = check(e1) + check(e2);
