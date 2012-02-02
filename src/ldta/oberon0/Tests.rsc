module ldta::oberon0::Tests

import ldta::oberon0::Testers;
import ldta::oberon0::A1;
import ldta::oberon0::A2a;
import ldta::oberon0::A2b;
import ldta::oberon0::A3;
import ldta::oberon0::A4;

public test bool NEG_parse_L1_silver_reserved_if_ob() = 
  tryParse(parseL1, |project://oberon0/tests/silver/negative/parse_errors/L1/reserved_if.ob|) != -1; 

public test bool NEG_parse_L1_silver_reserved_var_ob() = 
  tryParse(parseL1, |project://oberon0/tests/silver/negative/parse_errors/L1/reserved_var.ob|) != -1; 

public test bool NEG_parse_L1_silver_reserved_module_ob() = 
  tryParse(parseL1, |project://oberon0/tests/silver/negative/parse_errors/L1/reserved_module.ob|) != -1; 

public test bool NEG_parse_L1_silver_reserved_const_ob() = 
  tryParse(parseL1, |project://oberon0/tests/silver/negative/parse_errors/L1/reserved_const.ob|) != -1; 

public test bool NEG_parse_L1_silver_reserved_else_ob() = 
  tryParse(parseL1, |project://oberon0/tests/silver/negative/parse_errors/L1/reserved_else.ob|) != -1; 

public test bool NEG_parse_L1_silver_reserved_begin_ob() = 
  tryParse(parseL1, |project://oberon0/tests/silver/negative/parse_errors/L1/reserved_begin.ob|) != -1; 

public test bool NEG_parse_L1_silver_reserved_do_ob() = 
  tryParse(parseL1, |project://oberon0/tests/silver/negative/parse_errors/L1/reserved_do.ob|) != -1; 

public test bool NEG_parse_L1_silver_reserved_end_ob() = 
  tryParse(parseL1, |project://oberon0/tests/silver/negative/parse_errors/L1/reserved_end.ob|) != -1; 

public test bool NEG_parse_L1_silver_orderofdeclaration_ob() = 
  tryParse(parseL1, |project://oberon0/tests/silver/negative/parse_errors/L1/orderofdeclaration.ob|) != -1; 

public test bool NEG_parse_L1_silver_reserved_then_ob() = 
  tryParse(parseL1, |project://oberon0/tests/silver/negative/parse_errors/L1/reserved_then.ob|) != -1; 

public test bool NEG_parse_L1_silver_reserved_mod_ob() = 
  tryParse(parseL1, |project://oberon0/tests/silver/negative/parse_errors/L1/reserved_mod.ob|) != -1; 

public test bool NEG_parse_L1_silver_if_no_end_ob() = 
  tryParse(parseL1, |project://oberon0/tests/silver/negative/parse_errors/L1/if_no_end.ob|) != -1; 

public test bool NEG_parse_L1_silver_if_no_then_ob() = 
  tryParse(parseL1, |project://oberon0/tests/silver/negative/parse_errors/L1/if_no_then.ob|) != -1; 

public test bool NEG_parse_L1_silver_identifiers_fail_ob() = 
  tryParse(parseL1, |project://oberon0/tests/silver/negative/parse_errors/L1/identifiers_fail.ob|) != -1; 

public test bool NEG_parse_L1_silver_reserved_to_ob() = 
  tryParse(parseL1, |project://oberon0/tests/silver/negative/parse_errors/L1/reserved_to.ob|) != -1; 

public test bool NEG_parse_L1_silver_reserved_elsif_ob() = 
  tryParse(parseL1, |project://oberon0/tests/silver/negative/parse_errors/L1/reserved_elsif.ob|) != -1; 

public test bool NEG_parse_L1_silver_reserved_type_ob() = 
  tryParse(parseL1, |project://oberon0/tests/silver/negative/parse_errors/L1/reserved_type.ob|) != -1; 

public test bool NEG_parse_L1_silver_while_no_do_ob() = 
  tryParse(parseL1, |project://oberon0/tests/silver/negative/parse_errors/L1/while_no_do.ob|) != -1; 

public test bool NEG_parse_L1_silver_reserved_or_ob() = 
  tryParse(parseL1, |project://oberon0/tests/silver/negative/parse_errors/L1/reserved_or.ob|) != -1; 

public test bool NEG_parse_L1_silver_reserved_while_ob() = 
  tryParse(parseL1, |project://oberon0/tests/silver/negative/parse_errors/L1/reserved_while.ob|) != -1; 

public test bool NEG_parse_L1_silver_reserved_of_ob() = 
  tryParse(parseL1, |project://oberon0/tests/silver/negative/parse_errors/L1/reserved_of.ob|) != -1; 

public test bool NEG_parse_L1_silver_reserved_div_ob() = 
  tryParse(parseL1, |project://oberon0/tests/silver/negative/parse_errors/L1/reserved_div.ob|) != -1; 

public test bool NEG_parse_L1_rascal_reserved2_ob() = 
  tryParse(parseL1, |project://oberon0/tests/rascal/negative/parse_errors/L1/reserved2.ob|) != -1; 

public test bool NEG_parse_L1_rascal_no_semi_ob() = 
  tryParse(parseL1, |project://oberon0/tests/rascal/negative/parse_errors/L1/no-semi.ob|) != -1; 

public test bool NEG_parse_L1_rascal_non_assoc2_ob() = 
  tryParse(parseL1, |project://oberon0/tests/rascal/negative/parse_errors/L1/non-assoc2.ob|) != -1; 

public test bool NEG_parse_L1_rascal_non_assoc3_ob() = 
  tryParse(parseL1, |project://oberon0/tests/rascal/negative/parse_errors/L1/non-assoc3.ob|) != -1; 

public test bool NEG_parse_L1_rascal_non_assoc5_ob() = 
  tryParse(parseL1, |project://oberon0/tests/rascal/negative/parse_errors/L1/non-assoc5.ob|) != -1; 

public test bool NEG_parse_L1_rascal_reserved3_ob() = 
  tryParse(parseL1, |project://oberon0/tests/rascal/negative/parse_errors/L1/reserved3.ob|) != -1; 

public test bool NEG_parse_L1_rascal_module_ob() = 
  tryParse(parseL1, |project://oberon0/tests/rascal/negative/parse_errors/L1/module.ob|) != -1; 

public test bool NEG_parse_L1_rascal_non_assoc6_ob() = 
  tryParse(parseL1, |project://oberon0/tests/rascal/negative/parse_errors/L1/non-assoc6.ob|) != -1; 

public test bool NEG_parse_L1_rascal_reserved1_ob() = 
  tryParse(parseL1, |project://oberon0/tests/rascal/negative/parse_errors/L1/reserved1.ob|) != -1; 

public test bool NEG_parse_L1_rascal_non_assoc1_ob() = 
  tryParse(parseL1, |project://oberon0/tests/rascal/negative/parse_errors/L1/non-assoc1.ob|) != -1; 

public test bool NEG_parse_L1_rascal_no_trailing_id_ob() = 
  tryParse(parseL1, |project://oberon0/tests/rascal/negative/parse_errors/L1/no-trailing-id.ob|) != -1; 

public test bool NEG_parse_L1_rascal_non_assoc4_ob() = 
  tryParse(parseL1, |project://oberon0/tests/rascal/negative/parse_errors/L1/non-assoc4.ob|) != -1; 

public test bool NEG_parse_L1_rascal_empty_ob() = 
  tryParse(parseL1, |project://oberon0/tests/rascal/negative/parse_errors/L1/empty.ob|) != -1; 

public test bool NEG_parse_L1_kiama_keywordsasname2_ob() = 
  tryParse(parseL1, |project://oberon0/tests/kiama/negative/parse_errors/L1/keywordsasname2.ob|) != -1; 

public test bool NEG_parse_L1_kiama_repeatsection_ob() = 
  tryParse(parseL1, |project://oberon0/tests/kiama/negative/parse_errors/L1/repeatsection.ob|) != -1; 

public test bool NEG_parse_L1_kiama_intoverflow_ob() = 
  tryParse(parseL1, |project://oberon0/tests/kiama/negative/parse_errors/L1/intoverflow.ob|) != -1; 

public test bool NEG_parse_L1_kiama_keywordasname1_ob() = 
  tryParse(parseL1, |project://oberon0/tests/kiama/negative/parse_errors/L1/keywordasname1.ob|) != -1; 

public test bool NEG_parse_L2_silver_reserved_by_ob() = 
  tryParse(parseL2, |project://oberon0/tests/silver/negative/parse_errors/L2/reserved_by.ob|) != -1; 

public test bool NEG_parse_L2_silver_reserved_for_ob() = 
  tryParse(parseL2, |project://oberon0/tests/silver/negative/parse_errors/L2/reserved_for.ob|) != -1; 

public test bool NEG_parse_L2_silver_reserved_case_ob() = 
  tryParse(parseL2, |project://oberon0/tests/silver/negative/parse_errors/L2/reserved_case.ob|) != -1; 

public test bool NEG_parse_L2_rascal_case_reserved_ob() = 
  tryParse(parseL2, |project://oberon0/tests/rascal/negative/parse_errors/L2/case-reserved.ob|) != -1; 

public test bool NEG_parse_L2_rascal_case_semi_ob() = 
  tryParse(parseL2, |project://oberon0/tests/rascal/negative/parse_errors/L2/case-semi.ob|) != -1; 

public test bool NEG_parse_L2_rascal_case_of_ob() = 
  tryParse(parseL2, |project://oberon0/tests/rascal/negative/parse_errors/L2/case-of.ob|) != -1; 

public test bool NEG_parse_L2_rascal_forloop_ob() = 
  tryParse(parseL2, |project://oberon0/tests/rascal/negative/parse_errors/L2/forloop.ob|) != -1; 

public test bool NEG_parse_L2_rascal_for_reserved_ob() = 
  tryParse(parseL2, |project://oberon0/tests/rascal/negative/parse_errors/L2/for-reserved.ob|) != -1; 

public test bool NEG_parse_L2_rascal_of_reserved_ob() = 
  tryParse(parseL2, |project://oberon0/tests/rascal/negative/parse_errors/L2/of-reserved.ob|) != -1; 

public test bool NEG_parse_L2_rascal_forloop2_ob() = 
  tryParse(parseL2, |project://oberon0/tests/rascal/negative/parse_errors/L2/forloop2.ob|) != -1; 

public test bool NEG_parse_L2_rascal_case_sep_ob() = 
  tryParse(parseL2, |project://oberon0/tests/rascal/negative/parse_errors/L2/case-sep.ob|) != -1; 

public test bool NEG_parse_L2_kiama_casenoclause_ob() = 
  tryParse(parseL2, |project://oberon0/tests/kiama/negative/parse_errors/L2/casenoclause.ob|) != -1; 

public test bool NEG_parse_L3_silver_6_proc_no_end_ob() = 
  tryParse(parseL3, |project://oberon0/tests/silver/negative/parse_errors/L3/6_proc_no_end.ob|) != -1; 

public test bool NEG_parse_L3_silver_reserved_procedure_ob() = 
  tryParse(parseL3, |project://oberon0/tests/silver/negative/parse_errors/L3/reserved_procedure.ob|) != -1; 

public test bool NEG_parse_L3_rascal_proc_reserved_ob() = 
  tryParse(parseL3, |project://oberon0/tests/rascal/negative/parse_errors/L3/proc-reserved.ob|) != -1; 

public test bool NEG_parse_L3_rascal_formals1_ob() = 
  tryParse(parseL3, |project://oberon0/tests/rascal/negative/parse_errors/L3/formals1.ob|) != -1; 

public test bool NEG_parse_L3_rascal_formals2_ob() = 
  tryParse(parseL3, |project://oberon0/tests/rascal/negative/parse_errors/L3/formals2.ob|) != -1; 

public test bool NEG_parse_L4_silver_reserved_array_ob() = 
  tryParse(parseL4, |project://oberon0/tests/silver/negative/parse_errors/L4/reserved_array.ob|) != -1; 

public test bool NEG_parse_L4_silver_reserved_record_ob() = 
  tryParse(parseL4, |project://oberon0/tests/silver/negative/parse_errors/L4/reserved_record.ob|) != -1; 

public test bool NEG_parse_L4_silver_record_no_end_ob() = 
  tryParse(parseL4, |project://oberon0/tests/silver/negative/parse_errors/L4/record_no_end.ob|) != -1; 

public test bool NEG_parse_L4_rascal_record_reserved_ob() = 
  tryParse(parseL4, |project://oberon0/tests/rascal/negative/parse_errors/L4/record-reserved.ob|) != -1; 

public test bool NEG_parse_L4_rascal_array_reserved_ob() = 
  tryParse(parseL4, |project://oberon0/tests/rascal/negative/parse_errors/L4/array-reserved.ob|) != -1; 

public test bool NEG_check_L1_jastadd_3_TypeCheckingIfStmt_ob() = 
  tryCheck(checkL1, |project://oberon0/tests/jastadd/negative/type_errors/L1/3_TypeCheckingIfStmt.ob|) == 3; 

public test bool NEG_check_L1_jastadd_2_ConstDecl_ob() = 
  tryCheck(checkL1, |project://oberon0/tests/jastadd/negative/type_errors/L1/2_ConstDecl.ob|) == 2; 

public test bool NEG_check_L1_jastadd_7_CombiningIntegerAndBoolean_ob() = 
  tryCheck(checkL1, |project://oberon0/tests/jastadd/negative/type_errors/L1/7_CombiningIntegerAndBoolean.ob|) == 7; 

public test bool NEG_check_L1_jastadd_4_AssignmentToConst_ob() = 
  tryCheck(checkL1, |project://oberon0/tests/jastadd/negative/type_errors/L1/4_AssignmentToConst.ob|) == 4; 

public test bool NEG_check_L1_jastadd_3_TypeCheckingAndOp_ob() = 
  tryCheck(checkL1, |project://oberon0/tests/jastadd/negative/type_errors/L1/3_TypeCheckingAndOp.ob|) == 3; 

public test bool NEG_check_L1_jastadd_4_TypeCheckingWhileStmt_ob() = 
  tryCheck(checkL1, |project://oberon0/tests/jastadd/negative/type_errors/L1/4_TypeCheckingWhileStmt.ob|) == 4; 

public test bool NEG_check_L1_jastadd_4_TypeCheckingIfStmt2_ob() = 
  tryCheck(checkL1, |project://oberon0/tests/jastadd/negative/type_errors/L1/4_TypeCheckingIfStmt2.ob|) == 4; 

public test bool NEG_check_L1_jastadd_5_TypeChecking_ob() = 
  tryCheck(checkL1, |project://oberon0/tests/jastadd/negative/type_errors/L1/5_TypeChecking.ob|) == 5; 

public test bool NEG_check_L1_jastadd_4_AssignmentToType_ob() = 
  tryCheck(checkL1, |project://oberon0/tests/jastadd/negative/type_errors/L1/4_AssignmentToType.ob|) == 4; 

public test bool NEG_check_L1_jastadd_4_TypeCheckingPlusOp_ob() = 
  tryCheck(checkL1, |project://oberon0/tests/jastadd/negative/type_errors/L1/4_TypeCheckingPlusOp.ob|) == 4; 

public test bool NEG_check_L1_silver_10_add_bool_int_ob() = 
  tryCheck(checkL1, |project://oberon0/tests/silver/negative/type_errors/L1/10_add_bool_int.ob|) == 10; 

public test bool NEG_check_L1_silver_10_ge_bool_int_ob() = 
  tryCheck(checkL1, |project://oberon0/tests/silver/negative/type_errors/L1/10_ge_bool_int.ob|) == 10; 

public test bool NEG_check_L1_silver_10_div_bool_int_ob() = 
  tryCheck(checkL1, |project://oberon0/tests/silver/negative/type_errors/L1/10_div_bool_int.ob|) == 10; 

public test bool NEG_check_L1_silver_11_non_bool_elsif_ob() = 
  tryCheck(checkL1, |project://oberon0/tests/silver/negative/type_errors/L1/11_non_bool_elsif.ob|) == 11; 

public test bool NEG_check_L1_silver_10_eq_bool_int_ob() = 
  tryCheck(checkL1, |project://oberon0/tests/silver/negative/type_errors/L1/10_eq_bool_int.ob|) == 10; 

public test bool NEG_check_L1_silver_10_le_int_bool_ob() = 
  tryCheck(checkL1, |project://oberon0/tests/silver/negative/type_errors/L1/10_le_int_bool.ob|) == 10; 

public test bool NEG_check_L1_silver_10_eq_int_bool_ob() = 
  tryCheck(checkL1, |project://oberon0/tests/silver/negative/type_errors/L1/10_eq_int_bool.ob|) == 10; 

public test bool NEG_check_L1_silver_10_mult_bool_int_ob() = 
  tryCheck(checkL1, |project://oberon0/tests/silver/negative/type_errors/L1/10_mult_bool_int.ob|) == 10; 

public test bool NEG_check_L1_silver_10_div_int_bool_ob() = 
  tryCheck(checkL1, |project://oberon0/tests/silver/negative/type_errors/L1/10_div_int_bool.ob|) == 10; 

public test bool NEG_check_L1_silver_10_ne_bool_int_ob() = 
  tryCheck(checkL1, |project://oberon0/tests/silver/negative/type_errors/L1/10_ne_bool_int.ob|) == 10; 

public test bool NEG_check_L1_silver_10_ge_int_bool_ob() = 
  tryCheck(checkL1, |project://oberon0/tests/silver/negative/type_errors/L1/10_ge_int_bool.ob|) == 10; 

public test bool NEG_check_L1_silver_10_sub_bool_int_ob() = 
  tryCheck(checkL1, |project://oberon0/tests/silver/negative/type_errors/L1/10_sub_bool_int.ob|) == 10; 

public test bool NEG_check_L1_silver_10_gt_bool_int_ob() = 
  tryCheck(checkL1, |project://oberon0/tests/silver/negative/type_errors/L1/10_gt_bool_int.ob|) == 10; 

public test bool NEG_check_L1_silver_10_mod_bool_int_ob() = 
  tryCheck(checkL1, |project://oberon0/tests/silver/negative/type_errors/L1/10_mod_bool_int.ob|) == 10; 

public test bool NEG_check_L1_silver_10_ne_int_bool_ob() = 
  tryCheck(checkL1, |project://oberon0/tests/silver/negative/type_errors/L1/10_ne_int_bool.ob|) == 10; 

public test bool NEG_check_L1_silver_8_non_boolean_if_ob() = 
  tryCheck(checkL1, |project://oberon0/tests/silver/negative/type_errors/L1/8_non_boolean_if.ob|) == 8; 

public test bool NEG_check_L1_silver_10_mult_int_bool_ob() = 
  tryCheck(checkL1, |project://oberon0/tests/silver/negative/type_errors/L1/10_mult_int_bool.ob|) == 10; 

public test bool NEG_check_L1_silver_10_add_int_bool_ob() = 
  tryCheck(checkL1, |project://oberon0/tests/silver/negative/type_errors/L1/10_add_int_bool.ob|) == 10; 

public test bool NEG_check_L1_silver_10_gt_int_bool_ob() = 
  tryCheck(checkL1, |project://oberon0/tests/silver/negative/type_errors/L1/10_gt_int_bool.ob|) == 10; 

public test bool NEG_check_L1_silver_10_mod_int_bool_ob() = 
  tryCheck(checkL1, |project://oberon0/tests/silver/negative/type_errors/L1/10_mod_int_bool.ob|) == 10; 

public test bool NEG_check_L1_silver_10_lt_int_bool_ob() = 
  tryCheck(checkL1, |project://oberon0/tests/silver/negative/type_errors/L1/10_lt_int_bool.ob|) == 10; 

public test bool NEG_check_L1_silver_10_le_bool_int_ob() = 
  tryCheck(checkL1, |project://oberon0/tests/silver/negative/type_errors/L1/10_le_bool_int.ob|) == 10; 

public test bool NEG_check_L1_silver_10_lt_bool_int_ob() = 
  tryCheck(checkL1, |project://oberon0/tests/silver/negative/type_errors/L1/10_lt_bool_int.ob|) == 10; 

public test bool NEG_check_L1_silver_10_sub_int_bool_ob() = 
  tryCheck(checkL1, |project://oberon0/tests/silver/negative/type_errors/L1/10_sub_int_bool.ob|) == 10; 

public test bool NEG_check_L1_silver_10_non_bool_while_ob() = 
  tryCheck(checkL1, |project://oberon0/tests/silver/negative/type_errors/L1/10_non_bool_while.ob|) == 10; 

public test bool NEG_check_L1_kiama_4_const2_ob() = 
  tryCheck(checkL1, |project://oberon0/tests/kiama/negative/type_errors/L1/4_const2.ob|) == 4; 

public test bool NEG_check_L1_kiama_5_nonintconstant2_ob() = 
  tryCheck(checkL1, |project://oberon0/tests/kiama/negative/type_errors/L1/5_nonintconstant2.ob|) == 5; 

public test bool NEG_check_L1_kiama_7_badeq4_ob() = 
  tryCheck(checkL1, |project://oberon0/tests/kiama/negative/type_errors/L1/7_badeq4.ob|) == 7; 

public test bool NEG_check_L1_kiama_7_badcond_ob() = 
  tryCheck(checkL1, |project://oberon0/tests/kiama/negative/type_errors/L1/7_badcond.ob|) == 7; 

public test bool NEG_check_L1_kiama_8_badeq1_ob() = 
  tryCheck(checkL1, |project://oberon0/tests/kiama/negative/type_errors/L1/8_badeq1.ob|) == 8; 

public test bool NEG_check_L1_kiama_7_badwhile_ob() = 
  tryCheck(checkL1, |project://oberon0/tests/kiama/negative/type_errors/L1/7_badwhile.ob|) == 7; 

public test bool NEG_check_L1_kiama_4_const1_ob() = 
  tryCheck(checkL1, |project://oberon0/tests/kiama/negative/type_errors/L1/4_const1.ob|) == 4; 

public test bool NEG_check_L1_kiama_8_badeq2_ob() = 
  tryCheck(checkL1, |project://oberon0/tests/kiama/negative/type_errors/L1/8_badeq2.ob|) == 8; 

public test bool NEG_check_L1_kiama_7_badeq3_ob() = 
  tryCheck(checkL1, |project://oberon0/tests/kiama/negative/type_errors/L1/7_badeq3.ob|) == 7; 

public test bool NEG_check_L1_kiama_4_nonintconstant1_ob() = 
  tryCheck(checkL1, |project://oberon0/tests/kiama/negative/type_errors/L1/4_nonintconstant1.ob|) == 4; 

public test bool NEG_check_L2_jastadd_6_TypeCheckingCaseStmt2_ob() = 
  tryCheck(checkL2, |project://oberon0/tests/jastadd/negative/type_errors/L2/6_TypeCheckingCaseStmt2.ob|) == 6; 

public test bool NEG_check_L2_jastadd_3_TypeCheckingCaseStmt4_ob() = 
  tryCheck(checkL2, |project://oberon0/tests/jastadd/negative/type_errors/L2/3_TypeCheckingCaseStmt4.ob|) == 3; 

public test bool NEG_check_L2_jastadd_4_TypeCheckingForStmt_ob() = 
  tryCheck(checkL2, |project://oberon0/tests/jastadd/negative/type_errors/L2/4_TypeCheckingForStmt.ob|) == 4; 

public test bool NEG_check_L2_jastadd_4_TypeCheckingForStmt4_ob() = 
  tryCheck(checkL2, |project://oberon0/tests/jastadd/negative/type_errors/L2/4_TypeCheckingForStmt4.ob|) == 4; 

public test bool NEG_check_L2_jastadd_4_TypeCheckingForStmt6_ob() = 
  tryCheck(checkL2, |project://oberon0/tests/jastadd/negative/type_errors/L2/4_TypeCheckingForStmt6.ob|) == 4; 

public test bool NEG_check_L2_jastadd_5_TypeCheckingCaseStmt_ob() = 
  tryCheck(checkL2, |project://oberon0/tests/jastadd/negative/type_errors/L2/5_TypeCheckingCaseStmt.ob|) == 5; 

public test bool NEG_check_L2_jastadd_3_TypeCheckingForStmt3_ob() = 
  tryCheck(checkL2, |project://oberon0/tests/jastadd/negative/type_errors/L2/3_TypeCheckingForStmt3.ob|) == 3; 

public test bool NEG_check_L2_jastadd_4_TypeCheckingForStmt2_ob() = 
  tryCheck(checkL2, |project://oberon0/tests/jastadd/negative/type_errors/L2/4_TypeCheckingForStmt2.ob|) == 4; 

public test bool NEG_check_L2_jastadd_7_TypeCheckingCaseStmt3_ob() = 
  tryCheck(checkL2, |project://oberon0/tests/jastadd/negative/type_errors/L2/7_TypeCheckingCaseStmt3.ob|) == 7; 

public test bool NEG_check_L2_jastadd_4_TypeCheckingForStmt5_ob() = 
  tryCheck(checkL2, |project://oberon0/tests/jastadd/negative/type_errors/L2/4_TypeCheckingForStmt5.ob|) == 4; 

public test bool NEG_check_L2_silver_8_bool_upper_limit_case_ob() = 
  tryCheck(checkL2, |project://oberon0/tests/silver/negative/type_errors/L2/8_bool_upper_limit_case.ob|) == 8; 

public test bool NEG_check_L2_silver_11_var_bool_limit_case_ob() = 
  tryCheck(checkL2, |project://oberon0/tests/silver/negative/type_errors/L2/11_var_bool_limit_case.ob|) == 11; 

public test bool NEG_check_L2_silver_8_bool_var_case_ob() = 
  tryCheck(checkL2, |project://oberon0/tests/silver/negative/type_errors/L2/8_bool_var_case.ob|) == 8; 

public test bool NEG_check_L2_silver_9_var_bool_high_lim_for_ob() = 
  tryCheck(checkL2, |project://oberon0/tests/silver/negative/type_errors/L2/9_var_bool_high_lim_for.ob|) == 9; 

public test bool NEG_check_L2_silver_10_var_bool_upper_lim_case_ob() = 
  tryCheck(checkL2, |project://oberon0/tests/silver/negative/type_errors/L2/10_var_bool_upper_lim_case.ob|) == 10; 

public test bool NEG_check_L2_silver_7_bool_upper_limit_for_ob() = 
  tryCheck(checkL2, |project://oberon0/tests/silver/negative/type_errors/L2/7_bool_upper_limit_for.ob|) == 7; 

public test bool NEG_check_L2_silver_9_var_bool_low_lim_for_ob() = 
  tryCheck(checkL2, |project://oberon0/tests/silver/negative/type_errors/L2/9_var_bool_low_lim_for.ob|) == 9; 

public test bool NEG_check_L2_silver_9_bool_var_for_ob() = 
  tryCheck(checkL2, |project://oberon0/tests/silver/negative/type_errors/L2/9_bool_var_for.ob|) == 9; 

public test bool NEG_check_L2_silver_8_bool_low_limit_case_ob() = 
  tryCheck(checkL2, |project://oberon0/tests/silver/negative/type_errors/L2/8_bool_low_limit_case.ob|) == 8; 

public test bool NEG_check_L2_silver_10_var_bool_low_lim_case_ob() = 
  tryCheck(checkL2, |project://oberon0/tests/silver/negative/type_errors/L2/10_var_bool_low_lim_case.ob|) == 10; 

public test bool NEG_check_L2_silver_7_bool_lower_limit_for_ob() = 
  tryCheck(checkL2, |project://oberon0/tests/silver/negative/type_errors/L2/7_bool_lower_limit_for.ob|) == 7; 

public test bool NEG_check_L2_silver_9_bool_limit_case_ob() = 
  tryCheck(checkL2, |project://oberon0/tests/silver/negative/type_errors/L2/9_bool_limit_case.ob|) == 9; 

public test bool NEG_check_L2_kiama_10_badfor1_ob() = 
  tryCheck(checkL2, |project://oberon0/tests/kiama/negative/type_errors/L2/10_badfor1.ob|) == 10; 

public test bool NEG_check_L2_kiama_9_badcase4_ob() = 
  tryCheck(checkL2, |project://oberon0/tests/kiama/negative/type_errors/L2/9_badcase4.ob|) == 9; 

public test bool NEG_check_L2_kiama_8_badcase1_ob() = 
  tryCheck(checkL2, |project://oberon0/tests/kiama/negative/type_errors/L2/8_badcase1.ob|) == 8; 

public test bool NEG_check_L2_kiama_10_badfor2_ob() = 
  tryCheck(checkL2, |project://oberon0/tests/kiama/negative/type_errors/L2/10_badfor2.ob|) == 10; 

public test bool NEG_check_L2_kiama_8_badcase3_ob() = 
  tryCheck(checkL2, |project://oberon0/tests/kiama/negative/type_errors/L2/8_badcase3.ob|) == 8; 

public test bool NEG_check_L2_kiama_7_badcase2_ob() = 
  tryCheck(checkL2, |project://oberon0/tests/kiama/negative/type_errors/L2/7_badcase2.ob|) == 7; 

public test bool NEG_check_L2_kiama_8_badfor4_ob() = 
  tryCheck(checkL2, |project://oberon0/tests/kiama/negative/type_errors/L2/8_badfor4.ob|) == 8; 

public test bool NEG_check_L2_kiama_8_badfor3_ob() = 
  tryCheck(checkL2, |project://oberon0/tests/kiama/negative/type_errors/L2/8_badfor3.ob|) == 8; 

public test bool NEG_check_L3_jastadd_4_PredefinedProcPars3_ob() = 
  tryCheck(checkL3, |project://oberon0/tests/jastadd/negative/type_errors/L3/4_PredefinedProcPars3.ob|) == 4; 

public test bool NEG_check_L3_jastadd_3_ConstDecl3_ob() = 
  tryCheck(checkL3, |project://oberon0/tests/jastadd/negative/type_errors/L3/3_ConstDecl3.ob|) == 3; 

public test bool NEG_check_L3_jastadd_10_ProcCallVarPars3_ob() = 
  tryCheck(checkL3, |project://oberon0/tests/jastadd/negative/type_errors/L3/10_ProcCallVarPars3.ob|) == 10; 

public test bool NEG_check_L3_jastadd_10_UserDefinedProcCallPars3_ob() = 
  tryCheck(checkL3, |project://oberon0/tests/jastadd/negative/type_errors/L3/10_UserDefinedProcCallPars3.ob|) == 10; 

public test bool NEG_check_L3_jastadd_9_ProcCallVarPars2_ob() = 
  tryCheck(checkL3, |project://oberon0/tests/jastadd/negative/type_errors/L3/9_ProcCallVarPars2.ob|) == 9; 

public test bool NEG_check_L3_jastadd_10_UserDefinedProcCallPars4_ob() = 
  tryCheck(checkL3, |project://oberon0/tests/jastadd/negative/type_errors/L3/10_UserDefinedProcCallPars4.ob|) == 10; 

public test bool NEG_check_L3_jastadd_4_PredefinedProcPars2_ob() = 
  tryCheck(checkL3, |project://oberon0/tests/jastadd/negative/type_errors/L3/4_PredefinedProcPars2.ob|) == 4; 

public test bool NEG_check_L3_jastadd_10_UserDefinedProcCallPars2_ob() = 
  tryCheck(checkL3, |project://oberon0/tests/jastadd/negative/type_errors/L3/10_UserDefinedProcCallPars2.ob|) == 10; 

public test bool NEG_check_L3_jastadd_10_UserDefinedProcCallPars_ob() = 
  tryCheck(checkL3, |project://oberon0/tests/jastadd/negative/type_errors/L3/10_UserDefinedProcCallPars.ob|) == 10; 

public test bool NEG_check_L3_jastadd_7_NonProcedureCall3_ob() = 
  tryCheck(checkL3, |project://oberon0/tests/jastadd/negative/type_errors/L3/7_NonProcedureCall3.ob|) == 7; 

public test bool NEG_check_L3_jastadd_5_ConstDecl2_ob() = 
  tryCheck(checkL3, |project://oberon0/tests/jastadd/negative/type_errors/L3/5_ConstDecl2.ob|) == 5; 

public test bool NEG_check_L3_jastadd_4_ProcScopeRules_ob() = 
  tryCheck(checkL3, |project://oberon0/tests/jastadd/negative/type_errors/L3/4_ProcScopeRules.ob|) == 4; 

public test bool NEG_check_L3_jastadd_7_NonProcedureCall_ob() = 
  tryCheck(checkL3, |project://oberon0/tests/jastadd/negative/type_errors/L3/7_NonProcedureCall.ob|) == 7; 

public test bool NEG_check_L3_jastadd_4_PredefinedProcPars4_ob() = 
  tryCheck(checkL3, |project://oberon0/tests/jastadd/negative/type_errors/L3/4_PredefinedProcPars4.ob|) == 4; 

public test bool NEG_check_L3_jastadd_9_ProcCallVarPars_ob() = 
  tryCheck(checkL3, |project://oberon0/tests/jastadd/negative/type_errors/L3/9_ProcCallVarPars.ob|) == 9; 

public test bool NEG_check_L3_jastadd_3_ConstDecl4_ob() = 
  tryCheck(checkL3, |project://oberon0/tests/jastadd/negative/type_errors/L3/3_ConstDecl4.ob|) == 3; 

public test bool NEG_check_L3_jastadd_8_NonProcedureCall4_ob() = 
  tryCheck(checkL3, |project://oberon0/tests/jastadd/negative/type_errors/L3/8_NonProcedureCall4.ob|) == 8; 

public test bool NEG_check_L3_jastadd_4_PredefinedProcPars_ob() = 
  tryCheck(checkL3, |project://oberon0/tests/jastadd/negative/type_errors/L3/4_PredefinedProcPars.ob|) == 4; 

public test bool NEG_check_L3_jastadd_7_NonProcedureCall2_ob() = 
  tryCheck(checkL3, |project://oberon0/tests/jastadd/negative/type_errors/L3/7_NonProcedureCall2.ob|) == 7; 

public test bool NEG_check_L3_silver_13_param_wanted_bool_ob() = 
  tryCheck(checkL3, |project://oberon0/tests/silver/negative/type_errors/L3/13_param_wanted_bool.ob|) == 13; 

public test bool NEG_check_L3_silver_13_param_wanted_int_ob() = 
  tryCheck(checkL3, |project://oberon0/tests/silver/negative/type_errors/L3/13_param_wanted_int.ob|) == 13; 

public test bool NEG_check_L4_jastadd_17_CombiningArraysAndRecords_ob() = 
  tryCheck(checkL4, |project://oberon0/tests/jastadd/negative/type_errors/L4/17_CombiningArraysAndRecords.ob|) == 17; 

public test bool NEG_check_L4_jastadd_6_IllegalAssignment3_ob() = 
  tryCheck(checkL4, |project://oberon0/tests/jastadd/negative/type_errors/L4/6_IllegalAssignment3.ob|) == 6; 

public test bool NEG_check_L4_jastadd_8_ArrayAccess3_ob() = 
  tryCheck(checkL4, |project://oberon0/tests/jastadd/negative/type_errors/L4/8_ArrayAccess3.ob|) == 8; 

public test bool NEG_check_L4_jastadd_2_ArrayDecl_ob() = 
  tryCheck(checkL4, |project://oberon0/tests/jastadd/negative/type_errors/L4/2_ArrayDecl.ob|) == 2; 

public test bool NEG_check_L4_jastadd_7_IllegalAssignment2_ob() = 
  tryCheck(checkL4, |project://oberon0/tests/jastadd/negative/type_errors/L4/7_IllegalAssignment2.ob|) == 7; 

public test bool NEG_check_L4_jastadd_15_ProcPars3_ob() = 
  tryCheck(checkL4, |project://oberon0/tests/jastadd/negative/type_errors/L4/15_ProcPars3.ob|) == 15; 

public test bool NEG_check_L4_jastadd_10_ProcPars2_ob() = 
  tryCheck(checkL4, |project://oberon0/tests/jastadd/negative/type_errors/L4/10_ProcPars2.ob|) == 10; 

public test bool NEG_check_L4_jastadd_5_ArrayAccessIntegerType_ob() = 
  tryCheck(checkL4, |project://oberon0/tests/jastadd/negative/type_errors/L4/5_ArrayAccessIntegerType.ob|) == 5; 

public test bool NEG_check_L4_jastadd_15_ProcPars4_ob() = 
  tryCheck(checkL4, |project://oberon0/tests/jastadd/negative/type_errors/L4/15_ProcPars4.ob|) == 15; 

public test bool NEG_check_L4_jastadd_8_ArrayAccess2_ob() = 
  tryCheck(checkL4, |project://oberon0/tests/jastadd/negative/type_errors/L4/8_ArrayAccess2.ob|) == 8; 

public test bool NEG_check_L4_jastadd_8_ArrayAccess_ob() = 
  tryCheck(checkL4, |project://oberon0/tests/jastadd/negative/type_errors/L4/8_ArrayAccess.ob|) == 8; 

public test bool NEG_check_L4_jastadd_10_RecordAccess_ob() = 
  tryCheck(checkL4, |project://oberon0/tests/jastadd/negative/type_errors/L4/10_RecordAccess.ob|) == 10; 

public test bool NEG_check_L4_jastadd_9_OutOfBounds_ob() = 
  tryCheck(checkL4, |project://oberon0/tests/jastadd/negative/type_errors/L4/9_OutOfBounds.ob|) == 9; 

public test bool NEG_check_L4_jastadd_9_OutOfBounds2_ob() = 
  tryCheck(checkL4, |project://oberon0/tests/jastadd/negative/type_errors/L4/9_OutOfBounds2.ob|) == 9; 

public test bool NEG_check_L4_jastadd_10_RecordAccess2_ob() = 
  tryCheck(checkL4, |project://oberon0/tests/jastadd/negative/type_errors/L4/10_RecordAccess2.ob|) == 10; 

public test bool NEG_check_L4_jastadd_17_CombiningArraysAndRecords2_ob() = 
  tryCheck(checkL4, |project://oberon0/tests/jastadd/negative/type_errors/L4/17_CombiningArraysAndRecords2.ob|) == 17; 

public test bool NEG_check_L4_jastadd_17_CombiningArraysAndRecords3_ob() = 
  tryCheck(checkL4, |project://oberon0/tests/jastadd/negative/type_errors/L4/17_CombiningArraysAndRecords3.ob|) == 17; 

public test bool NEG_check_L4_jastadd_3_ArrayDecl2_ob() = 
  tryCheck(checkL4, |project://oberon0/tests/jastadd/negative/type_errors/L4/3_ArrayDecl2.ob|) == 3; 

public test bool NEG_check_L4_jastadd_7_IllegalAssignment_ob() = 
  tryCheck(checkL4, |project://oberon0/tests/jastadd/negative/type_errors/L4/7_IllegalAssignment.ob|) == 7; 

public test bool NEG_check_L4_jastadd_10_ProcPars_ob() = 
  tryCheck(checkL4, |project://oberon0/tests/jastadd/negative/type_errors/L4/10_ProcPars.ob|) == 10; 

public test bool NEG_check_L4_silver_7_no_var_array_in_proc_ob() = 
  tryCheck(checkL4, |project://oberon0/tests/silver/negative/type_errors/L4/7_no_var_array_in_proc.ob|) == 7; 

public test bool NEG_check_L4_silver_15_int_in_bool_record_ob() = 
  tryCheck(checkL4, |project://oberon0/tests/silver/negative/type_errors/L4/15_int_in_bool_record.ob|) == 15; 

public test bool NEG_check_L4_silver_7_int_in_bool_array_ob() = 
  tryCheck(checkL4, |project://oberon0/tests/silver/negative/type_errors/L4/7_int_in_bool_array.ob|) == 7; 

public test bool NEG_check_L4_silver_7_bool_in_int_array_ob() = 
  tryCheck(checkL4, |project://oberon0/tests/silver/negative/type_errors/L4/7_bool_in_int_array.ob|) == 7; 

public test bool NEG_check_L4_silver_7_array_in_proc_ob() = 
  tryCheck(checkL4, |project://oberon0/tests/silver/negative/type_errors/L4/7_array_in_proc.ob|) == 7; 

public test bool NEG_check_L4_silver_15_bool_in_int_record_ob() = 
  tryCheck(checkL4, |project://oberon0/tests/silver/negative/type_errors/L4/15_bool_in_int_record.ob|) == 15; 

public test bool NEG_check_L4_silver_3_bool_len_array_ob() = 
  tryCheck(checkL4, |project://oberon0/tests/silver/negative/type_errors/L4/3_bool_len_array.ob|) == 3; 

public test bool NEG_check_L4_silver_9_nominal_types_ob() = 
  tryCheck(checkL4, |project://oberon0/tests/silver/negative/type_errors/L4/9_nominal_types.ob|) == 9; 

public test bool NEG_check_L4_kiama_7_badarray8_ob() = 
  tryCheck(checkL4, |project://oberon0/tests/kiama/negative/type_errors/L4/7_badarray8.ob|) == 7; 

public test bool NEG_check_L4_kiama_7_badarray12_ob() = 
  tryCheck(checkL4, |project://oberon0/tests/kiama/negative/type_errors/L4/7_badarray12.ob|) == 7; 

public test bool NEG_check_L4_kiama_7_badarray9_ob() = 
  tryCheck(checkL4, |project://oberon0/tests/kiama/negative/type_errors/L4/7_badarray9.ob|) == 7; 

public test bool NEG_check_L4_kiama_11_badrecord8_ob() = 
  tryCheck(checkL4, |project://oberon0/tests/kiama/negative/type_errors/L4/11_badrecord8.ob|) == 11; 

public test bool NEG_check_L4_kiama_10_badarray6_ob() = 
  tryCheck(checkL4, |project://oberon0/tests/kiama/negative/type_errors/L4/10_badarray6.ob|) == 10; 

public test bool NEG_check_L4_kiama_10_badrecord4_ob() = 
  tryCheck(checkL4, |project://oberon0/tests/kiama/negative/type_errors/L4/10_badrecord4.ob|) == 10; 

public test bool NEG_check_L4_kiama_11_badrecord5_ob() = 
  tryCheck(checkL4, |project://oberon0/tests/kiama/negative/type_errors/L4/11_badrecord5.ob|) == 11; 

public test bool NEG_check_L4_kiama_7_badarray10_ob() = 
  tryCheck(checkL4, |project://oberon0/tests/kiama/negative/type_errors/L4/7_badarray10.ob|) == 7; 

public test bool NEG_check_L4_kiama_11_badrecord2_ob() = 
  tryCheck(checkL4, |project://oberon0/tests/kiama/negative/type_errors/L4/11_badrecord2.ob|) == 11; 

public test bool NEG_check_L4_kiama_7_badrecord3_ob() = 
  tryCheck(checkL4, |project://oberon0/tests/kiama/negative/type_errors/L4/7_badrecord3.ob|) == 7; 

public test bool NEG_check_L4_kiama_8_badrecord9_ob() = 
  tryCheck(checkL4, |project://oberon0/tests/kiama/negative/type_errors/L4/8_badrecord9.ob|) == 8; 

public test bool NEG_check_L4_kiama_7_badarray11_ob() = 
  tryCheck(checkL4, |project://oberon0/tests/kiama/negative/type_errors/L4/7_badarray11.ob|) == 7; 

public test bool NEG_check_L4_kiama_4_badarray1_ob() = 
  tryCheck(checkL4, |project://oberon0/tests/kiama/negative/type_errors/L4/4_badarray1.ob|) == 4; 

public test bool NEG_check_L4_kiama_11_badarray5_ob() = 
  tryCheck(checkL4, |project://oberon0/tests/kiama/negative/type_errors/L4/11_badarray5.ob|) == 11; 

public test bool NEG_check_L4_kiama_4_badarray3_ob() = 
  tryCheck(checkL4, |project://oberon0/tests/kiama/negative/type_errors/L4/4_badarray3.ob|) == 4; 

public test bool NEG_check_L4_kiama_7_badrecord7_ob() = 
  tryCheck(checkL4, |project://oberon0/tests/kiama/negative/type_errors/L4/7_badrecord7.ob|) == 7; 

public test bool NEG_check_L4_kiama_10_badarray4_ob() = 
  tryCheck(checkL4, |project://oberon0/tests/kiama/negative/type_errors/L4/10_badarray4.ob|) == 10; 

public test bool NEG_check_L4_kiama_7_badrecord6_ob() = 
  tryCheck(checkL4, |project://oberon0/tests/kiama/negative/type_errors/L4/7_badrecord6.ob|) == 7; 

public test bool NEG_check_L4_kiama_11_badarray7_ob() = 
  tryCheck(checkL4, |project://oberon0/tests/kiama/negative/type_errors/L4/11_badarray7.ob|) == 11; 

public test bool NEG_bind_L1_jastadd_2_UnknownTypeName2_ob() = 
  tryBind(bindL1, |project://oberon0/tests/jastadd/negative/name_errors/L1/2_UnknownTypeName2.ob|) == 2; 

public test bool NEG_bind_L1_jastadd_2_VarCircularity_ob() = 
  tryBind(bindL1, |project://oberon0/tests/jastadd/negative/name_errors/L1/2_VarCircularity.ob|) == 2; 

public test bool NEG_bind_L1_jastadd_2_TypeCircularity_ob() = 
  tryBind(bindL1, |project://oberon0/tests/jastadd/negative/name_errors/L1/2_TypeCircularity.ob|) == 2; 

public test bool NEG_bind_L1_jastadd_2_ConstCircularity_ob() = 
  tryBind(bindL1, |project://oberon0/tests/jastadd/negative/name_errors/L1/2_ConstCircularity.ob|) == 2; 

public test bool NEG_bind_L1_jastadd_3_MultipleDeclarations2_ob() = 
  tryBind(bindL1, |project://oberon0/tests/jastadd/negative/name_errors/L1/3_MultipleDeclarations2.ob|) == 3; 

public test bool NEG_bind_L1_jastadd_2_UnknownTypeName_ob() = 
  tryBind(bindL1, |project://oberon0/tests/jastadd/negative/name_errors/L1/2_UnknownTypeName.ob|) == 2; 

public test bool NEG_bind_L1_jastadd_2_MultipleDeclarations3_ob() = 
  tryBind(bindL1, |project://oberon0/tests/jastadd/negative/name_errors/L1/2_MultipleDeclarations3.ob|) == 2; 

public test bool NEG_bind_L1_jastadd_2_ModuleName_ob() = 
  tryBind(bindL1, |project://oberon0/tests/jastadd/negative/name_errors/L1/2_ModuleName.ob|) == 2; 

public test bool NEG_bind_L1_jastadd_3_MultipleDeclarations_ob() = 
  tryBind(bindL1, |project://oberon0/tests/jastadd/negative/name_errors/L1/3_MultipleDeclarations.ob|) == 3; 

public test bool NEG_bind_L1_jastadd_2_ConstCircularity2_ob() = 
  tryBind(bindL1, |project://oberon0/tests/jastadd/negative/name_errors/L1/2_ConstCircularity2.ob|) == 2; 

public test bool NEG_bind_L1_silver_5_const_var_same_ob() = 
  tryBind(bindL1, |project://oberon0/tests/silver/negative/name_errors/L1/5_const_var_same.ob|) == 5; 

public test bool NEG_bind_L1_silver_3_var_same_scope_ob() = 
  tryBind(bindL1, |project://oberon0/tests/silver/negative/name_errors/L1/3_var_same_scope.ob|) == 3; 

public test bool NEG_bind_L1_silver_5_wrong_module_ob() = 
  tryBind(bindL1, |project://oberon0/tests/silver/negative/name_errors/L1/5_wrong_module.ob|) == 5; 

public test bool NEG_bind_L1_silver_4_const_same_scope_ob() = 
  tryBind(bindL1, |project://oberon0/tests/silver/negative/name_errors/L1/4_const_same_scope.ob|) == 4; 

public test bool NEG_bind_L1_silver_4_type_same_scope_ob() = 
  tryBind(bindL1, |project://oberon0/tests/silver/negative/name_errors/L1/4_type_same_scope.ob|) == 4; 

public test bool NEG_bind_L1_rascal_7_dupl_id_ob() = 
  tryBind(bindL1, |project://oberon0/tests/rascal/negative/name_errors/L1/7_dupl-id.ob|) == 7; 

public test bool NEG_bind_L1_rascal_4_undecl_const_ob() = 
  tryBind(bindL1, |project://oberon0/tests/rascal/negative/name_errors/L1/4_undecl-const.ob|) == 4; 

public test bool NEG_bind_L1_rascal_4_undecl_type_ob() = 
  tryBind(bindL1, |project://oberon0/tests/rascal/negative/name_errors/L1/4_undecl-type.ob|) == 4; 

public test bool NEG_bind_L1_rascal_7_assign_type_ob() = 
  tryBind(bindL1, |project://oberon0/tests/rascal/negative/name_errors/L1/7_assign_type.ob|) == 7; 

public test bool NEG_bind_L1_rascal_7_undecl_id_ob() = 
  tryBind(bindL1, |project://oberon0/tests/rascal/negative/name_errors/L1/7_undecl-id.ob|) == 7; 

public test bool NEG_bind_L1_rascal_7_dupl_id2_ob() = 
  tryBind(bindL1, |project://oberon0/tests/rascal/negative/name_errors/L1/7_dupl-id2.ob|) == 7; 

public test bool NEG_bind_L1_rascal_4_undecl_var_ob() = 
  tryBind(bindL1, |project://oberon0/tests/rascal/negative/name_errors/L1/4_undecl-var.ob|) == 4; 

public test bool NEG_bind_L1_rascal_7_assign_const_ob() = 
  tryBind(bindL1, |project://oberon0/tests/rascal/negative/name_errors/L1/7_assign_const.ob|) == 7; 

public test bool NEG_bind_L1_kiama_7_const3_ob() = 
  tryBind(bindL1, |project://oberon0/tests/kiama/negative/name_errors/L1/7_const3.ob|) == 7; 

public test bool NEG_bind_L1_kiama_7_condname4_ob() = 
  tryBind(bindL1, |project://oberon0/tests/kiama/negative/name_errors/L1/7_condname4.ob|) == 7; 

public test bool NEG_bind_L1_kiama_7_type3_ob() = 
  tryBind(bindL1, |project://oberon0/tests/kiama/negative/name_errors/L1/7_type3.ob|) == 7; 

public test bool NEG_bind_L1_kiama_5_type2_ob() = 
  tryBind(bindL1, |project://oberon0/tests/kiama/negative/name_errors/L1/5_type2.ob|) == 5; 

public test bool NEG_bind_L1_kiama_4_condname1_ob() = 
  tryBind(bindL1, |project://oberon0/tests/kiama/negative/name_errors/L1/4_condname1.ob|) == 4; 

public test bool NEG_bind_L1_kiama_7_whilename3_ob() = 
  tryBind(bindL1, |project://oberon0/tests/kiama/negative/name_errors/L1/7_whilename3.ob|) == 7; 

public test bool NEG_bind_L1_kiama_7_type4_ob() = 
  tryBind(bindL1, |project://oberon0/tests/kiama/negative/name_errors/L1/7_type4.ob|) == 7; 

public test bool NEG_bind_L1_kiama_4_selfref1_ob() = 
  tryBind(bindL1, |project://oberon0/tests/kiama/negative/name_errors/L1/4_selfref1.ob|) == 4; 

public test bool NEG_bind_L1_kiama_8_condname2_ob() = 
  tryBind(bindL1, |project://oberon0/tests/kiama/negative/name_errors/L1/8_condname2.ob|) == 8; 

public test bool NEG_bind_L1_kiama_5_var1_ob() = 
  tryBind(bindL1, |project://oberon0/tests/kiama/negative/name_errors/L1/5_var1.ob|) == 5; 

public test bool NEG_bind_L1_kiama_2_wrongmodulename_ob() = 
  tryBind(bindL1, |project://oberon0/tests/kiama/negative/name_errors/L1/2_wrongmodulename.ob|) == 2; 

public test bool NEG_bind_L1_kiama_7_whilename2_ob() = 
  tryBind(bindL1, |project://oberon0/tests/kiama/negative/name_errors/L1/7_whilename2.ob|) == 7; 

public test bool NEG_bind_L1_kiama_4_var4_ob() = 
  tryBind(bindL1, |project://oberon0/tests/kiama/negative/name_errors/L1/4_var4.ob|) == 4; 

public test bool NEG_bind_L1_kiama_5_selfref2_ob() = 
  tryBind(bindL1, |project://oberon0/tests/kiama/negative/name_errors/L1/5_selfref2.ob|) == 5; 

public test bool NEG_bind_L1_kiama_6_nonmoduleasmodulename_ob() = 
  tryBind(bindL1, |project://oberon0/tests/kiama/negative/name_errors/L1/6_nonmoduleasmodulename.ob|) == 6; 

public test bool NEG_bind_L1_kiama_7_type1_ob() = 
  tryBind(bindL1, |project://oberon0/tests/kiama/negative/name_errors/L1/7_type1.ob|) == 7; 

public test bool NEG_bind_L1_kiama_5_var2_ob() = 
  tryBind(bindL1, |project://oberon0/tests/kiama/negative/name_errors/L1/5_var2.ob|) == 5; 

public test bool NEG_bind_L1_kiama_10_condname3_ob() = 
  tryBind(bindL1, |project://oberon0/tests/kiama/negative/name_errors/L1/10_condname3.ob|) == 10; 

public test bool NEG_bind_L1_kiama_4_selfref3_ob() = 
  tryBind(bindL1, |project://oberon0/tests/kiama/negative/name_errors/L1/4_selfref3.ob|) == 4; 

public test bool NEG_bind_L1_kiama_5_var3_ob() = 
  tryBind(bindL1, |project://oberon0/tests/kiama/negative/name_errors/L1/5_var3.ob|) == 5; 

public test bool NEG_bind_L1_kiama_4_whilename1_ob() = 
  tryBind(bindL1, |project://oberon0/tests/kiama/negative/name_errors/L1/4_whilename1.ob|) == 4; 

public test bool NEG_bind_L1_kiama_4_typenoddecl_ob() = 
  tryBind(bindL1, |project://oberon0/tests/kiama/negative/name_errors/L1/4_typenoddecl.ob|) == 4; 

public test bool NEG_bind_L2_rascal_7_undecl_in_for_ob() = 
  tryBind(bindL2, |project://oberon0/tests/rascal/negative/name_errors/L2/7_undecl-in-for.ob|) == 7; 

public test bool NEG_bind_L2_rascal_7_undecl_for1_ob() = 
  tryBind(bindL2, |project://oberon0/tests/rascal/negative/name_errors/L2/7_undecl-for1.ob|) == 7; 

public test bool NEG_bind_L2_rascal_7_undecl_in_case3_ob() = 
  tryBind(bindL2, |project://oberon0/tests/rascal/negative/name_errors/L2/7_undecl-in-case3.ob|) == 7; 

public test bool NEG_bind_L2_rascal_7_undecl_for4_ob() = 
  tryBind(bindL2, |project://oberon0/tests/rascal/negative/name_errors/L2/7_undecl-for4.ob|) == 7; 

public test bool NEG_bind_L2_rascal_7_undecl_for3_ob() = 
  tryBind(bindL2, |project://oberon0/tests/rascal/negative/name_errors/L2/7_undecl-for3.ob|) == 7; 

public test bool NEG_bind_L2_rascal_7_undecl_for2_ob() = 
  tryBind(bindL2, |project://oberon0/tests/rascal/negative/name_errors/L2/7_undecl-for2.ob|) == 7; 

public test bool NEG_bind_L2_rascal_7_undecl_in_case1_ob() = 
  tryBind(bindL2, |project://oberon0/tests/rascal/negative/name_errors/L2/7_undecl-in-case1.ob|) == 7; 

public test bool NEG_bind_L2_rascal_7_undecl_in_case2_ob() = 
  tryBind(bindL2, |project://oberon0/tests/rascal/negative/name_errors/L2/7_undecl-in-case2.ob|) == 7; 

public test bool NEG_bind_L2_kiama_4_forname1_ob() = 
  tryBind(bindL2, |project://oberon0/tests/kiama/negative/name_errors/L2/4_forname1.ob|) == 4; 

public test bool NEG_bind_L2_kiama_7_forname4_ob() = 
  tryBind(bindL2, |project://oberon0/tests/kiama/negative/name_errors/L2/7_forname4.ob|) == 7; 

public test bool NEG_bind_L2_kiama_11_casename3_ob() = 
  tryBind(bindL2, |project://oberon0/tests/kiama/negative/name_errors/L2/11_casename3.ob|) == 11; 

public test bool NEG_bind_L2_kiama_7_forname3_ob() = 
  tryBind(bindL2, |project://oberon0/tests/kiama/negative/name_errors/L2/7_forname3.ob|) == 7; 

public test bool NEG_bind_L2_kiama_9_casename2_ob() = 
  tryBind(bindL2, |project://oberon0/tests/kiama/negative/name_errors/L2/9_casename2.ob|) == 9; 

public test bool NEG_bind_L2_kiama_7_badfor5_ob() = 
  tryBind(bindL2, |project://oberon0/tests/kiama/negative/name_errors/L2/7_badfor5.ob|) == 7; 

public test bool NEG_bind_L2_kiama_8_forname2_ob() = 
  tryBind(bindL2, |project://oberon0/tests/kiama/negative/name_errors/L2/8_forname2.ob|) == 8; 

public test bool NEG_bind_L2_kiama_7_casename1_ob() = 
  tryBind(bindL2, |project://oberon0/tests/kiama/negative/name_errors/L2/7_casename1.ob|) == 7; 

public test bool NEG_bind_L3_simpl_5_ArgumentScope_ob() = 
  tryBind(bindL3, |project://oberon0/tests/simpl/negative/name_errors/L3/5_ArgumentScope.ob|) == 5; 

public test bool NEG_bind_L3_simpl_4_ProcedureOrder_ob() = 
  tryBind(bindL3, |project://oberon0/tests/simpl/negative/name_errors/L3/4_ProcedureOrder.ob|) == 4; 

public test bool NEG_bind_L3_jastadd_2_ProcedureName_ob() = 
  tryBind(bindL3, |project://oberon0/tests/jastadd/negative/name_errors/L3/2_ProcedureName.ob|) == 2; 

public test bool NEG_bind_L3_jastadd_4_DeclareBeforeUse_ob() = 
  tryBind(bindL3, |project://oberon0/tests/jastadd/negative/name_errors/L3/4_DeclareBeforeUse.ob|) == 4; 

public test bool NEG_bind_L3_jastadd_3_ProcScopeRules2_ob() = 
  tryBind(bindL3, |project://oberon0/tests/jastadd/negative/name_errors/L3/3_ProcScopeRules2.ob|) == 3; 

public test bool NEG_bind_L3_jastadd_9_ProcCall2_ob() = 
  tryBind(bindL3, |project://oberon0/tests/jastadd/negative/name_errors/L3/9_ProcCall2.ob|) == 9; 

public test bool NEG_bind_L3_jastadd_10_ProcCall_ob() = 
  tryBind(bindL3, |project://oberon0/tests/jastadd/negative/name_errors/L3/10_ProcCall.ob|) == 10; 

public test bool NEG_bind_L3_jastadd_11_VariableAccess_ob() = 
  tryBind(bindL3, |project://oberon0/tests/jastadd/negative/name_errors/L3/11_VariableAccess.ob|) == 11; 

public test bool NEG_bind_L3_jastadd_10_VariableAccess2_ob() = 
  tryBind(bindL3, |project://oberon0/tests/jastadd/negative/name_errors/L3/10_VariableAccess2.ob|) == 10; 

public test bool NEG_bind_L3_silver_8_non_local_var_proc_ob() = 
  tryBind(bindL3, |project://oberon0/tests/silver/negative/name_errors/L3/8_non_local_var_proc.ob|) == 8; 

public test bool NEG_bind_L3_silver_6_duplicate_procs_ob() = 
  tryBind(bindL3, |project://oberon0/tests/silver/negative/name_errors/L3/6_duplicate_procs.ob|) == 6; 

public test bool NEG_bind_L3_rascal_7_no_proc_ob() = 
  tryBind(bindL3, |project://oberon0/tests/rascal/negative/name_errors/L3/7_no-proc.ob|) == 7; 

public test bool NEG_bind_L3_rascal_7_dupl_proc_ob() = 
  tryBind(bindL3, |project://oberon0/tests/rascal/negative/name_errors/L3/7_dupl-proc.ob|) == 7; 

public test bool NEG_bind_L3_rascal_7_undef_proc_ob() = 
  tryBind(bindL3, |project://oberon0/tests/rascal/negative/name_errors/L3/7_undef-proc.ob|) == 7; 

public test bool NEG_bind_L3_rascal_7_no_proc3_ob() = 
  tryBind(bindL3, |project://oberon0/tests/rascal/negative/name_errors/L3/7_no-proc3.ob|) == 7; 

public test bool NEG_bind_L3_rascal_2_undef_type_form_ob() = 
  tryBind(bindL3, |project://oberon0/tests/rascal/negative/name_errors/L3/2_undef-type-form.ob|) == 2; 

public test bool NEG_bind_L3_rascal_7_no_proc2_ob() = 
  tryBind(bindL3, |project://oberon0/tests/rascal/negative/name_errors/L3/7_no-proc2.ob|) == 7; 

public test bool NEG_bind_L4_jastadd_2_RecordDecl2_ob() = 
  tryBind(bindL4, |project://oberon0/tests/jastadd/negative/name_errors/L4/2_RecordDecl2.ob|) == 2; 

public test bool NEG_bind_L4_jastadd_2_RecordDecl_ob() = 
  tryBind(bindL4, |project://oberon0/tests/jastadd/negative/name_errors/L4/2_RecordDecl.ob|) == 2; 

public test bool NEG_bind_L4_silver_10_wrong_property_record_ob() = 
  tryBind(bindL4, |project://oberon0/tests/silver/negative/name_errors/L4/10_wrong_property_record.ob|) == 10; 

public test bool NEG_bind_L4_silver_4_duplicate_arrays_ob() = 
  tryBind(bindL4, |project://oberon0/tests/silver/negative/name_errors/L4/4_duplicate_arrays.ob|) == 4; 

public test bool NEG_bind_L4_silver_8_duplicate_records_ob() = 
  tryBind(bindL4, |project://oberon0/tests/silver/negative/name_errors/L4/8_duplicate_records.ob|) == 8; 

public test bool NEG_bind_L4_kiama_4_arrayname1_ob() = 
  tryBind(bindL4, |project://oberon0/tests/kiama/negative/name_errors/L4/4_arrayname1.ob|) == 4; 

public test bool NEG_bind_L4_kiama_4_recordname2_ob() = 
  tryBind(bindL4, |project://oberon0/tests/kiama/negative/name_errors/L4/4_recordname2.ob|) == 4; 

public test bool NEG_bind_L4_kiama_4_arrayname2_ob() = 
  tryBind(bindL4, |project://oberon0/tests/kiama/negative/name_errors/L4/4_arrayname2.ob|) == 4; 

public test bool NEG_bind_L4_kiama_4_recordname1_ob() = 
  tryBind(bindL4, |project://oberon0/tests/kiama/negative/name_errors/L4/4_recordname1.ob|) == 4; 

public test bool POS_parse_L1_silver_identifiers_pass_ob() = 
  tryParse(parseL1, |project://oberon0/tests/silver/positive/L1/identifiers_pass.ob|) == -1; 

public test bool POS_parse_L1_silver_duplicate_parens_ob() = 
  tryParse(parseL1, |project://oberon0/tests/silver/positive/L1/duplicate_parens.ob|) == -1; 

public test bool POS_parse_L1_silver_gcd_ob() = 
  tryParse(parseL1, |project://oberon0/tests/silver/positive/L1/gcd.ob|) == -1; 

public test bool POS_parse_L1_silver_if_else_ob() = 
  tryParse(parseL1, |project://oberon0/tests/silver/positive/L1/if_else.ob|) == -1; 

public test bool POS_parse_L1_silver_module_no_body_ob() = 
  tryParse(parseL1, |project://oberon0/tests/silver/positive/L1/module_no_body.ob|) == -1; 

public test bool POS_parse_L1_silver_comments_ob() = 
  tryParse(parseL1, |project://oberon0/tests/silver/positive/L1/comments.ob|) == -1; 

public test bool POS_parse_L1_silver_while_ob() = 
  tryParse(parseL1, |project://oberon0/tests/silver/positive/L1/while.ob|) == -1; 

public test bool POS_parse_L1_silver_if_elsif_ob() = 
  tryParse(parseL1, |project://oberon0/tests/silver/positive/L1/if_elsif.ob|) == -1; 

public test bool POS_parse_L1_silver_if_statement_ob() = 
  tryParse(parseL1, |project://oberon0/tests/silver/positive/L1/if_statement.ob|) == -1; 

public test bool POS_parse_L1_rascal_big_ob() = 
  tryParse(parseL1, |project://oberon0/tests/rascal/positive/L1/big.ob|) == -1; 

public test bool POS_parse_L1_rascal_big2_ob() = 
  tryParse(parseL1, |project://oberon0/tests/rascal/positive/L1/big2.ob|) == -1; 

public test bool POS_parse_L1_kiama_emptybody_ob() = 
  tryParse(parseL1, |project://oberon0/tests/kiama/positive/L1/emptybody.ob|) == -1; 

public test bool POS_parse_L1_kiama_type_ob() = 
  tryParse(parseL1, |project://oberon0/tests/kiama/positive/L1/type.ob|) == -1; 

public test bool POS_parse_L1_kiama_emptymodule_ob() = 
  tryParse(parseL1, |project://oberon0/tests/kiama/positive/L1/emptymodule.ob|) == -1; 

public test bool POS_parse_L1_kiama_assign_ob() = 
  tryParse(parseL1, |project://oberon0/tests/kiama/positive/L1/assign.ob|) == -1; 

public test bool POS_parse_L1_kiama_redefinteger_ob() = 
  tryParse(parseL1, |project://oberon0/tests/kiama/positive/L1/redefinteger.ob|) == -1; 

public test bool POS_parse_L1_kiama_redeftrue_ob() = 
  tryParse(parseL1, |project://oberon0/tests/kiama/positive/L1/redeftrue.ob|) == -1; 

public test bool POS_parse_L1_kiama_while_ob() = 
  tryParse(parseL1, |project://oberon0/tests/kiama/positive/L1/while.ob|) == -1; 

public test bool POS_parse_L1_kiama_const_ob() = 
  tryParse(parseL1, |project://oberon0/tests/kiama/positive/L1/const.ob|) == -1; 

public test bool POS_parse_L1_kiama_simpleexps_ob() = 
  tryParse(parseL1, |project://oberon0/tests/kiama/positive/L1/simpleexps.ob|) == -1; 

public test bool POS_parse_L1_kiama_comment_ob() = 
  tryParse(parseL1, |project://oberon0/tests/kiama/positive/L1/comment.ob|) == -1; 

public test bool POS_parse_L1_kiama_emptydeclsections_ob() = 
  tryParse(parseL1, |project://oberon0/tests/kiama/positive/L1/emptydeclsections.ob|) == -1; 

public test bool POS_parse_L1_kiama_cond_ob() = 
  tryParse(parseL1, |project://oberon0/tests/kiama/positive/L1/cond.ob|) == -1; 

public test bool POS_parse_L2_silver_for_loop_ob() = 
  tryParse(parseL2, |project://oberon0/tests/silver/positive/L2/for_loop.ob|) == -1; 

public test bool POS_parse_L2_silver_case_ob() = 
  tryParse(parseL2, |project://oberon0/tests/silver/positive/L2/case.ob|) == -1; 

public test bool POS_parse_L2_kiama_for_ob() = 
  tryParse(parseL2, |project://oberon0/tests/kiama/positive/L2/for.ob|) == -1; 

public test bool POS_parse_L2_kiama_case_ob() = 
  tryParse(parseL2, |project://oberon0/tests/kiama/positive/L2/case.ob|) == -1; 

public test bool POS_parse_L3_simpl_ProcedureRedefinition_ob() = 
  tryParse(parseL3, |project://oberon0/tests/simpl/positive/L3/ProcedureRedefinition.ob|) == -1; 

public test bool POS_parse_L3_simpl_ProcedureScope_ob() = 
  tryParse(parseL3, |project://oberon0/tests/simpl/positive/L3/ProcedureScope.ob|) == -1; 

public test bool POS_parse_L3_jastadd_MinusMinus_ob() = 
  tryParse(parseL3, |project://oberon0/tests/jastadd/positive/L3/MinusMinus.ob|) == -1; 

public test bool POS_parse_L3_jastadd_VariableShadowing_ob() = 
  tryParse(parseL3, |project://oberon0/tests/jastadd/positive/L3/VariableShadowing.ob|) == -1; 

public test bool POS_parse_L3_silver_type_diff_scope_ob() = 
  tryParse(parseL3, |project://oberon0/tests/silver/positive/L3/type_diff_scope.ob|) == -1; 

public test bool POS_parse_L3_silver_Lift1_ob() = 
  tryParse(parseL3, |project://oberon0/tests/silver/positive/L3/Lift1.ob|) == -1; 

public test bool POS_parse_L3_silver_non_var_in_proc_ob() = 
  tryParse(parseL3, |project://oberon0/tests/silver/positive/L3/non_var_in_proc.ob|) == -1; 

public test bool POS_parse_L3_silver_global_var_proc_ob() = 
  tryParse(parseL3, |project://oberon0/tests/silver/positive/L3/global_var_proc.ob|) == -1; 

public test bool POS_parse_L3_silver_type_diff_scope_2_ob() = 
  tryParse(parseL3, |project://oberon0/tests/silver/positive/L3/type_diff_scope_2.ob|) == -1; 

public test bool POS_parse_L3_silver_const_diff_scope_ob() = 
  tryParse(parseL3, |project://oberon0/tests/silver/positive/L3/const_diff_scope.ob|) == -1; 

public test bool POS_parse_L3_silver_GlobalProcs_ob() = 
  tryParse(parseL3, |project://oberon0/tests/silver/positive/L3/GlobalProcs.ob|) == -1; 

public test bool POS_parse_L3_silver_L1L2_write_ob() = 
  tryParse(parseL3, |project://oberon0/tests/silver/positive/L3/L1L2_write.ob|) == -1; 

public test bool POS_parse_L3_silver_gcd_recursive_ob() = 
  tryParse(parseL3, |project://oberon0/tests/silver/positive/L3/gcd_recursive.ob|) == -1; 

public test bool POS_parse_L3_silver_const_diff_scope_2_ob() = 
  tryParse(parseL3, |project://oberon0/tests/silver/positive/L3/const_diff_scope_2.ob|) == -1; 

public test bool POS_parse_L3_rascal_factorial_ob() = 
  tryParse(parseL3, |project://oberon0/tests/rascal/positive/L3/factorial.ob|) == -1; 

public test bool POS_parse_L4_jastadd_NestedTypeUse_ob() = 
  tryParse(parseL4, |project://oberon0/tests/jastadd/positive/L4/NestedTypeUse.ob|) == -1; 

public test bool POS_parse_L4_jastadd_NestedTypeUse2_ob() = 
  tryParse(parseL4, |project://oberon0/tests/jastadd/positive/L4/NestedTypeUse2.ob|) == -1; 

public test bool POS_parse_L4_jastadd_RecordDecl_ob() = 
  tryParse(parseL4, |project://oberon0/tests/jastadd/positive/L4/RecordDecl.ob|) == -1; 

public test bool POS_parse_L4_ocaml_For_ob() = 
  tryParse(parseL4, |project://oberon0/tests/ocaml/positive/L4/For.ob|) == -1; 

public test bool POS_parse_L4_ocaml_Overriding1_ob() = 
  tryParse(parseL4, |project://oberon0/tests/ocaml/positive/L4/Overriding1.ob|) == -1; 

public test bool POS_parse_L4_ocaml_TypeLift_ob() = 
  tryParse(parseL4, |project://oberon0/tests/ocaml/positive/L4/TypeLift.ob|) == -1; 

public test bool POS_parse_L4_ocaml_Exp_ob() = 
  tryParse(parseL4, |project://oberon0/tests/ocaml/positive/L4/Exp.ob|) == -1; 

public test bool POS_parse_L4_ocaml_Reserved_ob() = 
  tryParse(parseL4, |project://oberon0/tests/ocaml/positive/L4/Reserved.ob|) == -1; 

public test bool POS_parse_L4_ocaml_Log_ob() = 
  tryParse(parseL4, |project://oberon0/tests/ocaml/positive/L4/Log.ob|) == -1; 

public test bool POS_parse_L4_ocaml_Overriding2_ob() = 
  tryParse(parseL4, |project://oberon0/tests/ocaml/positive/L4/Overriding2.ob|) == -1; 

public test bool POS_parse_L4_silver_array_var_ob() = 
  tryParse(parseL4, |project://oberon0/tests/silver/positive/L4/array_var.ob|) == -1; 

public test bool POS_parse_L4_silver_record_ob() = 
  tryParse(parseL4, |project://oberon0/tests/silver/positive/L4/record.ob|) == -1; 

public test bool POS_parse_L4_silver_typed_array_in_proc_ob() = 
  tryParse(parseL4, |project://oberon0/tests/silver/positive/L4/typed_array_in_proc.ob|) == -1; 

public test bool POS_parse_L4_silver_array_type_ob() = 
  tryParse(parseL4, |project://oberon0/tests/silver/positive/L4/array_type.ob|) == -1; 

public test bool POS_parse_L4_silver_Sample_ob() = 
  tryParse(parseL4, |project://oberon0/tests/silver/positive/L4/Sample.ob|) == -1; 

public test bool POS_parse_L4_silver_const_len_array_ob() = 
  tryParse(parseL4, |project://oberon0/tests/silver/positive/L4/const_len_array.ob|) == -1; 

public test bool POS_parse_L4_rascal_quicksort_ob() = 
  tryParse(parseL4, |project://oberon0/tests/rascal/positive/L4/quicksort.ob|) == -1; 

public test bool POS_parse_L4_kiama_array_ob() = 
  tryParse(parseL4, |project://oberon0/tests/kiama/positive/L4/array.ob|) == -1; 

public test bool POS_parse_L4_kiama_record_ob() = 
  tryParse(parseL4, |project://oberon0/tests/kiama/positive/L4/record.ob|) == -1; 

//public test bool POS_parse_L5_ocaml_Factorize_ob() = 
//  tryParse(parseL5, |project://oberon0/tests/ocaml/positive/L5/Factorize.ob|) == -1; 
//
//public test bool POS_parse_L5_ocaml_Corec_ob() = 
//  tryParse(parseL5, |project://oberon0/tests/ocaml/positive/L5/Corec.ob|) == -1; 
//
//public test bool POS_parse_L5_rascal_collatz_ob() = 
//  tryParse(parseL5, |project://oberon0/tests/rascal/positive/L5/collatz.ob|) == -1; 

public test bool POS_check_L1_silver_identifiers_pass_ob() = 
  tryCheck(checkL1, |project://oberon0/tests/silver/positive/L1/identifiers_pass.ob|) == -1; 

public test bool POS_check_L1_silver_duplicate_parens_ob() = 
  tryCheck(checkL1, |project://oberon0/tests/silver/positive/L1/duplicate_parens.ob|) == -1; 

public test bool POS_check_L1_silver_gcd_ob() = 
  tryCheck(checkL1, |project://oberon0/tests/silver/positive/L1/gcd.ob|) == -1; 

public test bool POS_check_L1_silver_if_else_ob() = 
  tryCheck(checkL1, |project://oberon0/tests/silver/positive/L1/if_else.ob|) == -1; 

public test bool POS_check_L1_silver_module_no_body_ob() = 
  tryCheck(checkL1, |project://oberon0/tests/silver/positive/L1/module_no_body.ob|) == -1; 

public test bool POS_check_L1_silver_comments_ob() = 
  tryCheck(checkL1, |project://oberon0/tests/silver/positive/L1/comments.ob|) == -1; 

public test bool POS_check_L1_silver_while_ob() = 
  tryCheck(checkL1, |project://oberon0/tests/silver/positive/L1/while.ob|) == -1; 

public test bool POS_check_L1_silver_if_elsif_ob() = 
  tryCheck(checkL1, |project://oberon0/tests/silver/positive/L1/if_elsif.ob|) == -1; 

public test bool POS_check_L1_silver_if_statement_ob() = 
  tryCheck(checkL1, |project://oberon0/tests/silver/positive/L1/if_statement.ob|) == -1; 

public test bool POS_check_L1_rascal_big_ob() = 
  tryCheck(checkL1, |project://oberon0/tests/rascal/positive/L1/big.ob|) == -1; 

public test bool POS_check_L1_rascal_big2_ob() = 
  tryCheck(checkL1, |project://oberon0/tests/rascal/positive/L1/big2.ob|) == -1; 

public test bool POS_check_L1_kiama_emptybody_ob() = 
  tryCheck(checkL1, |project://oberon0/tests/kiama/positive/L1/emptybody.ob|) == -1; 

public test bool POS_check_L1_kiama_type_ob() = 
  tryCheck(checkL1, |project://oberon0/tests/kiama/positive/L1/type.ob|) == -1; 

public test bool POS_check_L1_kiama_emptymodule_ob() = 
  tryCheck(checkL1, |project://oberon0/tests/kiama/positive/L1/emptymodule.ob|) == -1; 

public test bool POS_check_L1_kiama_assign_ob() = 
  tryCheck(checkL1, |project://oberon0/tests/kiama/positive/L1/assign.ob|) == -1; 

public test bool POS_check_L1_kiama_redefinteger_ob() = 
  tryCheck(checkL1, |project://oberon0/tests/kiama/positive/L1/redefinteger.ob|) == -1; 

public test bool POS_check_L1_kiama_redeftrue_ob() = 
  tryCheck(checkL1, |project://oberon0/tests/kiama/positive/L1/redeftrue.ob|) == -1; 

public test bool POS_check_L1_kiama_while_ob() = 
  tryCheck(checkL1, |project://oberon0/tests/kiama/positive/L1/while.ob|) == -1; 

public test bool POS_check_L1_kiama_const_ob() = 
  tryCheck(checkL1, |project://oberon0/tests/kiama/positive/L1/const.ob|) == -1; 

public test bool POS_check_L1_kiama_simpleexps_ob() = 
  tryCheck(checkL1, |project://oberon0/tests/kiama/positive/L1/simpleexps.ob|) == -1; 

public test bool POS_check_L1_kiama_comment_ob() = 
  tryCheck(checkL1, |project://oberon0/tests/kiama/positive/L1/comment.ob|) == -1; 

public test bool POS_check_L1_kiama_emptydeclsections_ob() = 
  tryCheck(checkL1, |project://oberon0/tests/kiama/positive/L1/emptydeclsections.ob|) == -1; 

public test bool POS_check_L1_kiama_cond_ob() = 
  tryCheck(checkL1, |project://oberon0/tests/kiama/positive/L1/cond.ob|) == -1; 

public test bool POS_check_L2_silver_for_loop_ob() = 
  tryCheck(checkL2, |project://oberon0/tests/silver/positive/L2/for_loop.ob|) == -1; 

public test bool POS_check_L2_silver_case_ob() = 
  tryCheck(checkL2, |project://oberon0/tests/silver/positive/L2/case.ob|) == -1; 

public test bool POS_check_L2_kiama_for_ob() = 
  tryCheck(checkL2, |project://oberon0/tests/kiama/positive/L2/for.ob|) == -1; 

public test bool POS_check_L2_kiama_case_ob() = 
  tryCheck(checkL2, |project://oberon0/tests/kiama/positive/L2/case.ob|) == -1; 

public test bool POS_check_L3_simpl_ProcedureRedefinition_ob() = 
  tryCheck(checkL3, |project://oberon0/tests/simpl/positive/L3/ProcedureRedefinition.ob|) == -1; 

public test bool POS_check_L3_simpl_ProcedureScope_ob() = 
  tryCheck(checkL3, |project://oberon0/tests/simpl/positive/L3/ProcedureScope.ob|) == -1; 

public test bool POS_check_L3_jastadd_MinusMinus_ob() = 
  tryCheck(checkL3, |project://oberon0/tests/jastadd/positive/L3/MinusMinus.ob|) == -1; 

public test bool POS_check_L3_jastadd_VariableShadowing_ob() = 
  tryCheck(checkL3, |project://oberon0/tests/jastadd/positive/L3/VariableShadowing.ob|) == -1; 

public test bool POS_check_L3_silver_type_diff_scope_ob() = 
  tryCheck(checkL3, |project://oberon0/tests/silver/positive/L3/type_diff_scope.ob|) == -1; 

public test bool POS_check_L3_silver_Lift1_ob() = 
  tryCheck(checkL3, |project://oberon0/tests/silver/positive/L3/Lift1.ob|) == -1; 

public test bool POS_check_L3_silver_non_var_in_proc_ob() = 
  tryCheck(checkL3, |project://oberon0/tests/silver/positive/L3/non_var_in_proc.ob|) == -1; 

public test bool POS_check_L3_silver_global_var_proc_ob() = 
  tryCheck(checkL3, |project://oberon0/tests/silver/positive/L3/global_var_proc.ob|) == -1; 

public test bool POS_check_L3_silver_type_diff_scope_2_ob() = 
  tryCheck(checkL3, |project://oberon0/tests/silver/positive/L3/type_diff_scope_2.ob|) == -1; 

public test bool POS_check_L3_silver_const_diff_scope_ob() = 
  tryCheck(checkL3, |project://oberon0/tests/silver/positive/L3/const_diff_scope.ob|) == -1; 

public test bool POS_check_L3_silver_GlobalProcs_ob() = 
  tryCheck(checkL3, |project://oberon0/tests/silver/positive/L3/GlobalProcs.ob|) == -1; 

public test bool POS_check_L3_silver_L1L2_write_ob() = 
  tryCheck(checkL3, |project://oberon0/tests/silver/positive/L3/L1L2_write.ob|) == -1; 

public test bool POS_check_L3_silver_gcd_recursive_ob() = 
  tryCheck(checkL3, |project://oberon0/tests/silver/positive/L3/gcd_recursive.ob|) == -1; 

public test bool POS_check_L3_silver_const_diff_scope_2_ob() = 
  tryCheck(checkL3, |project://oberon0/tests/silver/positive/L3/const_diff_scope_2.ob|) == -1; 

public test bool POS_check_L3_rascal_factorial_ob() = 
  tryCheck(checkL3, |project://oberon0/tests/rascal/positive/L3/factorial.ob|) == -1; 

public test bool POS_check_L4_jastadd_NestedTypeUse_ob() = 
  tryCheck(checkL4, |project://oberon0/tests/jastadd/positive/L4/NestedTypeUse.ob|) == -1; 

public test bool POS_check_L4_jastadd_NestedTypeUse2_ob() = 
  tryCheck(checkL4, |project://oberon0/tests/jastadd/positive/L4/NestedTypeUse2.ob|) == -1; 

public test bool POS_check_L4_jastadd_RecordDecl_ob() = 
  tryCheck(checkL4, |project://oberon0/tests/jastadd/positive/L4/RecordDecl.ob|) == -1; 

public test bool POS_check_L4_ocaml_For_ob() = 
  tryCheck(checkL4, |project://oberon0/tests/ocaml/positive/L4/For.ob|) == -1;
  

public test bool POS_check_L4_ocaml_Overriding1_ob() = 
  tryCheck(checkL4, |project://oberon0/tests/ocaml/positive/L4/Overriding1.ob|) == -1; 

public test bool POS_check_L4_ocaml_TypeLift_ob() = 
  tryCheck(checkL4, |project://oberon0/tests/ocaml/positive/L4/TypeLift.ob|) == -1; 

public test bool POS_check_L4_ocaml_Exp_ob() = 
  tryCheck(checkL4, |project://oberon0/tests/ocaml/positive/L4/Exp.ob|) == -1; 

public test bool POS_check_L4_ocaml_Reserved_ob() = 
  tryCheck(checkL4, |project://oberon0/tests/ocaml/positive/L4/Reserved.ob|) == -1; 

public test bool POS_check_L4_ocaml_Log_ob() = 
  tryCheck(checkL4, |project://oberon0/tests/ocaml/positive/L4/Log.ob|) == -1; 

public test bool POS_check_L4_ocaml_Overriding2_ob() = 
  tryCheck(checkL4, |project://oberon0/tests/ocaml/positive/L4/Overriding2.ob|) == -1; 

public test bool POS_check_L4_silver_array_var_ob() = 
  tryCheck(checkL4, |project://oberon0/tests/silver/positive/L4/array_var.ob|) == -1; 

public test bool POS_check_L4_silver_record_ob() = 
  tryCheck(checkL4, |project://oberon0/tests/silver/positive/L4/record.ob|) == -1; 

public test bool POS_check_L4_silver_typed_array_in_proc_ob() = 
  tryCheck(checkL4, |project://oberon0/tests/silver/positive/L4/typed_array_in_proc.ob|) == -1; 

public test bool POS_check_L4_silver_array_type_ob() = 
  tryCheck(checkL4, |project://oberon0/tests/silver/positive/L4/array_type.ob|) == -1; 

public test bool POS_check_L4_silver_Sample_ob() = 
  tryCheck(checkL4, |project://oberon0/tests/silver/positive/L4/Sample.ob|) == -1; 

public test bool POS_check_L4_silver_const_len_array_ob() = 
  tryCheck(checkL4, |project://oberon0/tests/silver/positive/L4/const_len_array.ob|) == -1; 

public test bool POS_check_L4_rascal_quicksort_ob() = 
  tryCheck(checkL4, |project://oberon0/tests/rascal/positive/L4/quicksort.ob|) == -1; 

public test bool POS_check_L4_kiama_array_ob() = 
  tryCheck(checkL4, |project://oberon0/tests/kiama/positive/L4/array.ob|) == -1; 

public test bool POS_check_L4_kiama_record_ob() = 
  tryCheck(checkL4, |project://oberon0/tests/kiama/positive/L4/record.ob|) == -1; 

//public test bool POS_check_L5_ocaml_Factorize_ob() = generating
//  tryCheck(checkL5, |project://oberon0/tests/ocaml/positive/L5/Factorize.ob|) == -1; 
//
//public test bool POS_check_L5_ocaml_Corec_ob() = 
//  tryCheck(checkL5, |project://oberon0/tests/ocaml/positive/L5/Corec.ob|) == -1; 
//
//public test bool POS_check_L5_rascal_collatz_ob() = 
//  tryCheck(checkL5, |project://oberon0/tests/rascal/positive/L5/collatz.ob|) == -1; 

public test bool POS_bind_L1_silver_identifiers_pass_ob() = 
  tryBind(bindL1, |project://oberon0/tests/silver/positive/L1/identifiers_pass.ob|) == -1; 

public test bool POS_bind_L1_silver_duplicate_parens_ob() = 
  tryBind(bindL1, |project://oberon0/tests/silver/positive/L1/duplicate_parens.ob|) == -1; 

public test bool POS_bind_L1_silver_gcd_ob() = 
  tryBind(bindL1, |project://oberon0/tests/silver/positive/L1/gcd.ob|) == -1; 

public test bool POS_bind_L1_silver_if_else_ob() = 
  tryBind(bindL1, |project://oberon0/tests/silver/positive/L1/if_else.ob|) == -1; 

public test bool POS_bind_L1_silver_module_no_body_ob() = 
  tryBind(bindL1, |project://oberon0/tests/silver/positive/L1/module_no_body.ob|) == -1; 

public test bool POS_bind_L1_silver_comments_ob() = 
  tryBind(bindL1, |project://oberon0/tests/silver/positive/L1/comments.ob|) == -1; 

public test bool POS_bind_L1_silver_while_ob() = 
  tryBind(bindL1, |project://oberon0/tests/silver/positive/L1/while.ob|) == -1; 

public test bool POS_bind_L1_silver_if_elsif_ob() = 
  tryBind(bindL1, |project://oberon0/tests/silver/positive/L1/if_elsif.ob|) == -1; 

public test bool POS_bind_L1_silver_if_statement_ob() = 
  tryBind(bindL1, |project://oberon0/tests/silver/positive/L1/if_statement.ob|) == -1; 

public test bool POS_bind_L1_rascal_big_ob() = 
  tryBind(bindL1, |project://oberon0/tests/rascal/positive/L1/big.ob|) == -1; 

public test bool POS_bind_L1_rascal_big2_ob() = 
  tryBind(bindL1, |project://oberon0/tests/rascal/positive/L1/big2.ob|) == -1; 

public test bool POS_bind_L1_kiama_emptybody_ob() = 
  tryBind(bindL1, |project://oberon0/tests/kiama/positive/L1/emptybody.ob|) == -1; 

public test bool POS_bind_L1_kiama_type_ob() = 
  tryBind(bindL1, |project://oberon0/tests/kiama/positive/L1/type.ob|) == -1; 
  

public test bool POS_bind_L1_kiama_emptymodule_ob() = 
  tryBind(bindL1, |project://oberon0/tests/kiama/positive/L1/emptymodule.ob|) == -1; 

public test bool POS_bind_L1_kiama_assign_ob() = 
  tryBind(bindL1, |project://oberon0/tests/kiama/positive/L1/assign.ob|) == -1; 

public test bool POS_bind_L1_kiama_redefinteger_ob() = 
  tryBind(bindL1, |project://oberon0/tests/kiama/positive/L1/redefinteger.ob|) == -1; 

public test bool POS_bind_L1_kiama_redeftrue_ob() = 
  tryBind(bindL1, |project://oberon0/tests/kiama/positive/L1/redeftrue.ob|) == -1; 

public test bool POS_bind_L1_kiama_while_ob() = 
  tryBind(bindL1, |project://oberon0/tests/kiama/positive/L1/while.ob|) == -1; 

public test bool POS_bind_L1_kiama_const_ob() = 
  tryBind(bindL1, |project://oberon0/tests/kiama/positive/L1/const.ob|) == -1; 

public test bool POS_bind_L1_kiama_simpleexps_ob() = 
  tryBind(bindL1, |project://oberon0/tests/kiama/positive/L1/simpleexps.ob|) == -1; 

public test bool POS_bind_L1_kiama_comment_ob() = 
  tryBind(bindL1, |project://oberon0/tests/kiama/positive/L1/comment.ob|) == -1; 

public test bool POS_bind_L1_kiama_emptydeclsections_ob() = 
  tryBind(bindL1, |project://oberon0/tests/kiama/positive/L1/emptydeclsections.ob|) == -1; 

public test bool POS_bind_L1_kiama_cond_ob() = 
  tryBind(bindL1, |project://oberon0/tests/kiama/positive/L1/cond.ob|) == -1; 

public test bool POS_bind_L2_silver_for_loop_ob() = 
  tryBind(bindL2, |project://oberon0/tests/silver/positive/L2/for_loop.ob|) == -1; 

public test bool POS_bind_L2_silver_case_ob() = 
  tryBind(bindL2, |project://oberon0/tests/silver/positive/L2/case.ob|) == -1; 

public test bool POS_bind_L2_kiama_for_ob() = 
  tryBind(bindL2, |project://oberon0/tests/kiama/positive/L2/for.ob|) == -1; 

public test bool POS_bind_L2_kiama_case_ob() = 
  tryBind(bindL2, |project://oberon0/tests/kiama/positive/L2/case.ob|) == -1; 

public test bool POS_bind_L3_simpl_ProcedureRedefinition_ob() = 
  tryBind(bindL3, |project://oberon0/tests/simpl/positive/L3/ProcedureRedefinition.ob|) == -1; 

public test bool POS_bind_L3_simpl_ProcedureScope_ob() = 
  tryBind(bindL3, |project://oberon0/tests/simpl/positive/L3/ProcedureScope.ob|) == -1; 

public test bool POS_bind_L3_jastadd_MinusMinus_ob() = 
  tryBind(bindL3, |project://oberon0/tests/jastadd/positive/L3/MinusMinus.ob|) == -1; 

public test bool POS_bind_L3_jastadd_VariableShadowing_ob() = 
  tryBind(bindL3, |project://oberon0/tests/jastadd/positive/L3/VariableShadowing.ob|) == -1; 

public test bool POS_bind_L3_silver_type_diff_scope_ob() = 
  tryBind(bindL3, |project://oberon0/tests/silver/positive/L3/type_diff_scope.ob|) == -1; 

public test bool POS_bind_L3_silver_Lift1_ob() = 
  tryBind(bindL3, |project://oberon0/tests/silver/positive/L3/Lift1.ob|) == -1; 

public test bool POS_bind_L3_silver_non_var_in_proc_ob() = 
  tryBind(bindL3, |project://oberon0/tests/silver/positive/L3/non_var_in_proc.ob|) == -1; 

public test bool POS_bind_L3_silver_global_var_proc_ob() = 
  tryBind(bindL3, |project://oberon0/tests/silver/positive/L3/global_var_proc.ob|) == -1; 

public test bool POS_bind_L3_silver_type_diff_scope_2_ob() = 
  tryBind(bindL3, |project://oberon0/tests/silver/positive/L3/type_diff_scope_2.ob|) == -1; 

public test bool POS_bind_L3_silver_const_diff_scope_ob() = 
  tryBind(bindL3, |project://oberon0/tests/silver/positive/L3/const_diff_scope.ob|) == -1; 

public test bool POS_bind_L3_silver_GlobalProcs_ob() = 
  tryBind(bindL3, |project://oberon0/tests/silver/positive/L3/GlobalProcs.ob|) == -1; 

public test bool POS_bind_L3_silver_L1L2_write_ob() = 
  tryBind(bindL3, |project://oberon0/tests/silver/positive/L3/L1L2_write.ob|) == -1; 

public test bool POS_bind_L3_silver_gcd_recursive_ob() = 
  tryBind(bindL3, |project://oberon0/tests/silver/positive/L3/gcd_recursive.ob|) == -1; 

public test bool POS_bind_L3_silver_const_diff_scope_2_ob() = 
  tryBind(bindL3, |project://oberon0/tests/silver/positive/L3/const_diff_scope_2.ob|) == -1; 

public test bool POS_bind_L3_rascal_factorial_ob() = 
  tryBind(bindL3, |project://oberon0/tests/rascal/positive/L3/factorial.ob|) == -1; 

public test bool POS_bind_L4_jastadd_NestedTypeUse_ob() = 
  tryBind(bindL4, |project://oberon0/tests/jastadd/positive/L4/NestedTypeUse.ob|) == -1; 

public test bool POS_bind_L4_jastadd_NestedTypeUse2_ob() = 
  tryBind(bindL4, |project://oberon0/tests/jastadd/positive/L4/NestedTypeUse2.ob|) == -1; 

public test bool POS_bind_L4_jastadd_RecordDecl_ob() = 
  tryBind(bindL4, |project://oberon0/tests/jastadd/positive/L4/RecordDecl.ob|) == -1; 

public test bool POS_bind_L4_ocaml_For_ob() = 
  tryBind(bindL4, |project://oberon0/tests/ocaml/positive/L4/For.ob|) == -1; 

public test bool POS_bind_L4_ocaml_Overriding1_ob() = 
  tryBind(bindL4, |project://oberon0/tests/ocaml/positive/L4/Overriding1.ob|) == -1; 

public test bool POS_bind_L4_ocaml_TypeLift_ob() = 
  tryBind(bindL4, |project://oberon0/tests/ocaml/positive/L4/TypeLift.ob|) == -1; 

public test bool POS_bind_L4_ocaml_Exp_ob() = 
  tryBind(bindL4, |project://oberon0/tests/ocaml/positive/L4/Exp.ob|) == -1; 

public test bool POS_bind_L4_ocaml_Reserved_ob() = 
  tryBind(bindL4, |project://oberon0/tests/ocaml/positive/L4/Reserved.ob|) == -1; 

public test bool POS_bind_L4_ocaml_Log_ob() = 
  tryBind(bindL4, |project://oberon0/tests/ocaml/positive/L4/Log.ob|) == -1; 

public test bool POS_bind_L4_ocaml_Overriding2_ob() = 
  tryBind(bindL4, |project://oberon0/tests/ocaml/positive/L4/Overriding2.ob|) == -1; 

public test bool POS_bind_L4_silver_array_var_ob() = 
  tryBind(bindL4, |project://oberon0/tests/silver/positive/L4/array_var.ob|) == -1; 

public test bool POS_bind_L4_silver_record_ob() = 
  tryBind(bindL4, |project://oberon0/tests/silver/positive/L4/record.ob|) == -1; 

public test bool POS_bind_L4_silver_typed_array_in_proc_ob() = 
  tryBind(bindL4, |project://oberon0/tests/silver/positive/L4/typed_array_in_proc.ob|) == -1; 

public test bool POS_bind_L4_silver_array_type_ob() = 
  tryBind(bindL4, |project://oberon0/tests/silver/positive/L4/array_type.ob|) == -1; 

public test bool POS_bind_L4_silver_Sample_ob() = 
  tryBind(bindL4, |project://oberon0/tests/silver/positive/L4/Sample.ob|) == -1; 

public test bool POS_bind_L4_silver_const_len_array_ob() = 
  tryBind(bindL4, |project://oberon0/tests/silver/positive/L4/const_len_array.ob|) == -1; 

public test bool POS_bind_L4_rascal_quicksort_ob() = 
  tryBind(bindL4, |project://oberon0/tests/rascal/positive/L4/quicksort.ob|) == -1; 

public test bool POS_bind_L4_kiama_array_ob() = 
  tryBind(bindL4, |project://oberon0/tests/kiama/positive/L4/array.ob|) == -1; 

public test bool POS_bind_L4_kiama_record_ob() = 
  tryBind(bindL4, |project://oberon0/tests/kiama/positive/L4/record.ob|) == -1; 

//public test bool POS_bind_L5_ocaml_Factorize_ob() = 
//  tryBind(bindL5, |project://oberon0/tests/ocaml/positive/L5/Factorize.ob|) == -1; 
//
//public test bool POS_bind_L5_ocaml_Corec_ob() = 
//  tryBind(bindL5, |project://oberon0/tests/ocaml/positive/L5/Corec.ob|) == -1; 
//
//public test bool POS_bind_L5_rascal_collatz_ob() = 
//  tryBind(bindL5, |project://oberon0/tests/rascal/positive/L5/collatz.ob|) == -1; 

