package oberon0;


// Put default stuff in Oberon0, like Write().
// NB: read has a ref param.
public class Sample extends Oberon0 {
	
	/* approach
	 *  
	 * flatten nested procedures, which extra var params for capture variables
	 * rename nested procedures with the path of nesting 
	 * 
	 */
	

	void Nesting$f(int x, int[] z, int[] Nesting$y) { 
		// the last param is only needed if there is write access
		// if it is only read access it could be a normal param (no array)
		// (aside: could normalize capture variables to VAR params)
		System.out.println(x);
		Nesting$y[0] = 4;
		z[0] = z[0] + 1;
	}

	void Nesting() {
		int x, y, z;
		y = 1;
		x = 3;
		
		int[] $y = new int[] { y }; 
		// if a variable is passed by reference *and* it is captured
		// by the called function, pass the same array.
		Nesting$f(x, $y, $y); // last $y is because it is captured by f
		y = $y[0];
	}
	
}