package ldta.oberon0;

import java.io.PrintWriter;
import java.net.URI;

import org.eclipse.imp.pdb.facts.ISourceLocation;
import org.eclipse.imp.pdb.facts.IValueFactory;
import org.eclipse.imp.pdb.facts.impl.fast.ValueFactory;
import org.rascalmpl.interpreter.Evaluator;
import org.rascalmpl.interpreter.env.GlobalEnvironment;
import org.rascalmpl.interpreter.env.ModuleEnvironment;
import org.rascalmpl.interpreter.load.IRascalSearchPathContributor;
import org.rascalmpl.interpreter.load.StandardLibraryContributor;

public class Main {

	private static final String ROB0C = "rob0c";
	private static final String WD = System.getProperty("user.dir");
	private final Evaluator eval;
	private final URI org;
	
	public Main(String[] args) {
		IValueFactory vf = ValueFactory.getInstance();
		GlobalEnvironment heap = new GlobalEnvironment();
		ModuleEnvironment env = new ModuleEnvironment(ROB0C, heap);
		this.eval = new Evaluator(vf, new PrintWriter(System.err), 
				new PrintWriter(System.out), env, heap);
		this.org = vf.sourceLocation(WD).getURI();
		eval.addClassLoader(getClass().getClassLoader());
	}

	public static void main(String[] args) {
		new Main(args).run(args);
	}

	private void run(String[] args) {
		if (args[0].equals("test")) {
			eval("import ldta::oberon0::Tests;");
			eval(":test");
		}
	}
	
	private void eval(String cmd) {
		System.out.println(eval.eval(null, cmd, org));
	}
}
