module ldta::oberon0::l3::ControlFlow

extend ldta::oberon0::l2::ControlFlow;
import ldta::oberon0::l3::AST;

public data CFNode = \start(loc location, Procedure prod);

public ControlFlowGraph getControlFlow(Procedure p) {
	return getControlFlow(p.body, \start(p@location, p));
}
