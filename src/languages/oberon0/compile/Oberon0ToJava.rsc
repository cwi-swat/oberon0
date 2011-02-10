module languages::oberon0::compile::Oberon0ToJava

import languages::oberon0::ast::Oberon0;
import languages::oberon0::compile::Resolve;
import String;
import List;
import IO;
import Set;
import Map;
import Number;

data StackLocation = stackLocation(int level,int offset,Type \type, bool byRef);
alias StackLocationMap = map[str,StackLocation];
alias ProcedureLevelMap = map[str,int];
data Environment = environment(StackLocationMap varLoc, ProcedureLevelMap procLev, int level, int frameSize); 



// precondition: constantElimination,resolve
public str mod2Java(Module m) {
    m = removeAllTypeAliases(m);
    <frameSize,stackLocationMap> = getStackFrame(m.decls.vars,[],0);
    env = environment(stackLocationMap,getProcLevels(m.decls.procs,1),0,frameSize);
    return 
"import java.util.Scanner;
    
class <m.name.name> {
    static final int MAX_MEM = 1000000;
    static int[] mem = new int[MAX_MEM];
    static int sp = 0;
<builtins2Java()>

<indent(vars2Java(env.level,frameSize,stackLocationMap))>
    
<indent(procs2Java(m.decls.procs,env))>
    public static void main(String[] argv){ 
<indent(indent(statements2Java(m.body,env)))>
    }
}";
}

ProcedureLevelMap getProcLevels(list[Procedure] procs, int level){
    return ( p.name@longName : level | p <- procs);
}

int procLevel(Ident name,Environment env){ return env.procLev[name@longName] ? 1; }

str procs2Java(list[Procedure] procs, Environment env){
    return "<for (p <- procs) {><proc2Java(p, env)><}>";
}

str proc2Java(Procedure p,Environment env){
	env.level+=1;
    <frameSize,newVars> = getStackFrame(p.decls.vars,p.formals,env.level);
    env.varLoc += newVars;
    env.procLev += getProcLevels(p.decls.procs,env.level+1);
    env.frameSize = frameSize;
    localVars = (name : env.varLoc[name] | name <- domain(env.varLoc), env.varLoc[name].level > 0);
    return
"static void <p.name@longName>(){
<indent(vars2Java(env.level,frameSize,localVars))>

<indent(statements2Java(p.body,env))>
}

<procs2Java(p.decls.procs,env)>";
}
    

str statements2Java(list[Statement] statements, Environment env){
    return intercalate("\n",[statement2Java(statement,env) | statement <- statements ]);
}

str statement2Java(Statement statement, Environment env){
    switch(statement){
        case assign(var,selectors,exp): return "<varUse(var.name,selectors,env)> = <exp2Java(exp,env)>;";
        case call(p,args): return call2Java(p,args);
        case ifThen(condition,body,elseIfs,\else) : {
            return 
"if(<exp2Java(condition,env)> != 0){
<indent(statements2Java(body,env))>
}<for(elseIf <- elseIfs) {> else if(<exp2Java(elseIf[0],env)> != 0){
<indent(statements2Java(elseIf[1],env))>
}<}><if(!isEmpty(\else)){> else {
<indent(statements2Java(\else,env))>
}<}>";
        }
        case whileDo(condition,body) : {
            return 
"while(<exp2Java(condition,env)> != 0){
<indent(statements2Java(body,env))>
}";
        }
    }
    throw "Cannot happen!";
}

str call2java(Ident p,list[Expression] args){
	calleeLev = procLevel(p,env);
    offset = 0;
    argsAssigns ="";
    if( calleeLev >= 2) {
        for(i <- [1..(calleeLev-2)],calleeLev-2 >= 1) {
        	argsAssigns += "mem[sp + frameSize + <offset>] = sp<i>";
        	offset+=1;
        }
        if(env.level < calleeLev){ 
        	argsAssigns+= withComment("mem[sp + frameSize + <offset>] = sp;",35,"static link to this stack frame\n");
        }
        else { 
        	argsAssigns += withComment("mem[sp + frameSize + <offset>] = sp<calleeLev-1>;",35,"static link to parent stack frame\n");
        }
        offset+=1;
    }
    i = 0;
    for (f <- p@formals, name <- f.names) {
        arg = exp2Java(args[i],env);
        // remove mem[..] ?
        arg = f.hasVar ? substring(arg,4,size(arg)-1) : arg;
        argsAssigns += withComment("mem[sp + frameSize + <offset>] = <arg>;",45,"assign argument <name.name>\n");
        offset+=f.hasVar ? 1 : sizeOf(f.\type);
        i+=1;  
    }
     return argsAssigns + 
         "sp+=frameSize;\n" +
         "<p@longName>(); \n" +
         "sp-=frameSize;";
}


public str exp2Java(Expression e,Environment env) {
  switch (e) {
    case nat(int val): return "<val>";
    case lookup(v, sels): return varUse(v.name,sels,env);
    case neg(exp): return "(-<exp2Java(exp,env)>)";
    case pos(exp): return exp2Java(exp,env);
    case mul(lhs, rhs): return "(<exp2Java(lhs,env)> * <exp2Java(rhs,env)>)";
    case div(lhs, rhs): return "(<exp2Java(lhs,env)> / <exp2Java(rhs,env)>)";
    case mod(lhs, rhs): return "(<exp2Java(lhs,env)> % <exp2Java(rhs,env)>)";
    case add(lhs, rhs): return "(<exp2Java(lhs,env)> + <exp2Java(rhs,env)>)";
    case sub(lhs, rhs): return "(<exp2Java(lhs,env)> - <exp2Java(rhs,env)>)";
    case not(exp): return "(~ <exp2Java(exp, env)>)";
    case amp(lhs, rhs): return "(<exp2Java(lhs,env)> & <exp2Java(rhs,env)>)";
    case or(lhs, rhs): return  "(<exp2Java(lhs,env)> | <exp2Java(rhs,env)>)";
    case eq(lhs, rhs): return "$eq(<exp2Java(lhs,env)> , <exp2Java(rhs,env)>)";
    case neq(lhs, rhs): return "$neq((<exp2Java(lhs,env)> ,<exp2Java(rhs,env)>)";
    case lt(lhs, rhs): return  "$lt(<exp2Java(lhs,env)> ,<exp2Java(rhs,env)>)";
    case gt(lhs, rhs): return  "$gt(<exp2Java(lhs,env)> , <exp2Java(rhs,env)>)";
    case leq(lhs, rhs): return "$leq(<exp2Java(lhs,env)>, <exp2Java(rhs,env)>)";
    case geq(lhs, rhs): return "$geq(<exp2Java(lhs,env)> , <exp2Java(rhs,env)>)";
    default: throw "Not a exp: <e>";
  }
}
    
Expression indexOfSelectors(Type \type, list[Selector] selectors){
    if(isEmpty(selectors)) return nat(0);
    switch(head(selectors)){
        case field(name) : {
            int offset = 0;
            if(record(fields) := \type){
                for(field <- fields) {
                    if(field.name == name) 
                        return (size(selectors) == 1) ? nat(offset) : add(nat(offset),indexOfSelectors(\type,tail(selectors)));
                    offset+= sizeOf(\field.\type);
                }
            } 
            throw "Oberon0ToJava: cannot happen";
        }
        case subscript(exp) : return (size(selectors) == 1) ? exp : mul(exp,indexOfSelectors(\type,tail(selectors))) ;
    }
}

str spString(int currentLevel , int desiredLevel){
    if(desiredLevel == 0){
        return "";
    } else if(desiredLevel < currentLevel) {
        return "sp<desiredLevel> +";
    } else if (desiredLevel == currentLevel){
        return "sp + ";
    } else {
        throw "cannot reference inner variable!";
    }
}



str varUse(str name, list[Selector] selectors, Environment env){
    selectorOffset = exp2Java(indexOfSelectors(env.varLoc[name].\type,selectors),env);
    selectorOffsetAdd = (selectorOffset == "0") ? "" : " + ( " + selectorOffset + " )"; 
     return "mem[<name><selectorOffsetAdd>]";
}


tuple[int,StackLocationMap] getStackFrame(list[VarDecl] vars, list[Formal] formals, int level) {
    offset = max(level-1,0);
    result = ();
    for(f <- formals, name <- f.names){
        result+=(name.name : stackLocation(level,offset,f.\type,f.hasVar));
        offset+=f.hasVar? 1 : sizeOf(f.\type);
    }
    for(var <- vars, name <- var.names){
        result+=(name.name : stackLocation(level,offset,var.\type,false));
        offset+=sizeOf(var.\type);
    }
    return <offset,result>;
}

str vars2Java(int level,int frameSize,StackLocationMap vars){
	strings = ["<(level == 0)? "static " :"">final int frameSize = <frameSize>;"];
	strings += if(level >= 2) {
		for(i <- [1..level-1]) {
			append withComment("final int sp<i> = mem[sp + <i-1>];",35,"static link");
		}
	} else [] ; 
    strings += for(name <- domain(vars)){
        static = (vars[name].level == 0) ? "static " : "";
        sp = spString(level,vars[name].level);
        offset = "<sp> <vars[name].offset>";
        memIndex = vars[name].byRef ? "mem[<offset>]" : offset;
        declaration = "<static>final int <name> = <memIndex>;";
        comment = "size: <vars[name].byRef ? 1 : sizeOf(vars[name].\type)> <vars[name].byRef ? ",reference": "">";
        append withComment(declaration,35,comment);
     }
     return intercalate("\n",strings) ;
}

    
int sizeOf(Type \type){
    switch(\type){
        case user(id("INTEGER")): return 1;
        case user(id("BOOLEAN")): return 1;
        case user(_)        : throw "oberon0ToJava: type alias still present!";
        case array(nat(i),nestedType) : return i * sizeOf(nestedType);
        case array(_,_)     : throw "oberon0ToJava: array not of computed length";
        case record(fields) : return (0 | it + sizeOf(field.\type) | field <- fields);
    }
}    

public str builtins2Java(){
    return   
"    static int $eq (int a,int b) { return a == b ? 1 : 0; }
    static int $neq(int a,int b) { return a != b ? 1 : 0; }
    static int $lt (int a,int b) { return a \< b  ? 1 : 0; }
    static int $gt (int a,int b) { return a \> b  ? 1 : 0; }
    static int $leq(int a,int b) { return a \<= b ? 1 : 0; }
    static int $geq(int a,int b) { return a \>= b ? 1 : 0; }    
    
    static void Read() {
      while(true){
          try{
            mem[mem[sp]] = new Scanner(System.in).nextInt();
            System.out.printf(\"Read: %d\\n\",mem[mem[sp]]);
            return;
          } catch(Exception e){ System.out.printf(\"Didn\'t catch that, come again?\\n\");}
      }
    }
    
    static void Write(){
      System.out.printf(\"%d\",mem[sp]);
    }
    
    static void WriteLn(){
      System.out.printf(\"\\n\");
    }
    
    static void printMem(int offset,int size){
        for(int i = 0 ; i \< size ; i++){
            System.out.printf(\"|%2d : %2d|\\n\",offset+i,mem[offset+i]);
    
        }
    }";
}


Type resolveUserType(str name,map[str,Type] aliasMap) {
    if(name == "INTEGER" || name == "BOOLEAN") return user(id(name));
    nextType = aliasMap[name];
    return if( user(nextName) := nextType) resolveUserType(nextName,aliasMap);
           else nextType;
} 
    
public Module removeAllTypeAliases(Module m) {
    aliasMap = ( \alias : \type  | /typeDecl(\alias,\type) <- m.decls.types );
    m.decls.types = [];
    return visit(m){
        case user(id(name)) => resolveUserType(name,aliasMap)
    }
}

public str indent(str lines){
    return intercalate("\n",["    " + line | /^<line:.*>$/m <- lines]);
}

public str repeatString(str string,int nr) {
	if(nr <= 0) return "";
    return ("" | it + string | i <- [1..nr]);
}

public str withComment(str line, int outline,str comment){
	return line + repeatString(" ",outline-size(line)) + "//" + comment;
}
