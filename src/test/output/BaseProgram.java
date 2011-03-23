import org.eclipse.imp.pdb.facts.IString;
import org.eclipse.imp.pdb.facts.IValueFactory;
import org.eclipse.imp.pdb.facts.impl.fast.ValueFactory;
import org.rascalmpl.eclipse.library.util.scripting.Prompt;

class BaseProgram {
	static int STACK_SIZE = 1000000;
    static int[] stack = new int[STACK_SIZE];
    static int sp = 0;
    static String buffer = "";
    static IValueFactory vf = ValueFactory.getInstance();
    static Prompt prompt = new Prompt(vf);
    
    static void Read(int[] stack,int index) {
        IString val = prompt.prompt(vf.string("Oberon0 wants you! to type in some number"));
    	stack[index] = Integer.parseInt(val.getValue());
        return;
    }
    
    static void Write(int arg){
    	buffer+=arg;
    	buffer+=" ";
    }
    
    static void WriteLn(){
      prompt.alert(vf.string(buffer));
      buffer = "";
    }
}