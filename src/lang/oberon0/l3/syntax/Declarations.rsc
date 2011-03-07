module lang::oberon0::l3::syntax::Declarations

import lang::oberon0::l1::syntax::Declarations;
import lang::oberon0::l2::syntax::Statements;
import lang::oberon0::l1::syntax::Lexical;
import lang::oberon0::l1::syntax::Types;
import lang::oberon0::l1::syntax::Layout;

syntax Declarations 
       // NB: procs is + so as not to be ambiguous with earlier decls.
	= decls: ConstSect? consts TypeSect? types VarSect? vars ProcedureDecl+ procs
	;

syntax ProcedureDecl 
	= @Foldable proc: "PROCEDURE" Ident name Formals? formals ";" Declarations decls Body? body "END" Ident ";"
	; 


syntax Formal 
	= formal: "VAR"? hasVar {Ident ","}+ params ":" Type type
	;

syntax Formals 
	= "(" {Formal ";"}* formals ")"
	;


syntax Keywords
       = "PROCEDURE" 
       ;

syntax "PROCEDURE" 
       = ... # [A-Za-z0-9] 
       ;
	


