module languages::oberon0::syntax::Declarations

import languages::oberon0::syntax::Layout;
import languages::oberon0::syntax::Statements;
import languages::oberon0::syntax::Types;
import languages::oberon0::syntax::Lexical;
import languages::oberon0::syntax::Expressions;

syntax Declarations 
	= decls: ConstSect? consts TypeSect? types VarSect? vars ProcedureDecl* procs
	;

syntax ConstDecl 
	= constDecl: Ident name "=" Expression value ";"
	;
	
syntax ConstSect 
	= "CONST" ConstDecl* consts
	;

syntax TypeDecl 
	= typeDecl: Ident name "=" Type type ";"
	;

syntax TypeSect 
	= "TYPE" TypeDecl* types
	;

syntax VarDecl 
	= varDecl: {Ident ","}* names ":" Type type ";"
	;
	
syntax VarSect 
	= "VAR" VarDecl* vars
	;

syntax ProcedureDecl 
	= proc: "PROCEDURE" Ident name Formals? formals ";" Declarations decls Body? body "END" Ident ";"
	; 


syntax Formal 
	= formal: "VAR"? hasVar {Ident ","}+ params ":" Type type
	;

syntax Formals 
	= "(" {Formal ";"}* formals ")"
	;

syntax Body 
	= "BEGIN" {Statement ";"}+ statements
	;






