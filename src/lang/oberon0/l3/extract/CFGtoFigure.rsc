module lang::oberon0::l3::extract::CFGtoFigure

extend lang::oberon0::l2::extract::CFGtoFigure;
import lang::oberon0::l3::ast::Oberon0;
import lang::oberon0::l3::format::Oberon0;

public str formatNode(\start(_, Procedure p)) = "start <p.name.name>";
