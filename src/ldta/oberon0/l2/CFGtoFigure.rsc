module ldta::oberon0::l2::CFGtoFigure

extend ldta::oberon0::l1::CFGtoFigure;
import ldta::oberon0::l2::ControlFlow;

public str formatNode(CFNode::expression(_, Expression e)) = replaceLast(format(exp2box(e)), "\n", "");

