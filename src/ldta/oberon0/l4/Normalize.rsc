module ldta::oberon0::l4::Normalize

import ldta::oberon0::l4::AST;

public Module normalize(Module m) {
  solve (m) {
    m = visit (m) {
      case a:assign(x, e) => assign(x, [], e)[@location=(a@location)]
      case l:lookup(x) => lookup(x, [])[@location=(l@location)]
    }
  }
  return m;
}