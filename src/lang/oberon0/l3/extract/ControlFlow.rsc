module lang::oberon0::l3::extract::ControlFlow

extend lang::oberon0::l2::extract::ControlFlow;
import lang::oberon0::l3::ast::Oberon0;

public data CFNode = start(loc location, Procedure prod);

public ControlFlowGraph getControlFlow(Procedure p) {
	return getControlFlow(p.body, start(p@location, p));
}
