import java.util.Scanner;

import javax.swing.JOptionPane;
import org.eclipse.imp.pdb.facts.IValueFactory;
import org.eclipse.imp.pdb.facts;
import org.eclipse.imp.pdb.facts.impl.fast.ValueFactory;
import org.rascalmpl.eclipse.library.util.scripting.Prompt;

class BaseProgram {
	static int STACK_SIZE = 1000000;
    static int[] stack = new int[STACK_SIZE];
    static int sp = 0;
    static String buffer = "";
    static Prompt prompt = new Prompt(new ValueFactory());
    
    static void Read(int[] stack,int index) {
        IString val = prompt.prompt("Oberon0 wants you! to type in some number");
    	stack[index] = Integer.parseInt(val.getValue());
        return;
    }
    
    static void Write(int arg){
    	buffer+=arg;
    	buffer+=" ";
    }
    
    static void WriteLn(){
      System.out.println(buffer);
      buffer = "";
    }
}