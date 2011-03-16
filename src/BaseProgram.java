import java.util.Scanner;

import javax.swing.JOptionPane;

class BaseProgram {
	static int STACK_SIZE = 1000000;
    static int[] stack = new int[STACK_SIZE];
    static int sp = 0;
    static String buffer = "";
    
    static void Read(int[] stack,int index) {
      while(true){
          try{
        	stack[index] = new Scanner(JOptionPane.showInputDialog("Oberon0 wants you! to type in some number")).nextInt();
            return;
          } catch(Exception e){ JOptionPane.showMessageDialog(null, "Didn't catch that, come again?\n");}
      }
    }
    
    static void Write(int arg){
    	buffer+=arg;
    	buffer+=" ";
    }
    
    static void WriteLn(){
      JOptionPane.showMessageDialog(null, buffer);
      buffer = "";
    }
}