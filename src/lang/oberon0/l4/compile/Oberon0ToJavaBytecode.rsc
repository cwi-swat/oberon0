module lang::oberon0::l4::compile::Oberon0ToJavaBytecode


import lang::oberon0::l1::ast::Oberon0;
import lang::oberon0::l3::ast::Oberon0;
import lang::oberon0::l4::ast::Oberon0;

import lang::oberon0::l3::compile::AnnotateByRefs;
import lang::jvm::ast::Level0;
import lang::oberon0::l4::normalize::Normalize;
import lang::oberon0::l4::normalize::RemoveTypeAliases;
import lang::oberon0::l4::normalize::ExplicitStack;
import lang::oberon0::l3::optimize::ConstantElimination;
import String;
import List;

public Class jBytecodeCompilerPipeline(Module m) {
	return compile2JavaBytecode((normalizeBooleans o normalizeL4  o removeTypeAliases o eliminateConstantsL3  o explicitStack o eliminateConstantsL3  )(m));
}
	
public Class compile2JavaBytecode(Module m) {
	int labelCounter = 0;

	int newLabel() { oldVal = labelCounter; labelCounter+=1; return oldVal;}
	
	list[Method] procs2JavaBytecode(list[Procedure] procs) {
		return [ proc2JavaBytecode(p) | p <- procs ];
	}
	
	Method main2JavaBytecode(list[Statement] body) {
		begin = newLabel();
		end = newLabel();
	 	return method(ACC_PUBLIC + ACC_STATIC, "main", "([Ljava/lang/String;)V", "", [/* no exceptions */],
						[label(begin)] /*+ allocateStackArray()*/ + stats2JavaBytecode(body) + [instruction(RETURN), label(end)], [/* no try catch blocks */], 
		[localVariable("inextistadnt", "I", "", begin, end, 0)]);// [/* no local variables */]);
	}
	
	list[Instruction] allocateStackArray() {
		return [fieldRef(GETSTATIC,"BaseProgram","STACK_SIZE","I"),
		        integer(NEWARRAY,T_INT),
		        fieldRef(PUTSTATIC,"BaseProgram","stack","[I")];
	}
	
	Method proc2JavaBytecode(Procedure p) {
	 	return method(ACC_PROTECTED + ACC_STATIC, p.name.name, "()V", "", [/* no exceptions */],
						 stats2JavaBytecode(p.body) + [instruction(RETURN)], [/* no try catch blocks */], [/* no local variables */]);
	}
	
	list[Instruction] stats2JavaBytecode(list[Statement] stats) {
	  return [stat2JavaBytecode(s)  |s  <- stats ];
	}
	
	list[Instruction] stat2JavaBytecode(Statement stat) {
	  switch (stat) {
	    case assign(id("stack"), [subscript(s)], exp):
	    	 return [fieldRef(GETSTATIC,"BaseProgram","stack","[I")] 
	    	        + exp2JavaBytecode(s) + exp2JavaBytecode(exp)
	    	        + [instruction(IASTORE)];
	    case assign(id("sp"), [] , exp) : return exp2JavaBytecode(exp) + [fieldRef(PUTSTATIC,"BaseProgram","sp","I")];
	    case call(id("Read")) : return [method(INVOKESTATIC,"BaseProgram","Read","()V")];
	    case call(id("Write")) : return [method(INVOKESTATIC,"BaseProgram","Write","()V")];
	    case call(id("WriteLn")) : return [method(INVOKESTATIC,"BaseProgram","WriteLn","()V")];
	    case call(Ident id, []): return [method(INVOKESTATIC,m.name.name,id.name,"()V")];
	    // asm doesn't like label(label
	    case ifThen(c, b, [], []): {
	    	endLabel = newLabel();
	    	return compareJump2JavaByteCode(c,endLabel) +
	    		   stats2JavaBytecode(b) +
	    		   [label(endLabel)];
	    }
	    case ifThen(c, [], [], el): {
	    	elseLabel = newLabel();
	    	endLabel = newLabel();
	    	return compareJump2JavaByteCode(c,elseLabel) +
	    		   [jump(GOTO,endLabel),label(endLabel)] +
	    		   stats2JavaBytecode(el) +
	    		   [label(endLabel)];
	    }
	    case ifThen(c, b, [], el): {
	    	elseLabel = newLabel();
	    	endLabel = newLabel();
	    	return compareJump2JavaByteCode(c,elseLabel) +
	    		   stats2JavaBytecode(b) +
	    		   [jump(GOTO,endLabel),label(elseLabel)] +
	    		   stats2JavaBytecode(el) +
	    		   [label(endLabel)];
	    }

	    
	    case whileDo(c, b): {
	    	startLabel = newLabel();
	    	endLabel = newLabel();
	    	return [label(startLabel)] + exp2JavaBytecode(c) +
	    		   [jump(IFEQ,endLabel)] + stats2JavaBytecode(b) + [jump(GOTO,startLabel)] +
	    		   [label(endLabel)];
	    }
	 	default: throw "unhandled statement : <stat>";
	  }
	}
	
	list[Instruction] compareJump2JavaByteCode(cond,int ifNotTrueLabel){
		switch(cond) {
			case lookup(_,_) : return exp2JavaBytecode(cond) + [jump(IFEQ,ifNotTrueLabel)];
			case eq(lhs,rhs) : return exp2JavaBytecode(lhs) +  exp2JavaBytecode(rhs) + [jump(IF_ICMPNE,ifNotTrueLabel)];
			case neq(lhs,rhs): return exp2JavaBytecode(lhs) +  exp2JavaBytecode(rhs) + [jump(IF_ICMPEQ,ifNotTrueLabel)];
			case lt(lhs,rhs) : return exp2JavaBytecode(lhs) +  exp2JavaBytecode(rhs) + [jump(IF_ICMPGE,ifNotTrueLabel)];
			case gt(lhs,rhs) : return exp2JavaBytecode(lhs) +  exp2JavaBytecode(rhs) + [jump(IF_ICMPLE,ifNotTrueLabel)];
			case leq(lhs,rhs) : return exp2JavaBytecode(lhs) +  exp2JavaBytecode(rhs) + [jump(IF_ICMPGT,ifNotTrueLabel)];
			case geq(lhs,rhs) : return exp2JavaBytecode(lhs) +  exp2JavaBytecode(rhs) + [jump(IF_ICMPLT,ifNotTrueLabel)];
			case \true()     : return [];
			case \false()      : return [ jump(GOTO,ifNotTrueLabel)];
			default: throw "Not compare: <cond>";
		}
	}

	
	
	 list[Instruction] exp2JavaBytecode(Expression e) {
	  switch (e) {
	    case \true()     : return [integer(BIPUSH,1)];
	    case \false()    : return [integer(BIPUSH,0)]; 
	    case nat(int val): 		return [integer(BIPUSH,val)];
	    case lookup(id("sp"), []) : return [fieldRef(GETSTATIC,"BaseProgram","sp","I")];
	    case lookup(id("stack"), [subscript(exp)]): 
	    	return [fieldRef(GETSTATIC,"BaseProgram","stack","[I")] + exp2JavaBytecode(exp) + [instruction(IALOAD)];
	    case neg(exp): 			return exp2JavaBytecode(exp) + [instruction(INEG)];
	    case pos(exp): 			return exp2JavaBytecode(exp);
	    case mul(lhs, rhs): 	return exp2JavaBytecode(lhs) + exp2JavaBytecode(rhs) + [instruction(IMUL)];
	    case div(lhs, rhs): 	return exp2JavaBytecode(lhs) + exp2JavaBytecode(rhs) + [instruction(IDIV)];
	    case mod(lhs, rhs): 	return exp2JavaBytecode(lhs) + exp2JavaBytecode(rhs) + [instruction(IREM)];
	    case add(lhs, rhs): 	return exp2JavaBytecode(lhs) + exp2JavaBytecode(rhs) + [instruction(IADD)];
	    case sub(lhs, rhs): 	return exp2JavaBytecode(lhs) + exp2JavaBytecode(rhs) + [instruction(ISUB)];
	    default: throw "Not a exp: <e>";
	  }
	}
	
	return class(V1_5, // java version
			 ACC_PUBLIC, // public class 
			 m.name.name, // name
			 "", // signature 
			 "BaseProgram", // superclass 
			 [], // implemented interfaces
			 [], // inner classes
			 [],
			  procs2JavaBytecode(m.decls.procs) + main2JavaBytecode(m.body));
}