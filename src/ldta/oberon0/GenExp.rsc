module ldta::oberon0::GenExp

import Set;
import List;
import IO;

	data Conf
	  = infix(str op, T typ1, T typ2, T rtype)
	  | prefix(str op, T typ1, T rtype)
	  | const(str lit, T rtype)
	  | var(str name, T rtype)
	  ;
	  
	data T = prim(str name)
	       | var(str name)
	       ;
	  
	public set[Conf] O0 = {
	  prefix("~", prim("BOOLEAN"), prim("BOOLEAN")),
	  prefix("+", prim("INTEGER"), prim("INTEGER")),
		  prefix("-", prim("INTEGER"), prim("INTEGER")),
	  infix("*", prim("INTEGER"), prim("INTEGER"), prim("INTEGER")),
	  infix("DIV", prim("INTEGER"), prim("INTEGER"), prim("INTEGER")),
	  infix("MOD", prim("INTEGER"), prim("INTEGER"), prim("INTEGER")),
	  infix("+", prim("INTEGER"), prim("INTEGER"), prim("INTEGER")),
	  infix("-", prim("INTEGER"), prim("INTEGER"), prim("INTEGER")),
	  infix("OR", prim("BOOLEAN"), prim("BOOLEAN"), prim("BOOLEAN")),
	  infix("&", prim("BOOLEAN"), prim("BOOLEAN"), prim("BOOLEAN")),
	  infix("=", prim("INTEGER"), prim("INTEGER"), prim("BOOLEAN")), // todo: support for polymorphic stuff.
		  infix("#", prim("INTEGER"), prim("INTEGER"), prim("BOOLEAN")),
		  infix("=", prim("INTEGER"), prim("INTEGER"), prim("BOOLEAN")),
		  infix("#", prim("INTEGER"), prim("INTEGER"), prim("BOOLEAN")),
	  infix("\<=", prim("INTEGER"), prim("INTEGER"), prim("BOOLEAN")),
		  infix("\<", prim("INTEGER"), prim("INTEGER"), prim("BOOLEAN")),
		  infix("\>=", prim("INTEGER"), prim("INTEGER"), prim("BOOLEAN")),
		  infix("\>", prim("INTEGER"), prim("INTEGER"), prim("BOOLEAN")),
		  const("1", prim("INTEGER")),
		  const("2", prim("INTEGER")),
			  const("200", prim("INTEGER")),
			  const("1223", prim("INTEGER")),
			  const("0", prim("INTEGER")),
			  
			  var("x", prim("INTEGER")),
	  var("y", prim("INTEGER")),
	  var("z", prim("INTEGER")),
	  var("p", prim("BOOLEAN")),
		  var("q", prim("BOOLEAN")),
		  var("r", prim("BOOLEAN"))
	};
	

	public str chooseVar(set[Conf] confs, T t)  = getOneFrom(resultTyped(vars(confs), t)).name;
	
	public set[T] confTypes(set[Conf] confs) = { c.rtype | c <- confs };
	
	
	public set[Conf] vars(set[Conf] confs) =  { c | c <- confs, c is var };
	public set[Conf] consts(set[Conf] confs) =  { c | c <- confs, c is const };
	public set[Conf] leaves(set[Conf] confs) =  vars(confs) + consts(confs);
	public set[Conf] nonLeaves(set[Conf] confs) =  confs - leaves(confs);
	public set[Conf] resultTyped(set[Conf] confs, T t) = { c | c <- confs, c.rtype == t };
	public set[Conf] resultNonTyped(set[Conf] confs, T t) = { c | c <- confs, c.rtype != t };
	 
	
	public str build(set[Conf] confs, T typ, int xdepth, int numOfErrs) {
	
		  public Conf find(T t, int depth) {
		    if (depth > 0) {
		      return getOneFrom(resultTyped(confs, t));
		    }
	    if (numOfErrs > 0) {
	      numOfErrs -= 1;
	      return getOneFrom(resultNonTyped(leaves(confs), t));
	    }
	    return getOneFrom(resultTyped(leaves(confs), t));
  	}
	
	  public str make(Conf c, int depth) {
	    // strange capture occurs here is xdepth is named depth
	    depth -= 1;
	    switch (c) {
	      case prefix(op, t, _): {
	        o = make(find(t, depth), depth);
		        return "(<op> <o>)";     
	      }
		      case infix(op, t1, t2, _): {
	        o1 = make(find(t1, depth), depth);
			        o2 = make(find(t2, depth), depth);
		        return "(<o1> <op> <o2>)";     
	      }
	      case var(n, _): return n;
	      case const(v, _): return v; 
	    }
	  }
	  
	  return make(find(typ, xdepth), xdepth);
	
	}
	
		public str buildStat(set[Conf] confs, int xdepth) {
	  set[str] O0stats = {"ifThen", "ifThenElse", "whileDo", "assign" };
	
		  public str find(int depth) {
		    if (depth > 0) {
		      return getOneFrom(O0stats);
		    }
	    return "assign";
  	}
	
		  public str makeBody(int depth) {
		    n = getOneFrom({1,2,3,4});
	    bs = for (i <- [1..n]) {
	      append make(find(depth), depth);
	    }
	    return intercalate(";\n", bs);
		  }
	
	  public str make(str c, int depth) {
	    depth -= 1;
	    switch (c) {
	      case "assign": {
	        x = getOneFrom(vars(confs));
	        e = build(confs, x.rtype, 10, 0); 
		        return "<x.name> := <e>";     
	      }
	      case "ifThen": {
		        c = build(confs, prim("BOOLEAN"), 3, 0);
	        b = makeBody(depth);
		        return "IF <c> THEN <b> END";
		      }     
	      case "ifThenElse": {
	        c = build(confs, prim("BOOLEAN"), 3, 0);
	        b1 = makeBody(depth);
	        b2 = makeBody(depth);
		        return "IF <c> THEN <b1> ELSE <b2> END";     
	      }
		      case "whileDo": {
	        c = build(confs, prim("BOOLEAN"), 3, 0);
	        b = makeBody(depth);
		        return "WHILE <c> DO <b> END";     
	      }
	    }
	  }
	  
	  decl = ( "VAR\n" | it + "  <v.name>: <v.rtype.name>;\n" | v <- vars(O0) );
	  modb = make(find(xdepth), xdepth);
	  return "MODULE Test;
         '<decl>
         'BEGIN
         '<modb>
         'END Test.";
	}
	
	
	public tuple[str,int] genModule(int count, int depth) {
	  public tuple[str,int] genExps1(int count, int depth) {
	    confs = O0;
	    ts = { t | /T t <- confs };
	    lineNo = getOneFrom({ i | i <- [1..count] });
	    lines = for (i <- [1..count]) {
	      t = getOneFrom(ts);
	      x = chooseVar(confs, t);
	      if (i == lineNo) {
	        append "  (* error *)  <x> := <build(confs, t, depth, 1)>";
	      }
	      else {
	        append "               <x> := <build(confs, t, depth, 0)>";
	      }
	    } 
	    return <intercalate(";\n", lines), lineNo>;
	  }
	
	
	  <body, n> = genExps1(count, depth);
	  decl = ( "VAR\n" | it + "  <v.name>: <v.rtype.name>;\n" | v <- vars(O0) );
	  n += size(vars(O0)) + 4;
	  return <"MODULE Test<n>;
	         '<decl>
	         'BEGIN
	         '<body>
	         'END Test<n>.", n>;
	}
	
	public void writeTestModules(int fileCount, int count, int depth) {
		  s2 = "<count>";
	  s3 = "<depth>";
	    
	  for (i <- [1..fileCount]) {
	    <m, n> = genModule(count, depth);
	    s0 = "<i>";
	    s1 = "<n>";
	    // bug in loc interpolation.
    loc f = |project://oberon0/tests/rascal/negative/type_errors/L1/<s1>_expression_ES<s2>_D<s3>_<s0>.ob|;
	    writeFile(f, m);
	  }
	}
	
	
	public void genExps(int count, int depth, int errs) {
	  confs = O0;
	  ts = { t | /T t <- confs };
	  for (i <- [1..count]) {
	    t = getOneFrom(ts);
	    x = chooseVar(confs, t);
	    println("<x> := <build(confs, t, depth, errs)>;"); 
	  } 
	}
	
	