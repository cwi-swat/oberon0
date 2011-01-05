module languages::oberon0::eval::Store

import languages::oberon0::ast::Oberon0;
import languages::oberon0::eval::Values;
import languages::oberon0::eval::Env;


alias Store = map[Cell, Value];


private int CELL_COUNT = -1;

public Cell newCell() {
  CELL_COUNT += 1;
  return cell(CELL_COUNT);
}


