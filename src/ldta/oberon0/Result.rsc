module ldta::oberon0::Result

import Message;
import IO;

public void report(set[Message] errs) {
  if (errs != {}) {
     e = firstError(errs);
     println(e.at.begin.line);
  }
}

public Message firstError(set[Message] errs) {
  // penalty for using sets of messages....
  int n = -1;
  int c = -1;
  Message cur;
  for (e <- errs) {
    if (n == -1) {
      cur = e;
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
