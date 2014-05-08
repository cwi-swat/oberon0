module ldta::oberon0::l3::CFGtoFigure

extend ldta::oberon0::l2::CFGtoFigure;
import ldta::oberon0::l3::AST;
import ldta::oberon0::l3::Format;

public str formatNode(\start(_, Procedure p)) = "start <p.name.name>";
