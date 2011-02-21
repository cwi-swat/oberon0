import java.util.Scanner;

class BaseProgram {
	static final int MAX_MEM = 1000000;
    static int[] mem = new int[MAX_MEM];
    static int sp = 0;
    static int $eq (int a,int b) { return a == b ? 1 : 0; }
    static int $neq(int a,int b) { return a != b ? 1 : 0; }
    static int $lt (int a,int b) { return a < b  ? 1 : 0; }
    static int $gt (int a,int b) { return a > b  ? 1 : 0; }
    static int $leq(int a,int b) { return a <= b ? 1 : 0; }
    static int $geq(int a,int b) { return a >= b ? 1 : 0; }    
    
    static void Read() {
      while(true){
          try{
            mem[mem[sp]] = new Scanner(System.in).nextInt();
            System.out.printf("Read: %d\n",mem[mem[sp]]);
            return;
          } catch(Exception e){ System.out.printf("Didn't catch that, come again?\n");}
      }
    }
    
    static void Write(){
      System.out.printf("%d",mem[sp]);
    }
    
    static void WriteLn(){
      System.out.printf("\n");
    }
}