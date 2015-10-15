#A1
#L2
#T1-2
#Core language with pretty printing and name binding

echo "*** A1 ***"

cloc src/ldta/oberon0/A1.rsc \
     src/ldta/oberon0/l1/AST.rsc \
     src/ldta/oberon0/l1/Bind.rsc \
     src/ldta/oberon0/l1/Format.rsc \
     src/ldta/oberon0/l1/Implode.rsc \
     src/ldta/oberon0/l1/Parse.rsc \
     src/ldta/oberon0/l1/Priorities.rsc \
     src/ldta/oberon0/l1/Scope.rsc \
     src/ldta/oberon0/l1/Syntax.rsc \
     src/ldta/oberon0/l2/AST.rsc \
     src/ldta/oberon0/l2/Bind.rsc \
     src/ldta/oberon0/l2/Format.rsc \
     src/ldta/oberon0/l2/Implode.rsc \
     src/ldta/oberon0/l2/Parse.rsc \
     src/ldta/oberon0/l2/Syntax.rsc | grep SUM | sed -e "s/^.*[^0-9]\\([0-9]*\\)/\\1/g"
	
#A2a
#L3
#T1-2
#A1 plus syntax and name binding for procedures

echo "*** A2a ***"

cloc src/ldta/oberon0/l1/AST.rsc \
     src/ldta/oberon0/l1/Bind.rsc \
     src/ldta/oberon0/l1/Format.rsc \
     src/ldta/oberon0/l1/Implode.rsc \
     src/ldta/oberon0/l1/Parse.rsc \
     src/ldta/oberon0/l1/Priorities.rsc \
     src/ldta/oberon0/l1/Scope.rsc \
     src/ldta/oberon0/l1/Syntax.rsc \
     src/ldta/oberon0/l2/AST.rsc \
     src/ldta/oberon0/l2/Bind.rsc \
     src/ldta/oberon0/l2/Format.rsc \
     src/ldta/oberon0/l2/Implode.rsc \
     src/ldta/oberon0/l2/Parse.rsc \
     src/ldta/oberon0/l2/Syntax.rsc \
     src/ldta/oberon0/A2a.rsc \
     src/ldta/oberon0/l3/AST.rsc \
     src/ldta/oberon0/l3/Bind.rsc \
     src/ldta/oberon0/l3/Implode.rsc \
     src/ldta/oberon0/l3/Parse.rsc \
     src/ldta/oberon0/l3/Syntax.rsc | grep SUM | sed -e "s/^.*[^0-9]\\([0-9]*\\)/\\1/g"

	
#A2b
#L2
#T1-3
#A1 plus type checking

echo "*** A2b ***"

cloc src/ldta/oberon0/l1/AST.rsc \
     src/ldta/oberon0/l1/Bind.rsc \
     src/ldta/oberon0/l1/Format.rsc \
     src/ldta/oberon0/l1/Implode.rsc \
     src/ldta/oberon0/l1/Parse.rsc \
     src/ldta/oberon0/l1/Priorities.rsc \
     src/ldta/oberon0/l1/Scope.rsc \
     src/ldta/oberon0/l1/Syntax.rsc \
     src/ldta/oberon0/l2/AST.rsc \
     src/ldta/oberon0/l2/Bind.rsc \
     src/ldta/oberon0/l2/Format.rsc \
     src/ldta/oberon0/l2/Implode.rsc \
     src/ldta/oberon0/l2/Parse.rsc \
     src/ldta/oberon0/l2/Syntax.rsc \
     src/ldta/oberon0/A2b.rsc \
     src/ldta/oberon0/l1/Check.rsc \
     src/ldta/oberon0/l1/ConstEval.rsc \
     src/ldta/oberon0/l2/Check.rsc | grep SUM | sed -e "s/^.*[^0-9]\\([0-9]*\\)/\\1/g"

     
#A3
#L3
#T1-3
#A2a and A2b

echo "*** A3 ***"

cloc src/ldta/oberon0/A3.rsc \
     src/ldta/oberon0/l1/AST.rsc \
     src/ldta/oberon0/l1/Bind.rsc \
     src/ldta/oberon0/l1/Format.rsc \
     src/ldta/oberon0/l1/Implode.rsc \
     src/ldta/oberon0/l1/Parse.rsc \
     src/ldta/oberon0/l1/Priorities.rsc \
     src/ldta/oberon0/l1/Scope.rsc \
     src/ldta/oberon0/l1/Syntax.rsc \
     src/ldta/oberon0/l2/AST.rsc \
     src/ldta/oberon0/l2/Bind.rsc \
     src/ldta/oberon0/l2/Format.rsc \
     src/ldta/oberon0/l2/Implode.rsc \
     src/ldta/oberon0/l2/Parse.rsc \
     src/ldta/oberon0/l2/Syntax.rsc \
     src/ldta/oberon0/l3/AST.rsc \
     src/ldta/oberon0/l3/Bind.rsc \
     src/ldta/oberon0/l3/Implode.rsc \
     src/ldta/oberon0/l3/Parse.rsc \
     src/ldta/oberon0/l3/Syntax.rsc \
     src/ldta/oberon0/l1/Check.rsc \
     src/ldta/oberon0/l1/ConstEval.rsc \
     src/ldta/oberon0/l2/Check.rsc \
     src/ldta/oberon0/l3/Check.rsc | grep SUM | sed -e "s/^.*[^0-9]\\([0-9]*\\)/\\1/g"


#A4
#L4
#T1-5
#Full language and all tasks

echo "*** A4 ***"
     
cloc src/ldta/oberon0/A4.rsc \
     src/ldta/oberon0/l1/AST.rsc \
     src/ldta/oberon0/l1/Bind.rsc \
     src/ldta/oberon0/l1/Check.rsc \
     src/ldta/oberon0/l1/CompileToC.rsc \
     src/ldta/oberon0/l1/ConstEval.rsc \
     src/ldta/oberon0/l1/Format.rsc \
     src/ldta/oberon0/l1/Implode.rsc \
     src/ldta/oberon0/l1/Parse.rsc \
     src/ldta/oberon0/l1/Priorities.rsc \
     src/ldta/oberon0/l1/Scope.rsc \
     src/ldta/oberon0/l1/Syntax.rsc \
     src/ldta/oberon0/l2/AST.rsc \
     src/ldta/oberon0/l2/Bind.rsc \
     src/ldta/oberon0/l2/Check.rsc \
     src/ldta/oberon0/l2/Desugar.rsc \
     src/ldta/oberon0/l2/Format.rsc \
     src/ldta/oberon0/l2/Implode.rsc \
     src/ldta/oberon0/l2/Parse.rsc \
     src/ldta/oberon0/l2/Syntax.rsc \
     src/ldta/oberon0/l3/AST.rsc \
     src/ldta/oberon0/l3/Bind.rsc \
     src/ldta/oberon0/l3/Check.rsc \
     src/ldta/oberon0/l3/CompileToC.rsc \
     src/ldta/oberon0/l3/ControlFlow.rsc \
     src/ldta/oberon0/l3/Format.rsc \
     src/ldta/oberon0/l3/Implode.rsc \
     src/ldta/oberon0/l3/Lift.rsc \
     src/ldta/oberon0/l3/Parse.rsc \
     src/ldta/oberon0/l3/Scope.rsc \
     src/ldta/oberon0/l3/Syntax.rsc \
     src/ldta/oberon0/l4/AST.rsc \
     src/ldta/oberon0/l4/Bind.rsc \
     src/ldta/oberon0/l4/Check.rsc \
     src/ldta/oberon0/l4/CompileToC.rsc \
     src/ldta/oberon0/l4/Format.rsc \
     src/ldta/oberon0/l4/Implode.rsc \
     src/ldta/oberon0/l4/Parse.rsc \
     src/ldta/oberon0/l4/Syntax.rsc  | grep SUM | sed -e "s/^.*[^0-9]\\([0-9]*\\)/\\1/g"
