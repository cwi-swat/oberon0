module lang::oberon0::l2::extract::CFGtoFigure

extend lang::oberon0::l1::extract::CFGtoFigure;
import lang::oberon0::l2::extract::ControlFlow;

public str formatNode(expression(_, Expression e)) = replaceLast(format(exp2box(e)), "\n", "");

