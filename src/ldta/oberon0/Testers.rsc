module ldta::oberon0::Testers

import Exception;
import Message;
import ParseTree;
import IO;

// NB: the parens are needed around the return type (amb).
public int tryParse((&T <: Tree)(loc) parse, loc file) {
  try {
    parse(file);
    return -1;
  }
  catch ParseError(loc l): {
    println("parse error: <l.path> <l.begin.line>");
    return l.begin.line;
  }
}

public int tryBind(set[Message](loc) bind, loc file) = report(bind(file));

public int tryCheck(set[Message](loc) check, loc file) = report(check(file)); 

private int report(set[Message] errs) {
  if (errs != {}) {
     e = firstError(errs);
     println("ERROR: <e.msg> @ <e.at.begin.line>");
     println("All errors: \n");
     for (e2 <- errs) {
       println("\t<e2.msg> @ <e2.at.begin.line>");
     }
     return e.at.begin.line;
  }
  println("Ok");
  return -1;
}

private Message firstError(set[Message] errs) {
  b = true;
  Message cur;
  for (e <- errs) {
    if (b) {
      cur = e;
      b = false;
    }
    else {
      if (e.at.begin.line < cur.at.begin.line) {
        cur = e;
      }
      if (e.at.begin.line == cur.at.begin.line, e.at.begin.column < cur.at.begin.column) {
        cur = e;
      }
    }
  }
  return cur;  
}
