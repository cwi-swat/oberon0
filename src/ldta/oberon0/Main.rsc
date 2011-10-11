

module ldta::oberon0::Main

import ldta::oberon0::A1;
import ldta::oberon0::A2a;
import ldta::oberon0::A2b;
import ldta::oberon0::A3;
import ldta::oberon0::A4;


public void main(list[str] args) {
  lang = args[0];
  op = args[1];
  file = |cwd:///<args[2]>|;
  switch (<lang, op>) {
    case <"A1", "format">: formatA1(file);
    case <"A1", "bind">: bindA1(file);
    case <"A2a", "format">: formatA2a(file);
    case <"A2a", "bind">: bindA2a(file);
    case <"A2b", "check">: bindA2b(file);
    case <"A3", "format">: formatA3(file);
    case <"A3", "bind">: bindA3(file);
    case <"A3", "check">: checkA3(file);
    case <"A4", "format">: formatA4(file);
    case <"A4", "bind">: bindA4(file);
    case <"A4", "check">: checkA4(file);
    case <"A4", "transform">: transformA4(file);
    case <"A4", "compile">: compileA4(file);
    default: throw "No such language/operation combination <lang>/<op>";
  }
}