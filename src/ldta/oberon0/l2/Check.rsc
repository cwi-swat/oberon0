module ldta::oberon0::l2::Check

extend ldta::oberon0::l1::Check;
import ldta::oberon0::l2::AST;


public set[Message] check(forDo(n, f, t, by, b)) = check(f) + check(t) + checkBody(b) + checkBy(by) + 
  { intErr(f@location) | typeOf(f) != INT } + { intErr(t@location) | typeOf(t) != INT };

private set[Message] checkBy([e]) = check(e) + { intErr(e@location) | typeOf(e) != INT };

private set[Message] checkBy([]) = {};  

// assume case only on ints
public set[Message] check(caseOf(e, cs, o)) = check(e) + checkBody(o) +
  ( {} | it + check(ge) + checkBody(gb) | guard(ge, gb) <- cs ) +
  { intErr(e@location) | typeOf(e) != INT } +
  { intErr(ge@location) | guard(ge, _) <- cs, typeOf(ge) != INT };
  
