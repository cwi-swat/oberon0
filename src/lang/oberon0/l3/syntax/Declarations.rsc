module lang::oberon0::l3::syntax::Declarations

extend lang::oberon0::l1::syntax::Declarations;

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


keywords Keywords
       = "PROCEDURE" 
       ;

	


