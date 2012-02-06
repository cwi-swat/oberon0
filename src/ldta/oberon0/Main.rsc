module ldta::oberon0::Main

import ldta::oberon0::A1;
import ldta::oberon0::A2a;
import ldta::oberon0::A2b;
import ldta::oberon0::A3;
import ldta::oberon0::A4;

public void main(list[str] args) {
  art = args[0];
  file = |file:///<args[1]>|;
  switch (art) {
    case "A1":  runBindL1(file);
    case "A2a": runBindL3(file);
    case "A2b": runCheckL2(file);
    case "A3":  runCheckL3(file);
    case "A4":  runCompileL4(file);
    default: println("Unknown artifact <art>");
  }
}

private void runBindL1(loc l) = println(firstError(bindL1(l)));
private void runBindL3(loc l) = println(firstError(bindL3(l)));
private void runCheckL2(loc l) = println(firstError(checkL2(l)));
private void runCheckL3(loc l) = println(firstError(checkL3(l)));
private void runCompileL4(loc l) = println(compileL4(l));

