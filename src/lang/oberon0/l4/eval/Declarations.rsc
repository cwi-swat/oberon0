module lang::oberon0::l4::eval::Declarations

import lang::oberon0::l1::eval::Declarations;
import lang::oberon0::l3::eval::Declarations;

import lang::oberon0::l1::ast::Oberon0;
import lang::oberon0::l3::ast::Oberon0;
import lang::oberon0::l4::ast::Oberon0;


public Type evalType(t:user(id("INTEGER")), Env env, Memory mem) = t;
public Type evalType(t:user(id("BOOLEAN")), Env env, Memory mem) = t;


public Type evalType(array(Expression b, Type et), Env env, Memory mem) {
	v = eval(b, env, mem);
	if (integer(int n) := v) {
		return array(nat(n), evalType(et, env, mem));
	}
	throw "Array bounds must be integers not <v>";
}

public Type evalType(record(fs), Env env, Memory mem) = 
	record([field(n, evalType(f.\type, env, mem)) | f <- fs, n <- f.names ]);  
