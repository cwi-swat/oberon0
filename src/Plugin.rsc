module Plugin

import ldta::oberon0::A4;
import util::IDE;

public void main() {
  registerLanguage("Oberon-0", "l4", parseL4);
}   
