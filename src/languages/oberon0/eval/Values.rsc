module languages::oberon0::eval::Values

alias Cell = cell(int id);               
data Value = integer(int v)
		   | record(map[str, Cell] fields)
		   | array(int size, list[Cell] elements);
