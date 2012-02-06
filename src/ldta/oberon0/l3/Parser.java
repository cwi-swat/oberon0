package ldta.oberon0.l3;

import java.io.IOException;
import java.io.StringReader;

import org.eclipse.imp.pdb.facts.type.TypeFactory;
import org.eclipse.imp.pdb.facts.IConstructor;
import org.eclipse.imp.pdb.facts.IValue;
import org.eclipse.imp.pdb.facts.IValueFactory;
import org.eclipse.imp.pdb.facts.exceptions.FactTypeUseException;
import org.eclipse.imp.pdb.facts.io.StandardTextReader;
import org.rascalmpl.parser.gtd.stack.*;
import org.rascalmpl.parser.gtd.stack.filter.*;
import org.rascalmpl.parser.gtd.stack.filter.follow.*;
import org.rascalmpl.parser.gtd.stack.filter.match.*;
import org.rascalmpl.parser.gtd.stack.filter.precede.*;
import org.rascalmpl.parser.gtd.preprocessing.ExpectBuilder;
import org.rascalmpl.parser.gtd.util.IntegerKeyedHashMap;
import org.rascalmpl.parser.gtd.util.IntegerList;
import org.rascalmpl.parser.gtd.util.IntegerMap;
import org.rascalmpl.values.ValueFactoryFactory;
import org.rascalmpl.values.uptr.Factory;

public class Parser extends org.rascalmpl.library.lang.rascal.syntax.RascalRascal {
  protected final static IValueFactory VF = ValueFactoryFactory.getValueFactory();
  
  private static final IntegerMap _resultStoreIdMappings;
  private static final IntegerKeyedHashMap<IntegerList> _dontNest;
	
  protected static void _putDontNest(IntegerKeyedHashMap<IntegerList> result, int parentId, int childId) {
    IntegerList donts = result.get(childId);
    if (donts == null) {
      donts = new IntegerList();
      result.put(childId, donts);
    }
    donts.add(parentId);
  }
    
  protected int getResultStoreId(int parentId) {
    return _resultStoreIdMappings.get(parentId);
  }
    
  protected static IntegerKeyedHashMap<IntegerList> _initDontNest() {
    IntegerKeyedHashMap<IntegerList> result = org.rascalmpl.library.lang.rascal.syntax.RascalRascal._initDontNest(); 
    
    
    
    
    _putDontNest(result, 320, 338);
    
    _putDontNest(result, 318, 348);
    
    _putDontNest(result, 400, 390);
    
    _putDontNest(result, 380, 410);
    
    _putDontNest(result, 390, 400);
    
    _putDontNest(result, 328, 338);
    
    _putDontNest(result, 420, 430);
    
    _putDontNest(result, 310, 348);
    
    _putDontNest(result, 412, 390);
    
    _putDontNest(result, 372, 410);
    
    _putDontNest(result, 338, 380);
    
    _putDontNest(result, 364, 370);
    
    _putDontNest(result, 354, 364);
    
    _putDontNest(result, 298, 308);
    
    _putDontNest(result, 402, 400);
    
    _putDontNest(result, 422, 420);
    
    _putDontNest(result, 298, 348);
    
    _putDontNest(result, 330, 380);
    
    _putDontNest(result, 364, 410);
    
    _putDontNest(result, 410, 400);
    
    _putDontNest(result, 318, 308);
    
    _putDontNest(result, 430, 420);
    
    _putDontNest(result, 348, 338);
    
    _putDontNest(result, 290, 348);
    
    _putDontNest(result, 370, 364);
    
    _putDontNest(result, 392, 390);
    
    _putDontNest(result, 356, 410);
    
    _putDontNest(result, 308, 298);
    
    _putDontNest(result, 364, 354);
    
    _putDontNest(result, 382, 380);
    
    _putDontNest(result, 320, 370);
    
    _putDontNest(result, 348, 410);
    
    _putDontNest(result, 422, 400);
    
    _putDontNest(result, 402, 420);
    
    _putDontNest(result, 392, 430);
    
    _putDontNest(result, 308, 318);
    
    _putDontNest(result, 328, 370);
    
    _putDontNest(result, 340, 410);
    
    _putDontNest(result, 348, 354);
    
    _putDontNest(result, 430, 400);
    
    _putDontNest(result, 274, 348);
    
    _putDontNest(result, 370, 380);
    
    _putDontNest(result, 410, 420);
    
    _putDontNest(result, 364, 338);
    
    _putDontNest(result, 390, 420);
    
    _putDontNest(result, 320, 354);
    
    _putDontNest(result, 412, 430);
    
    _putDontNest(result, 328, 410);
    
    _putDontNest(result, 420, 390);
    
    _putDontNest(result, 274, 308);
    
    _putDontNest(result, 328, 354);
    
    _putDontNest(result, 320, 410);
    
    _putDontNest(result, 348, 370);
    
    _putDontNest(result, 354, 380);
    
    _putDontNest(result, 400, 430);
    
    _putDontNest(result, 338, 364);
    
    _putDontNest(result, 298, 364);
    
    _putDontNest(result, 308, 354);
    
    _putDontNest(result, 290, 364);
    
    _putDontNest(result, 370, 348);
    
    _putDontNest(result, 308, 410);
    
    _putDontNest(result, 274, 380);
    
    _putDontNest(result, 300, 370);
    
    _putDontNest(result, 318, 364);
    
    _putDontNest(result, 328, 318);
    
    _putDontNest(result, 300, 410);
    
    _putDontNest(result, 308, 370);
    
    _putDontNest(result, 274, 328);
    
    _putDontNest(result, 310, 364);
    
    _putDontNest(result, 300, 354);
    
    _putDontNest(result, 354, 348);
    
    _putDontNest(result, 328, 298);
    
    _putDontNest(result, 318, 380);
    
    _putDontNest(result, 298, 328);
    
    _putDontNest(result, 310, 380);
    
    _putDontNest(result, 300, 338);
    
    _putDontNest(result, 338, 348);
    
    _putDontNest(result, 318, 328);
    
    _putDontNest(result, 298, 380);
    
    _putDontNest(result, 308, 338);
    
    _putDontNest(result, 290, 380);
    
    _putDontNest(result, 274, 364);
    
    _putDontNest(result, 310, 420);
    
    _putDontNest(result, 300, 430);
    
    _putDontNest(result, 318, 420);
    
    _putDontNest(result, 274, 400);
    
    _putDontNest(result, 290, 420);
    
    _putDontNest(result, 308, 430);
    
    _putDontNest(result, 298, 420);
    
    _putDontNest(result, 308, 390);
    
    _putDontNest(result, 290, 400);
    
    _putDontNest(result, 274, 420);
    
    _putDontNest(result, 298, 400);
    
    _putDontNest(result, 310, 400);
    
    _putDontNest(result, 300, 390);
    
    _putDontNest(result, 318, 400);
    
    _putDontNest(result, 340, 390);
    
    _putDontNest(result, 364, 430);
    
    _putDontNest(result, 370, 420);
    
    _putDontNest(result, 410, 380);
    
    _putDontNest(result, 348, 390);
    
    _putDontNest(result, 382, 420);
    
    _putDontNest(result, 330, 400);
    
    _putDontNest(result, 356, 430);
    
    _putDontNest(result, 402, 380);
    
    _putDontNest(result, 380, 430);
    
    _putDontNest(result, 338, 400);
    
    _putDontNest(result, 354, 420);
    
    _putDontNest(result, 320, 390);
    
    _putDontNest(result, 372, 430);
    
    _putDontNest(result, 390, 380);
    
    _putDontNest(result, 420, 410);
    
    _putDontNest(result, 328, 390);
    
    _putDontNest(result, 354, 400);
    
    _putDontNest(result, 372, 390);
    
    _putDontNest(result, 338, 420);
    
    _putDontNest(result, 328, 430);
    
    _putDontNest(result, 412, 410);
    
    _putDontNest(result, 400, 410);
    
    _putDontNest(result, 380, 390);
    
    _putDontNest(result, 320, 430);
    
    _putDontNest(result, 392, 410);
    
    _putDontNest(result, 370, 400);
    
    _putDontNest(result, 356, 390);
    
    _putDontNest(result, 430, 380);
    
    _putDontNest(result, 348, 430);
    
    _putDontNest(result, 364, 390);
    
    _putDontNest(result, 422, 380);
    
    _putDontNest(result, 340, 430);
    
    _putDontNest(result, 330, 420);
    
    _putDontNest(result, 382, 400);
    
    _putDontNest(result, 364, 364);
    
    _putDontNest(result, 354, 370);
    
    _putDontNest(result, 298, 298);
    
    _putDontNest(result, 370, 354);
    
    _putDontNest(result, 328, 328);
    
    _putDontNest(result, 430, 430);
    
    _putDontNest(result, 348, 380);
    
    _putDontNest(result, 382, 410);
    
    _putDontNest(result, 402, 390);
    
    _putDontNest(result, 370, 410);
    
    _putDontNest(result, 422, 430);
    
    _putDontNest(result, 340, 380);
    
    _putDontNest(result, 392, 400);
    
    _putDontNest(result, 308, 348);
    
    _putDontNest(result, 274, 318);
    
    _putDontNest(result, 410, 390);
    
    _putDontNest(result, 338, 338);
    
    _putDontNest(result, 390, 390);
    
    _putDontNest(result, 308, 308);
    
    _putDontNest(result, 420, 420);
    
    _putDontNest(result, 300, 348);
    
    _putDontNest(result, 400, 400);
    
    _putDontNest(result, 328, 380);
    
    _putDontNest(result, 318, 298);
    
    _putDontNest(result, 354, 410);
    
    _putDontNest(result, 320, 380);
    
    _putDontNest(result, 412, 400);
    
    _putDontNest(result, 318, 318);
    
    _putDontNest(result, 354, 338);
    
    _putDontNest(result, 380, 380);
    
    _putDontNest(result, 338, 354);
    
    _putDontNest(result, 328, 364);
    
    _putDontNest(result, 400, 420);
    
    _putDontNest(result, 420, 400);
    
    _putDontNest(result, 338, 410);
    
    _putDontNest(result, 372, 380);
    
    _putDontNest(result, 412, 420);
    
    _putDontNest(result, 390, 430);
    
    _putDontNest(result, 320, 364);
    
    _putDontNest(result, 422, 390);
    
    _putDontNest(result, 364, 380);
    
    _putDontNest(result, 348, 364);
    
    _putDontNest(result, 370, 338);
    
    _putDontNest(result, 338, 370);
    
    _putDontNest(result, 330, 410);
    
    _putDontNest(result, 410, 430);
    
    _putDontNest(result, 298, 318);
    
    _putDontNest(result, 430, 390);
    
    _putDontNest(result, 356, 380);
    
    _putDontNest(result, 274, 298);
    
    _putDontNest(result, 392, 420);
    
    _putDontNest(result, 402, 430);
    
    _putDontNest(result, 300, 364);
    
    _putDontNest(result, 290, 370);
    
    _putDontNest(result, 318, 410);
    
    _putDontNest(result, 310, 354);
    
    _putDontNest(result, 298, 370);
    
    _putDontNest(result, 310, 410);
    
    _putDontNest(result, 318, 354);
    
    _putDontNest(result, 364, 348);
    
    _putDontNest(result, 274, 338);
    
    _putDontNest(result, 298, 410);
    
    _putDontNest(result, 290, 354);
    
    _putDontNest(result, 310, 370);
    
    _putDontNest(result, 290, 410);
    
    _putDontNest(result, 308, 364);
    
    _putDontNest(result, 298, 354);
    
    _putDontNest(result, 318, 370);
    
    _putDontNest(result, 348, 348);
    
    _putDontNest(result, 274, 354);
    
    _putDontNest(result, 290, 338);
    
    _putDontNest(result, 274, 410);
    
    _putDontNest(result, 308, 380);
    
    _putDontNest(result, 298, 338);
    
    _putDontNest(result, 328, 308);
    
    _putDontNest(result, 274, 370);
    
    _putDontNest(result, 300, 380);
    
    _putDontNest(result, 328, 348);
    
    _putDontNest(result, 310, 338);
    
    _putDontNest(result, 320, 348);
    
    _putDontNest(result, 318, 338);
    
    _putDontNest(result, 308, 328);
    
    _putDontNest(result, 308, 420);
    
    _putDontNest(result, 274, 390);
    
    _putDontNest(result, 298, 430);
    
    _putDontNest(result, 290, 430);
    
    _putDontNest(result, 318, 430);
    
    _putDontNest(result, 310, 430);
    
    _putDontNest(result, 300, 420);
    
    _putDontNest(result, 310, 390);
    
    _putDontNest(result, 318, 390);
    
    _putDontNest(result, 300, 400);
    
    _putDontNest(result, 308, 400);
    
    _putDontNest(result, 290, 390);
    
    _putDontNest(result, 298, 390);
    
    _putDontNest(result, 274, 430);
    
    _putDontNest(result, 412, 380);
    
    _putDontNest(result, 320, 400);
    
    _putDontNest(result, 372, 420);
    
    _putDontNest(result, 338, 390);
    
    _putDontNest(result, 328, 400);
    
    _putDontNest(result, 380, 420);
    
    _putDontNest(result, 354, 430);
    
    _putDontNest(result, 400, 380);
    
    _putDontNest(result, 356, 420);
    
    _putDontNest(result, 382, 430);
    
    _putDontNest(result, 340, 400);
    
    _putDontNest(result, 392, 380);
    
    _putDontNest(result, 430, 410);
    
    _putDontNest(result, 364, 420);
    
    _putDontNest(result, 330, 390);
    
    _putDontNest(result, 370, 430);
    
    _putDontNest(result, 348, 400);
    
    _putDontNest(result, 422, 410);
    
    _putDontNest(result, 410, 410);
    
    _putDontNest(result, 340, 420);
    
    _putDontNest(result, 370, 390);
    
    _putDontNest(result, 330, 430);
    
    _putDontNest(result, 356, 400);
    
    _putDontNest(result, 382, 390);
    
    _putDontNest(result, 402, 410);
    
    _putDontNest(result, 348, 420);
    
    _putDontNest(result, 364, 400);
    
    _putDontNest(result, 372, 400);
    
    _putDontNest(result, 320, 420);
    
    _putDontNest(result, 354, 390);
    
    _putDontNest(result, 420, 380);
    
    _putDontNest(result, 380, 400);
    
    _putDontNest(result, 390, 410);
    
    _putDontNest(result, 338, 430);
    
    _putDontNest(result, 328, 420);
   return result;
  }
    
  protected static IntegerMap _initDontNestGroups() {
    IntegerMap result = org.rascalmpl.library.lang.rascal.syntax.RascalRascal._initDontNestGroups();
    int resultStoreId = result.size();
    
    
    ++resultStoreId;
    
    result.putUnsafe(354, resultStoreId);
    ++resultStoreId;
    
    result.putUnsafe(370, resultStoreId);
    ++resultStoreId;
    
    result.putUnsafe(318, resultStoreId);
    result.putUnsafe(298, resultStoreId);
    result.putUnsafe(328, resultStoreId);
    result.putUnsafe(308, resultStoreId);
    result.putUnsafe(274, resultStoreId);
    ++resultStoreId;
    
    result.putUnsafe(430, resultStoreId);
    result.putUnsafe(382, resultStoreId);
    result.putUnsafe(412, resultStoreId);
    result.putUnsafe(380, resultStoreId);
    result.putUnsafe(330, resultStoreId);
    result.putUnsafe(410, resultStoreId);
    result.putUnsafe(392, resultStoreId);
    result.putUnsafe(422, resultStoreId);
    result.putUnsafe(390, resultStoreId);
    result.putUnsafe(356, resultStoreId);
    result.putUnsafe(420, resultStoreId);
    result.putUnsafe(340, resultStoreId);
    result.putUnsafe(372, resultStoreId);
    result.putUnsafe(402, resultStoreId);
    result.putUnsafe(400, resultStoreId);
    ++resultStoreId;
    
    result.putUnsafe(348, resultStoreId);
    result.putUnsafe(300, resultStoreId);
    result.putUnsafe(364, resultStoreId);
    result.putUnsafe(310, resultStoreId);
    result.putUnsafe(290, resultStoreId);
    result.putUnsafe(338, resultStoreId);
    result.putUnsafe(320, resultStoreId);
      
    return result;
  }
  
  protected boolean hasNestingRestrictions(String name){
		return (_dontNest.size() != 0); // TODO Make more specific.
  }
    
  protected IntegerList getFilteredParents(int childId) {
		return _dontNest.get(childId);
  }
    
  // initialize priorities     
  static {
    _dontNest = _initDontNest();
    _resultStoreIdMappings = _initDontNestGroups();
  }
    
  // Production declarations
	
  private static final IConstructor regular__iter_star_seps__Formal__layouts_Layouts_lit___59_layouts_Layouts = (IConstructor) _read("regular(\\iter-star-seps(sort(\"Formal\"),[layouts(\"Layouts\"),lit(\";\"),layouts(\"Layouts\")]))", Factory.Production);
  private static final IConstructor prod__Keywords__lit_END_ = (IConstructor) _read("prod(keywords(\"Keywords\"),[lit(\"END\")],{})", Factory.Production);
  private static final IConstructor prod__ElsIfPart__lit_ELSIF_layouts_Layouts_condition_Expression_layouts_Layouts_lit_THEN_layouts_Layouts_body_iter_seps__Statement__layouts_Layouts_lit___59_layouts_Layouts_ = (IConstructor) _read("prod(sort(\"ElsIfPart\"),[lit(\"ELSIF\"),layouts(\"Layouts\"),label(\"condition\",sort(\"Expression\")),layouts(\"Layouts\"),lit(\"THEN\"),layouts(\"Layouts\"),label(\"body\",\\iter-seps(sort(\"Statement\"),[layouts(\"Layouts\"),lit(\";\"),layouts(\"Layouts\")]))],{})", Factory.Production);
  private static final IConstructor prod__neq_Expression__lhs_Expression_layouts_Layouts_lit___35_layouts_Layouts_rhs_Expression__assoc__non_assoc = (IConstructor) _read("prod(label(\"neq\",sort(\"Expression\")),[label(\"lhs\",sort(\"Expression\")),layouts(\"Layouts\"),lit(\"#\"),layouts(\"Layouts\"),label(\"rhs\",sort(\"Expression\"))],{assoc(\\non-assoc())})", Factory.Production);
  private static final IConstructor prod__CommentChar__char_class___range__0_39_range__41_41_range__43_16777215_ = (IConstructor) _read("prod(lex(\"CommentChar\"),[\\char-class([range(0,39),range(41,41),range(43,16777215)])],{})", Factory.Production);
  private static final IConstructor prod__mod_Expression__lhs_Expression_layouts_Layouts_lit_MOD_layouts_Layouts_rhs_Expression__assoc__left = (IConstructor) _read("prod(label(\"mod\",sort(\"Expression\")),[label(\"lhs\",sort(\"Expression\")),layouts(\"Layouts\"),lit(\"MOD\"),layouts(\"Layouts\"),label(\"rhs\",sort(\"Expression\"))],{assoc(left())})", Factory.Production);
  private static final IConstructor prod__forDo_Statement__lit_FOR_layouts_Layouts_name_Ident_layouts_Layouts_lit___58_61_layouts_Layouts_from_Expression_layouts_Layouts_lit_TO_layouts_Layouts_to_Expression_layouts_Layouts_opt__seq___lit_BY_layouts_Layouts_Expression_layouts_Layouts_lit_DO_layouts_Layouts_body_iter_seps__Statement__layouts_Layouts_lit___59_layouts_Layouts_layouts_Layouts_lit_END_ = (IConstructor) _read("prod(label(\"forDo\",sort(\"Statement\")),[lit(\"FOR\"),layouts(\"Layouts\"),label(\"name\",lex(\"Ident\")),layouts(\"Layouts\"),lit(\":=\"),layouts(\"Layouts\"),label(\"from\",sort(\"Expression\")),layouts(\"Layouts\"),lit(\"TO\"),layouts(\"Layouts\"),label(\"to\",sort(\"Expression\")),layouts(\"Layouts\"),opt(seq([lit(\"BY\"),layouts(\"Layouts\"),sort(\"Expression\")])),layouts(\"Layouts\"),lit(\"DO\"),layouts(\"Layouts\"),label(\"body\",\\iter-seps(sort(\"Statement\"),[layouts(\"Layouts\"),lit(\";\"),layouts(\"Layouts\")])),layouts(\"Layouts\"),lit(\"END\")],{})", Factory.Production);
  private static final IConstructor regular__iter_star_seps__TypeDecl__layouts_Layouts = (IConstructor) _read("regular(\\iter-star-seps(sort(\"TypeDecl\"),[layouts(\"Layouts\")]))", Factory.Production);
  private static final IConstructor prod__pos_Expression__lit___43_layouts_Layouts_exp_Expression__assoc__right = (IConstructor) _read("prod(label(\"pos\",sort(\"Expression\")),[lit(\"+\"),layouts(\"Layouts\"),label(\"exp\",sort(\"Expression\"))],{assoc(right())})", Factory.Production);
  private static final IConstructor prod__ElsePart__lit_ELSE_layouts_Layouts_body_iter_seps__Statement__layouts_Layouts_lit___59_layouts_Layouts_ = (IConstructor) _read("prod(sort(\"ElsePart\"),[lit(\"ELSE\"),layouts(\"Layouts\"),label(\"body\",\\iter-seps(sort(\"Statement\"),[layouts(\"Layouts\"),lit(\";\"),layouts(\"Layouts\")]))],{})", Factory.Production);
  private static final IConstructor prod__lit___62_61__char_class___range__62_62_char_class___range__61_61_ = (IConstructor) _read("prod(lit(\"\\>=\"),[\\char-class([range(62,62)]),\\char-class([range(61,61)])],{})", Factory.Production);
  private static final IConstructor prod__sub_Expression__lhs_Expression_layouts_Layouts_lit___layouts_Layouts_rhs_Expression__assoc__left = (IConstructor) _read("prod(label(\"sub\",sort(\"Expression\")),[label(\"lhs\",sort(\"Expression\")),layouts(\"Layouts\"),lit(\"-\"),layouts(\"Layouts\"),label(\"rhs\",sort(\"Expression\"))],{assoc(left())})", Factory.Production);
  private static final IConstructor prod__lit_BEGIN__char_class___range__66_66_char_class___range__69_69_char_class___range__71_71_char_class___range__73_73_char_class___range__78_78_ = (IConstructor) _read("prod(lit(\"BEGIN\"),[\\char-class([range(66,66)]),\\char-class([range(69,69)]),\\char-class([range(71,71)]),\\char-class([range(73,73)]),\\char-class([range(78,78)])],{})", Factory.Production);
  private static final IConstructor prod__constDecl_ConstDecl__name_Ident_layouts_Layouts_lit___61_layouts_Layouts_value_Expression_layouts_Layouts_lit___59_ = (IConstructor) _read("prod(label(\"constDecl\",sort(\"ConstDecl\")),[label(\"name\",lex(\"Ident\")),layouts(\"Layouts\"),lit(\"=\"),layouts(\"Layouts\"),label(\"value\",sort(\"Expression\")),layouts(\"Layouts\"),lit(\";\")],{})", Factory.Production);
  private static final IConstructor prod__lt_Expression__lhs_Expression_layouts_Layouts_lit___60_layouts_Layouts_rhs_Expression__assoc__non_assoc = (IConstructor) _read("prod(label(\"lt\",sort(\"Expression\")),[label(\"lhs\",sort(\"Expression\")),layouts(\"Layouts\"),lit(\"\\<\"),layouts(\"Layouts\"),label(\"rhs\",sort(\"Expression\"))],{assoc(\\non-assoc())})", Factory.Production);
  private static final IConstructor prod__lit_THEN__char_class___range__84_84_char_class___range__72_72_char_class___range__69_69_char_class___range__78_78_ = (IConstructor) _read("prod(lit(\"THEN\"),[\\char-class([range(84,84)]),\\char-class([range(72,72)]),\\char-class([range(69,69)]),\\char-class([range(78,78)])],{})", Factory.Production);
  private static final IConstructor prod__Natural__char_class___range__49_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_conditional__char_class___range__48_57__not_follow__char_class___range__48_57_ = (IConstructor) _read("prod(lex(\"Natural\"),[\\char-class([range(49,57)]),\\char-class([range(48,57)]),\\char-class([range(48,57)]),\\char-class([range(48,57)]),\\char-class([range(48,57)]),\\char-class([range(48,57)]),\\char-class([range(48,57)]),\\char-class([range(48,57)]),conditional(\\char-class([range(48,57)]),{\\not-follow(\\char-class([range(48,57)]))})],{})", Factory.Production);
  private static final IConstructor prod__lit_DO__char_class___range__68_68_char_class___range__79_79_ = (IConstructor) _read("prod(lit(\"DO\"),[\\char-class([range(68,68)]),\\char-class([range(79,79)])],{})", Factory.Production);
  private static final IConstructor prod__Keywords__lit_BY_ = (IConstructor) _read("prod(keywords(\"Keywords\"),[lit(\"BY\")],{})", Factory.Production);
  private static final IConstructor prod__layouts_$BACKTICKS__ = (IConstructor) _read("prod(layouts(\"$BACKTICKS\"),[],{})", Factory.Production);
  private static final IConstructor prod__Keywords__lit_DIV_ = (IConstructor) _read("prod(keywords(\"Keywords\"),[lit(\"DIV\")],{})", Factory.Production);
  private static final IConstructor prod__Keywords__lit_DO_ = (IConstructor) _read("prod(keywords(\"Keywords\"),[lit(\"DO\")],{})", Factory.Production);
  private static final IConstructor prod__Keywords__lit_IF_ = (IConstructor) _read("prod(keywords(\"Keywords\"),[lit(\"IF\")],{})", Factory.Production);
  private static final IConstructor prod__lit_REPEAT__char_class___range__82_82_char_class___range__69_69_char_class___range__80_80_char_class___range__69_69_char_class___range__65_65_char_class___range__84_84_ = (IConstructor) _read("prod(lit(\"REPEAT\"),[\\char-class([range(82,82)]),\\char-class([range(69,69)]),\\char-class([range(80,80)]),\\char-class([range(69,69)]),\\char-class([range(65,65)]),\\char-class([range(84,84)])],{})", Factory.Production);
  private static final IConstructor prod__formal_Formal__hasVar_opt__lit_VAR_layouts_Layouts_params_iter_seps__Ident__layouts_Layouts_lit___44_layouts_Layouts_layouts_Layouts_lit___58_layouts_Layouts_type_Type_ = (IConstructor) _read("prod(label(\"formal\",sort(\"Formal\")),[label(\"hasVar\",opt(lit(\"VAR\"))),layouts(\"Layouts\"),label(\"params\",\\iter-seps(lex(\"Ident\"),[layouts(\"Layouts\"),lit(\",\"),layouts(\"Layouts\")])),layouts(\"Layouts\"),lit(\":\"),layouts(\"Layouts\"),label(\"type\",sort(\"Type\"))],{})", Factory.Production);
  private static final IConstructor regular__iter_star__CommentElt = (IConstructor) _read("regular(\\iter-star(lex(\"CommentElt\")))", Factory.Production);
  private static final IConstructor prod__lit___60_61__char_class___range__60_60_char_class___range__61_61_ = (IConstructor) _read("prod(lit(\"\\<=\"),[\\char-class([range(60,60)]),\\char-class([range(61,61)])],{})", Factory.Production);
  private static final IConstructor prod__lit_MOD__char_class___range__77_77_char_class___range__79_79_char_class___range__68_68_ = (IConstructor) _read("prod(lit(\"MOD\"),[\\char-class([range(77,77)]),\\char-class([range(79,79)]),\\char-class([range(68,68)])],{})", Factory.Production);
  private static final IConstructor prod__Body__lit_BEGIN_layouts_Layouts_iter_seps__Statement__layouts_Layouts_lit___59_layouts_Layouts__tag__Foldable = (IConstructor) _read("prod(sort(\"Body\"),[lit(\"BEGIN\"),layouts(\"Layouts\"),\\iter-seps(sort(\"Statement\"),[layouts(\"Layouts\"),lit(\";\"),layouts(\"Layouts\")])],{tag(Foldable())})", Factory.Production);
  private static final IConstructor prod__Keywords__lit_OF_ = (IConstructor) _read("prod(keywords(\"Keywords\"),[lit(\"OF\")],{})", Factory.Production);
  private static final IConstructor prod__layouts_$default$__ = (IConstructor) _read("prod(layouts(\"$default$\"),[],{})", Factory.Production);
  private static final IConstructor prod__Keywords__lit_OR_ = (IConstructor) _read("prod(keywords(\"Keywords\"),[lit(\"OR\")],{})", Factory.Production);
  private static final IConstructor prod__lit_CASE__char_class___range__67_67_char_class___range__65_65_char_class___range__83_83_char_class___range__69_69_ = (IConstructor) _read("prod(lit(\"CASE\"),[\\char-class([range(67,67)]),\\char-class([range(65,65)]),\\char-class([range(83,83)]),\\char-class([range(69,69)])],{})", Factory.Production);
  private static final IConstructor prod__Keywords__lit_TO_ = (IConstructor) _read("prod(keywords(\"Keywords\"),[lit(\"TO\")],{})", Factory.Production);
  private static final IConstructor regular__opt__ConstSect = (IConstructor) _read("regular(opt(sort(\"ConstSect\")))", Factory.Production);
  private static final IConstructor prod__eq_Expression__lhs_Expression_layouts_Layouts_lit___61_layouts_Layouts_rhs_Expression__assoc__non_assoc = (IConstructor) _read("prod(label(\"eq\",sort(\"Expression\")),[label(\"lhs\",sort(\"Expression\")),layouts(\"Layouts\"),lit(\"=\"),layouts(\"Layouts\"),label(\"rhs\",sort(\"Expression\"))],{assoc(\\non-assoc())})", Factory.Production);
  private static final IConstructor prod__Natural__char_class___range__49_57_char_class___range__48_57_char_class___range__48_57_conditional__char_class___range__48_57__not_follow__char_class___range__48_57_ = (IConstructor) _read("prod(lex(\"Natural\"),[\\char-class([range(49,57)]),\\char-class([range(48,57)]),\\char-class([range(48,57)]),conditional(\\char-class([range(48,57)]),{\\not-follow(\\char-class([range(48,57)]))})],{})", Factory.Production);
  private static final IConstructor regular__iter_star_seps__Ident__layouts_Layouts_lit___44_layouts_Layouts = (IConstructor) _read("regular(\\iter-star-seps(lex(\"Ident\"),[layouts(\"Layouts\"),lit(\",\"),layouts(\"Layouts\")]))", Factory.Production);
  private static final IConstructor prod__lit_ELSIF__char_class___range__69_69_char_class___range__76_76_char_class___range__83_83_char_class___range__73_73_char_class___range__70_70_ = (IConstructor) _read("prod(lit(\"ELSIF\"),[\\char-class([range(69,69)]),\\char-class([range(76,76)]),\\char-class([range(83,83)]),\\char-class([range(73,73)]),\\char-class([range(70,70)])],{})", Factory.Production);
  private static final IConstructor prod__Keywords__lit_MOD_ = (IConstructor) _read("prod(keywords(\"Keywords\"),[lit(\"MOD\")],{})", Factory.Production);
  private static final IConstructor prod__lit_ELSE__char_class___range__69_69_char_class___range__76_76_char_class___range__83_83_char_class___range__69_69_ = (IConstructor) _read("prod(lit(\"ELSE\"),[\\char-class([range(69,69)]),\\char-class([range(76,76)]),\\char-class([range(83,83)]),\\char-class([range(69,69)])],{})", Factory.Production);
  private static final IConstructor prod__Keywords__lit_VAR_ = (IConstructor) _read("prod(keywords(\"Keywords\"),[lit(\"VAR\")],{})", Factory.Production);
  private static final IConstructor prod__geq_Expression__lhs_Expression_layouts_Layouts_lit___62_61_layouts_Layouts_rhs_Expression__assoc__non_assoc = (IConstructor) _read("prod(label(\"geq\",sort(\"Expression\")),[label(\"lhs\",sort(\"Expression\")),layouts(\"Layouts\"),lit(\"\\>=\"),layouts(\"Layouts\"),label(\"rhs\",sort(\"Expression\"))],{assoc(\\non-assoc())})", Factory.Production);
  private static final IConstructor prod__lit_TYPE__char_class___range__84_84_char_class___range__89_89_char_class___range__80_80_char_class___range__69_69_ = (IConstructor) _read("prod(lit(\"TYPE\"),[\\char-class([range(84,84)]),\\char-class([range(89,89)]),\\char-class([range(80,80)]),\\char-class([range(69,69)])],{})", Factory.Production);
  private static final IConstructor prod__Keywords__lit_ELSE_ = (IConstructor) _read("prod(keywords(\"Keywords\"),[lit(\"ELSE\")],{})", Factory.Production);
  private static final IConstructor prod__Natural__char_class___range__49_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_conditional__char_class___range__48_57__not_follow__char_class___range__48_57_ = (IConstructor) _read("prod(lex(\"Natural\"),[\\char-class([range(49,57)]),\\char-class([range(48,57)]),\\char-class([range(48,57)]),\\char-class([range(48,57)]),\\char-class([range(48,57)]),\\char-class([range(48,57)]),conditional(\\char-class([range(48,57)]),{\\not-follow(\\char-class([range(48,57)]))})],{})", Factory.Production);
  private static final IConstructor prod__lit_OR__char_class___range__79_79_char_class___range__82_82_ = (IConstructor) _read("prod(lit(\"OR\"),[\\char-class([range(79,79)]),\\char-class([range(82,82)])],{})", Factory.Production);
  private static final IConstructor prod__call_Statement__name_Ident_layouts_Layouts_actuals_opt__Actuals_ = (IConstructor) _read("prod(label(\"call\",sort(\"Statement\")),[label(\"name\",lex(\"Ident\")),layouts(\"Layouts\"),label(\"actuals\",opt(sort(\"Actuals\")))],{})", Factory.Production);
  private static final IConstructor prod__Keywords__lit_THEN_ = (IConstructor) _read("prod(keywords(\"Keywords\"),[lit(\"THEN\")],{})", Factory.Production);
  private static final IConstructor prod__Formals__lit___40_layouts_Layouts_formals_iter_star_seps__Formal__layouts_Layouts_lit___59_layouts_Layouts_layouts_Layouts_lit___41_ = (IConstructor) _read("prod(sort(\"Formals\"),[lit(\"(\"),layouts(\"Layouts\"),label(\"formals\",\\iter-star-seps(sort(\"Formal\"),[layouts(\"Layouts\"),lit(\";\"),layouts(\"Layouts\")])),layouts(\"Layouts\"),lit(\")\")],{})", Factory.Production);
  private static final IConstructor regular__opt__Formals = (IConstructor) _read("regular(opt(sort(\"Formals\")))", Factory.Production);
  private static final IConstructor prod__guard_Case__iter_seps__Label__layouts_Layouts_lit___44_layouts_Layouts_layouts_Layouts_lit___58_layouts_Layouts_body_iter_seps__Statement__layouts_Layouts_lit___59_layouts_Layouts_ = (IConstructor) _read("prod(label(\"guard\",sort(\"Case\")),[\\iter-seps(sort(\"Label\"),[layouts(\"Layouts\"),lit(\",\"),layouts(\"Layouts\")]),layouts(\"Layouts\"),lit(\":\"),layouts(\"Layouts\"),label(\"body\",\\iter-seps(sort(\"Statement\"),[layouts(\"Layouts\"),lit(\";\"),layouts(\"Layouts\")]))],{})", Factory.Production);
  private static final IConstructor regular__iter_star__char_class___range__48_57_range__65_90_range__97_122 = (IConstructor) _read("regular(\\iter-star(\\char-class([range(48,57),range(65,90),range(97,122)])))", Factory.Production);
  private static final IConstructor prod__typeDecl_TypeDecl__name_Ident_layouts_Layouts_lit___61_layouts_Layouts_type_Type_layouts_Layouts_lit___59_ = (IConstructor) _read("prod(label(\"typeDecl\",sort(\"TypeDecl\")),[label(\"name\",lex(\"Ident\")),layouts(\"Layouts\"),lit(\"=\"),layouts(\"Layouts\"),label(\"type\",sort(\"Type\")),layouts(\"Layouts\"),lit(\";\")],{})", Factory.Production);
  private static final IConstructor prod__decls_Declarations__consts_opt__ConstSect_layouts_Layouts_types_opt__TypeSect_layouts_Layouts_vars_opt__VarSect_ = (IConstructor) _read("prod(label(\"decls\",sort(\"Declarations\")),[label(\"consts\",opt(sort(\"ConstSect\"))),layouts(\"Layouts\"),label(\"types\",opt(sort(\"TypeSect\"))),layouts(\"Layouts\"),label(\"vars\",opt(sort(\"VarSect\")))],{})", Factory.Production);
  private static final IConstructor prod__Keywords__lit_UNTIL_ = (IConstructor) _read("prod(keywords(\"Keywords\"),[lit(\"UNTIL\")],{})", Factory.Production);
  private static final IConstructor prod__Keywords__lit_TYPE_ = (IConstructor) _read("prod(keywords(\"Keywords\"),[lit(\"TYPE\")],{})", Factory.Production);
  private static final IConstructor regular__iter_seps__Label__layouts_Layouts_lit___44_layouts_Layouts = (IConstructor) _read("regular(\\iter-seps(sort(\"Label\"),[layouts(\"Layouts\"),lit(\",\"),layouts(\"Layouts\")]))", Factory.Production);
  private static final IConstructor prod__Keywords__lit_BEGIN_ = (IConstructor) _read("prod(keywords(\"Keywords\"),[lit(\"BEGIN\")],{})", Factory.Production);
  private static final IConstructor prod__assign_Statement__var_Ident_layouts_Layouts_lit___58_61_layouts_Layouts_exp_Expression_ = (IConstructor) _read("prod(label(\"assign\",sort(\"Statement\")),[label(\"var\",lex(\"Ident\")),layouts(\"Layouts\"),lit(\":=\"),layouts(\"Layouts\"),label(\"exp\",sort(\"Expression\"))],{})", Factory.Production);
  private static final IConstructor prod__lit_FOR__char_class___range__70_70_char_class___range__79_79_char_class___range__82_82_ = (IConstructor) _read("prod(lit(\"FOR\"),[\\char-class([range(70,70)]),\\char-class([range(79,79)]),\\char-class([range(82,82)])],{})", Factory.Production);
  private static final IConstructor regular__iter_seps__ProcedureDecl__layouts_Layouts = (IConstructor) _read("regular(\\iter-seps(sort(\"ProcedureDecl\"),[layouts(\"Layouts\")]))", Factory.Production);
  private static final IConstructor prod__Natural__char_class___range__49_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_conditional__char_class___range__48_57__not_follow__char_class___range__48_57_ = (IConstructor) _read("prod(lex(\"Natural\"),[\\char-class([range(49,57)]),\\char-class([range(48,57)]),\\char-class([range(48,57)]),\\char-class([range(48,57)]),\\char-class([range(48,57)]),\\char-class([range(48,57)]),\\char-class([range(48,57)]),conditional(\\char-class([range(48,57)]),{\\not-follow(\\char-class([range(48,57)]))})],{})", Factory.Production);
  private static final IConstructor prod__Keywords__lit_REPEAT_ = (IConstructor) _read("prod(keywords(\"Keywords\"),[lit(\"REPEAT\")],{})", Factory.Production);
  private static final IConstructor prod__lit___46_46__char_class___range__46_46_char_class___range__46_46_ = (IConstructor) _read("prod(lit(\"..\"),[\\char-class([range(46,46)]),\\char-class([range(46,46)])],{})", Factory.Production);
  private static final IConstructor regular__seq___conditional__char_class___range__65_90_range__97_122__not_precede__char_class___range__65_90_range__97_122_conditional__iter_star__char_class___range__48_57_range__65_90_range__97_122__not_follow__char_class___range__48_57_range__65_90_range__97_122 = (IConstructor) _read("regular(seq([conditional(\\char-class([range(65,90),range(97,122)]),{\\not-precede(\\char-class([range(65,90),range(97,122)]))}),conditional(\\iter-star(\\char-class([range(48,57),range(65,90),range(97,122)])),{\\not-follow(\\char-class([range(48,57),range(65,90),range(97,122)]))})]))", Factory.Production);
  private static final IConstructor regular__iter_star__char_class___range__9_10_range__13_13_range__32_32 = (IConstructor) _read("regular(\\iter-star(\\char-class([range(9,10),range(13,13),range(32,32)])))", Factory.Production);
  private static final IConstructor prod__leq_Expression__lhs_Expression_layouts_Layouts_lit___60_61_layouts_Layouts_rhs_Expression__assoc__non_assoc = (IConstructor) _read("prod(label(\"leq\",sort(\"Expression\")),[label(\"lhs\",sort(\"Expression\")),layouts(\"Layouts\"),lit(\"\\<=\"),layouts(\"Layouts\"),label(\"rhs\",sort(\"Expression\"))],{assoc(\\non-assoc())})", Factory.Production);
  private static final IConstructor prod__gt_Expression__lhs_Expression_layouts_Layouts_lit___62_layouts_Layouts_rhs_Expression__assoc__non_assoc = (IConstructor) _read("prod(label(\"gt\",sort(\"Expression\")),[label(\"lhs\",sort(\"Expression\")),layouts(\"Layouts\"),lit(\"\\>\"),layouts(\"Layouts\"),label(\"rhs\",sort(\"Expression\"))],{assoc(\\non-assoc())})", Factory.Production);
  private static final IConstructor regular__iter_star_seps__ElsIfPart__layouts_Layouts = (IConstructor) _read("regular(\\iter-star-seps(sort(\"ElsIfPart\"),[layouts(\"Layouts\")]))", Factory.Production);
  private static final IConstructor prod__lit_END__char_class___range__69_69_char_class___range__78_78_char_class___range__68_68_ = (IConstructor) _read("prod(lit(\"END\"),[\\char-class([range(69,69)]),\\char-class([range(78,78)]),\\char-class([range(68,68)])],{})", Factory.Production);
  private static final IConstructor prod__Keywords__lit_ELSIF_ = (IConstructor) _read("prod(keywords(\"Keywords\"),[lit(\"ELSIF\")],{})", Factory.Production);
  private static final IConstructor regular__iter_star_seps__VarDecl__layouts_Layouts = (IConstructor) _read("regular(\\iter-star-seps(sort(\"VarDecl\"),[layouts(\"Layouts\")]))", Factory.Production);
  private static final IConstructor prod__lit_OF__char_class___range__79_79_char_class___range__70_70_ = (IConstructor) _read("prod(lit(\"OF\"),[\\char-class([range(79,79)]),\\char-class([range(70,70)])],{})", Factory.Production);
  private static final IConstructor prod__ifThen_Statement__lit_IF_layouts_Layouts_condition_Expression_layouts_Layouts_lit_THEN_layouts_Layouts_body_iter_seps__Statement__layouts_Layouts_lit___59_layouts_Layouts_layouts_Layouts_iter_star_seps__ElsIfPart__layouts_Layouts_layouts_Layouts_opt__ElsePart_layouts_Layouts_lit_END_ = (IConstructor) _read("prod(label(\"ifThen\",sort(\"Statement\")),[lit(\"IF\"),layouts(\"Layouts\"),label(\"condition\",sort(\"Expression\")),layouts(\"Layouts\"),lit(\"THEN\"),layouts(\"Layouts\"),label(\"body\",\\iter-seps(sort(\"Statement\"),[layouts(\"Layouts\"),lit(\";\"),layouts(\"Layouts\")])),layouts(\"Layouts\"),\\iter-star-seps(sort(\"ElsIfPart\"),[layouts(\"Layouts\")]),layouts(\"Layouts\"),opt(sort(\"ElsePart\")),layouts(\"Layouts\"),lit(\"END\")],{})", Factory.Production);
  private static final IConstructor prod__lit_PROCEDURE__char_class___range__80_80_char_class___range__82_82_char_class___range__79_79_char_class___range__67_67_char_class___range__69_69_char_class___range__68_68_char_class___range__85_85_char_class___range__82_82_char_class___range__69_69_ = (IConstructor) _read("prod(lit(\"PROCEDURE\"),[\\char-class([range(80,80)]),\\char-class([range(82,82)]),\\char-class([range(79,79)]),\\char-class([range(67,67)]),\\char-class([range(69,69)]),\\char-class([range(68,68)]),\\char-class([range(85,85)]),\\char-class([range(82,82)]),\\char-class([range(69,69)])],{})", Factory.Production);
  private static final IConstructor prod__lit_WHILE__char_class___range__87_87_char_class___range__72_72_char_class___range__73_73_char_class___range__76_76_char_class___range__69_69_ = (IConstructor) _read("prod(lit(\"WHILE\"),[\\char-class([range(87,87)]),\\char-class([range(72,72)]),\\char-class([range(73,73)]),\\char-class([range(76,76)]),\\char-class([range(69,69)])],{})", Factory.Production);
  private static final IConstructor prod__CommentChar__conditional__char_class___range__42_42__not_follow__char_class___range__41_41_ = (IConstructor) _read("prod(lex(\"CommentChar\"),[conditional(\\char-class([range(42,42)]),{\\not-follow(\\char-class([range(41,41)]))})],{})", Factory.Production);
  private static final IConstructor prod__CommentChar__conditional__char_class___range__40_40__not_follow__char_class___range__42_42_ = (IConstructor) _read("prod(lex(\"CommentChar\"),[conditional(\\char-class([range(40,40)]),{\\not-follow(\\char-class([range(42,42)]))})],{})", Factory.Production);
  private static final IConstructor prod__or_Expression__lhs_Expression_layouts_Layouts_lit_OR_layouts_Layouts_rhs_Expression__assoc__left = (IConstructor) _read("prod(label(\"or\",sort(\"Expression\")),[label(\"lhs\",sort(\"Expression\")),layouts(\"Layouts\"),lit(\"OR\"),layouts(\"Layouts\"),label(\"rhs\",sort(\"Expression\"))],{assoc(left())})", Factory.Production);
  private static final IConstructor prod__id_Ident__conditional__seq___conditional__char_class___range__65_90_range__97_122__not_precede__char_class___range__65_90_range__97_122_conditional__iter_star__char_class___range__48_57_range__65_90_range__97_122__not_follow__char_class___range__48_57_range__65_90_range__97_122__delete__Keywords_ = (IConstructor) _read("prod(label(\"id\",lex(\"Ident\")),[conditional(seq([conditional(\\char-class([range(65,90),range(97,122)]),{\\not-precede(\\char-class([range(65,90),range(97,122)]))}),conditional(\\iter-star(\\char-class([range(48,57),range(65,90),range(97,122)])),{\\not-follow(\\char-class([range(48,57),range(65,90),range(97,122)]))})]),{delete(keywords(\"Keywords\"))})],{})", Factory.Production);
  private static final IConstructor prod__mod_Module__lit_MODULE_layouts_Layouts_name_Ident_layouts_Layouts_lit___59_layouts_Layouts_decls_Declarations_layouts_Layouts_body_opt__Body_layouts_Layouts_lit_END_layouts_Layouts_Ident_layouts_Layouts_lit___46_ = (IConstructor) _read("prod(label(\"mod\",sort(\"Module\")),[lit(\"MODULE\"),layouts(\"Layouts\"),label(\"name\",lex(\"Ident\")),layouts(\"Layouts\"),lit(\";\"),layouts(\"Layouts\"),label(\"decls\",sort(\"Declarations\")),layouts(\"Layouts\"),label(\"body\",opt(sort(\"Body\"))),layouts(\"Layouts\"),lit(\"END\"),layouts(\"Layouts\"),lex(\"Ident\"),layouts(\"Layouts\"),lit(\".\")],{})", Factory.Production);
  private static final IConstructor prod__CommentElt__Comment_ = (IConstructor) _read("prod(lex(\"CommentElt\"),[lex(\"Comment\")],{})", Factory.Production);
  private static final IConstructor regular__iter_seps__Ident__layouts_Layouts_lit___44_layouts_Layouts = (IConstructor) _read("regular(\\iter-seps(lex(\"Ident\"),[layouts(\"Layouts\"),lit(\",\"),layouts(\"Layouts\")]))", Factory.Production);
  private static final IConstructor regular__iter_star__Layout = (IConstructor) _read("regular(\\iter-star(lex(\"Layout\")))", Factory.Production);
  private static final IConstructor prod__whileDo_Statement__lit_WHILE_layouts_Layouts_condition_Expression_layouts_Layouts_lit_DO_layouts_Layouts_body_iter_seps__Statement__layouts_Layouts_lit___59_layouts_Layouts_layouts_Layouts_lit_END_ = (IConstructor) _read("prod(label(\"whileDo\",sort(\"Statement\")),[lit(\"WHILE\"),layouts(\"Layouts\"),label(\"condition\",sort(\"Expression\")),layouts(\"Layouts\"),lit(\"DO\"),layouts(\"Layouts\"),label(\"body\",\\iter-seps(sort(\"Statement\"),[layouts(\"Layouts\"),lit(\";\"),layouts(\"Layouts\")])),layouts(\"Layouts\"),lit(\"END\")],{})", Factory.Production);
  private static final IConstructor prod__Natural__char_class___range__49_57_conditional__char_class___range__48_57__not_follow__char_class___range__48_57_ = (IConstructor) _read("prod(lex(\"Natural\"),[\\char-class([range(49,57)]),conditional(\\char-class([range(48,57)]),{\\not-follow(\\char-class([range(48,57)]))})],{})", Factory.Production);
  private static final IConstructor regular__opt__Actuals = (IConstructor) _read("regular(opt(sort(\"Actuals\")))", Factory.Production);
  private static final IConstructor prod__Natural__char_class___range__49_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_conditional__char_class___range__48_57__not_follow__char_class___range__48_57_ = (IConstructor) _read("prod(lex(\"Natural\"),[\\char-class([range(49,57)]),\\char-class([range(48,57)]),\\char-class([range(48,57)]),\\char-class([range(48,57)]),conditional(\\char-class([range(48,57)]),{\\not-follow(\\char-class([range(48,57)]))})],{})", Factory.Production);
  private static final IConstructor prod__not_Expression__lit___126_layouts_Layouts_exp_Expression_ = (IConstructor) _read("prod(label(\"not\",sort(\"Expression\")),[lit(\"~\"),layouts(\"Layouts\"),label(\"exp\",sort(\"Expression\"))],{})", Factory.Production);
  private static final IConstructor prod__lit___42_41__char_class___range__42_42_char_class___range__41_41_ = (IConstructor) _read("prod(lit(\"*)\"),[\\char-class([range(42,42)]),\\char-class([range(41,41)])],{})", Factory.Production);
  private static final IConstructor prod__mul_Expression__lhs_Expression_layouts_Layouts_lit___42_layouts_Layouts_rhs_Expression__assoc__left = (IConstructor) _read("prod(label(\"mul\",sort(\"Expression\")),[label(\"lhs\",sort(\"Expression\")),layouts(\"Layouts\"),lit(\"*\"),layouts(\"Layouts\"),label(\"rhs\",sort(\"Expression\"))],{assoc(left())})", Factory.Production);
  private static final IConstructor prod__amp_Expression__lhs_Expression_layouts_Layouts_lit___38_layouts_Layouts_rhs_Expression__assoc__left = (IConstructor) _read("prod(label(\"amp\",sort(\"Expression\")),[label(\"lhs\",sort(\"Expression\")),layouts(\"Layouts\"),lit(\"&\"),layouts(\"Layouts\"),label(\"rhs\",sort(\"Expression\"))],{assoc(left())})", Factory.Production);
  private static final IConstructor prod__proc_ProcedureDecl__lit_PROCEDURE_layouts_Layouts_name_Ident_layouts_Layouts_formals_opt__Formals_layouts_Layouts_lit___59_layouts_Layouts_decls_Declarations_layouts_Layouts_body_opt__Body_layouts_Layouts_lit_END_layouts_Layouts_Ident_layouts_Layouts_lit___59__tag__Foldable = (IConstructor) _read("prod(label(\"proc\",sort(\"ProcedureDecl\")),[lit(\"PROCEDURE\"),layouts(\"Layouts\"),label(\"name\",lex(\"Ident\")),layouts(\"Layouts\"),label(\"formals\",opt(sort(\"Formals\"))),layouts(\"Layouts\"),lit(\";\"),layouts(\"Layouts\"),label(\"decls\",sort(\"Declarations\")),layouts(\"Layouts\"),label(\"body\",opt(sort(\"Body\"))),layouts(\"Layouts\"),lit(\"END\"),layouts(\"Layouts\"),lex(\"Ident\"),layouts(\"Layouts\"),lit(\";\")],{tag(Foldable())})", Factory.Production);
  private static final IConstructor prod__Keywords__lit_CONST_ = (IConstructor) _read("prod(keywords(\"Keywords\"),[lit(\"CONST\")],{})", Factory.Production);
  private static final IConstructor prod__TypeSect__lit_TYPE_layouts_Layouts_types_iter_star_seps__TypeDecl__layouts_Layouts_ = (IConstructor) _read("prod(sort(\"TypeSect\"),[lit(\"TYPE\"),layouts(\"Layouts\"),label(\"types\",\\iter-star-seps(sort(\"TypeDecl\"),[layouts(\"Layouts\")]))],{})", Factory.Production);
  private static final IConstructor prod__lit___59__char_class___range__59_59_ = (IConstructor) _read("prod(lit(\";\"),[\\char-class([range(59,59)])],{})", Factory.Production);
  private static final IConstructor regular__iter_star_seps__ConstDecl__layouts_Layouts = (IConstructor) _read("regular(\\iter-star-seps(sort(\"ConstDecl\"),[layouts(\"Layouts\")]))", Factory.Production);
  private static final IConstructor prod__lit___58__char_class___range__58_58_ = (IConstructor) _read("prod(lit(\":\"),[\\char-class([range(58,58)])],{})", Factory.Production);
  private static final IConstructor prod__lit___61__char_class___range__61_61_ = (IConstructor) _read("prod(lit(\"=\"),[\\char-class([range(61,61)])],{})", Factory.Production);
  private static final IConstructor prod__lit___60__char_class___range__60_60_ = (IConstructor) _read("prod(lit(\"\\<\"),[\\char-class([range(60,60)])],{})", Factory.Production);
  private static final IConstructor prod__lit___62__char_class___range__62_62_ = (IConstructor) _read("prod(lit(\"\\>\"),[\\char-class([range(62,62)])],{})", Factory.Production);
  private static final IConstructor prod__skip_Statement__ = (IConstructor) _read("prod(label(\"skip\",sort(\"Statement\")),[],{})", Factory.Production);
  private static final IConstructor prod__lit_UNTIL__char_class___range__85_85_char_class___range__78_78_char_class___range__84_84_char_class___range__73_73_char_class___range__76_76_ = (IConstructor) _read("prod(lit(\"UNTIL\"),[\\char-class([range(85,85)]),\\char-class([range(78,78)]),\\char-class([range(84,84)]),\\char-class([range(73,73)]),\\char-class([range(76,76)])],{})", Factory.Production);
  private static final IConstructor regular__seq___lit_BY_layouts_Layouts_Expression = (IConstructor) _read("regular(seq([lit(\"BY\"),layouts(\"Layouts\"),sort(\"Expression\")]))", Factory.Production);
  private static final IConstructor regular__opt__TypeSect = (IConstructor) _read("regular(opt(sort(\"TypeSect\")))", Factory.Production);
  private static final IConstructor prod__range_Label__from_Expression_layouts_Layouts_lit___46_46_layouts_Layouts_to_Expression_ = (IConstructor) _read("prod(label(\"range\",sort(\"Label\")),[label(\"from\",sort(\"Expression\")),layouts(\"Layouts\"),lit(\"..\"),layouts(\"Layouts\"),label(\"to\",sort(\"Expression\"))],{})", Factory.Production);
  private static final IConstructor prod__empty__ = (IConstructor) _read("prod(empty(),[],{})", Factory.Production);
  private static final IConstructor prod__lit___40_42__char_class___range__40_40_char_class___range__42_42_ = (IConstructor) _read("prod(lit(\"(*\"),[\\char-class([range(40,40)]),\\char-class([range(42,42)])],{})", Factory.Production);
  private static final IConstructor prod__nat_Expression__value_Natural_ = (IConstructor) _read("prod(label(\"nat\",sort(\"Expression\")),[label(\"value\",lex(\"Natural\"))],{})", Factory.Production);
  private static final IConstructor prod__decls_Declarations__consts_opt__ConstSect_layouts_Layouts_types_opt__TypeSect_layouts_Layouts_vars_opt__VarSect_layouts_Layouts_procs_iter_seps__ProcedureDecl__layouts_Layouts_ = (IConstructor) _read("prod(label(\"decls\",sort(\"Declarations\")),[label(\"consts\",opt(sort(\"ConstSect\"))),layouts(\"Layouts\"),label(\"types\",opt(sort(\"TypeSect\"))),layouts(\"Layouts\"),label(\"vars\",opt(sort(\"VarSect\"))),layouts(\"Layouts\"),label(\"procs\",\\iter-seps(sort(\"ProcedureDecl\"),[layouts(\"Layouts\")]))],{})", Factory.Production);
  private static final IConstructor prod__lit___41__char_class___range__41_41_ = (IConstructor) _read("prod(lit(\")\"),[\\char-class([range(41,41)])],{})", Factory.Production);
  private static final IConstructor prod__lit___40__char_class___range__40_40_ = (IConstructor) _read("prod(lit(\"(\"),[\\char-class([range(40,40)])],{})", Factory.Production);
  private static final IConstructor prod__lit___43__char_class___range__43_43_ = (IConstructor) _read("prod(lit(\"+\"),[\\char-class([range(43,43)])],{})", Factory.Production);
  private static final IConstructor prod__lit___42__char_class___range__42_42_ = (IConstructor) _read("prod(lit(\"*\"),[\\char-class([range(42,42)])],{})", Factory.Production);
  private static final IConstructor prod__Keywords__lit_MODULE_ = (IConstructor) _read("prod(keywords(\"Keywords\"),[lit(\"MODULE\")],{})", Factory.Production);
  private static final IConstructor prod__lit____char_class___range__45_45_ = (IConstructor) _read("prod(lit(\"-\"),[\\char-class([range(45,45)])],{})", Factory.Production);
  private static final IConstructor prod__lit_IF__char_class___range__73_73_char_class___range__70_70_ = (IConstructor) _read("prod(lit(\"IF\"),[\\char-class([range(73,73)]),\\char-class([range(70,70)])],{})", Factory.Production);
  private static final IConstructor prod__lit___44__char_class___range__44_44_ = (IConstructor) _read("prod(lit(\",\"),[\\char-class([range(44,44)])],{})", Factory.Production);
  private static final IConstructor prod__Bracket_Expression__lit___40_layouts_Layouts_exp_Expression_layouts_Layouts_lit___41__bracket = (IConstructor) _read("prod(label(\"Bracket\",sort(\"Expression\")),[lit(\"(\"),layouts(\"Layouts\"),label(\"exp\",sort(\"Expression\")),layouts(\"Layouts\"),lit(\")\")],{bracket()})", Factory.Production);
  private static final IConstructor regular__iter_star_seps__Expression__layouts_Layouts_lit___44_layouts_Layouts = (IConstructor) _read("regular(\\iter-star-seps(sort(\"Expression\"),[layouts(\"Layouts\"),lit(\",\"),layouts(\"Layouts\")]))", Factory.Production);
  private static final IConstructor prod__lit___46__char_class___range__46_46_ = (IConstructor) _read("prod(lit(\".\"),[\\char-class([range(46,46)])],{})", Factory.Production);
  private static final IConstructor prod__Natural__char_class___range__49_50_char_class___range__48_49_char_class___range__48_52_char_class___range__48_55_char_class___range__48_52_char_class___range__48_56_char_class___range__48_51_char_class___range__48_54_char_class___range__48_52_conditional__char_class___range__48_55__not_follow__char_class___range__48_57_ = (IConstructor) _read("prod(lex(\"Natural\"),[\\char-class([range(49,50)]),\\char-class([range(48,49)]),\\char-class([range(48,52)]),\\char-class([range(48,55)]),\\char-class([range(48,52)]),\\char-class([range(48,56)]),\\char-class([range(48,51)]),\\char-class([range(48,54)]),\\char-class([range(48,52)]),conditional(\\char-class([range(48,55)]),{\\not-follow(\\char-class([range(48,57)]))})],{})", Factory.Production);
  private static final IConstructor prod__lit___35__char_class___range__35_35_ = (IConstructor) _read("prod(lit(\"#\"),[\\char-class([range(35,35)])],{})", Factory.Production);
  private static final IConstructor prod__Natural__conditional__char_class___range__48_57__not_follow__char_class___range__48_57_ = (IConstructor) _read("prod(lex(\"Natural\"),[conditional(\\char-class([range(48,57)]),{\\not-follow(\\char-class([range(48,57)]))})],{})", Factory.Production);
  private static final IConstructor prod__lit___38__char_class___range__38_38_ = (IConstructor) _read("prod(lit(\"&\"),[\\char-class([range(38,38)])],{})", Factory.Production);
  private static final IConstructor regular__iter__CommentChar = (IConstructor) _read("regular(iter(lex(\"CommentChar\")))", Factory.Production);
  private static final IConstructor prod__lit_DIV__char_class___range__68_68_char_class___range__73_73_char_class___range__86_86_ = (IConstructor) _read("prod(lit(\"DIV\"),[\\char-class([range(68,68)]),\\char-class([range(73,73)]),\\char-class([range(86,86)])],{})", Factory.Production);
  private static final IConstructor prod__lit_MODULE__char_class___range__77_77_char_class___range__79_79_char_class___range__68_68_char_class___range__85_85_char_class___range__76_76_char_class___range__69_69_ = (IConstructor) _read("prod(lit(\"MODULE\"),[\\char-class([range(77,77)]),\\char-class([range(79,79)]),\\char-class([range(68,68)]),\\char-class([range(85,85)]),\\char-class([range(76,76)]),\\char-class([range(69,69)])],{})", Factory.Production);
  private static final IConstructor regular__opt__lit_VAR = (IConstructor) _read("regular(opt(lit(\"VAR\")))", Factory.Production);
  private static final IConstructor prod__caseOf_Statement__lit_CASE_layouts_Layouts_exp_Expression_layouts_Layouts_lit_OF_layouts_Layouts_cases_iter_seps__Case__layouts_Layouts_lit___124_layouts_Layouts_layouts_Layouts_elsePart_opt__ElsePart_layouts_Layouts_lit_END_ = (IConstructor) _read("prod(label(\"caseOf\",sort(\"Statement\")),[lit(\"CASE\"),layouts(\"Layouts\"),label(\"exp\",sort(\"Expression\")),layouts(\"Layouts\"),lit(\"OF\"),layouts(\"Layouts\"),label(\"cases\",\\iter-seps(sort(\"Case\"),[layouts(\"Layouts\"),lit(\"|\"),layouts(\"Layouts\")])),layouts(\"Layouts\"),label(\"elsePart\",opt(sort(\"ElsePart\"))),layouts(\"Layouts\"),lit(\"END\")],{})", Factory.Production);
  private static final IConstructor prod__lookup_Expression__var_Ident_ = (IConstructor) _read("prod(label(\"lookup\",sort(\"Expression\")),[label(\"var\",lex(\"Ident\"))],{})", Factory.Production);
  private static final IConstructor prod__neg_Expression__lit___layouts_Layouts_exp_Expression__assoc__right = (IConstructor) _read("prod(label(\"neg\",sort(\"Expression\")),[lit(\"-\"),layouts(\"Layouts\"),label(\"exp\",sort(\"Expression\"))],{assoc(right())})", Factory.Production);
  private static final IConstructor prod__div_Expression__lhs_Expression_layouts_Layouts_lit_DIV_layouts_Layouts_rhs_Expression__assoc__left = (IConstructor) _read("prod(label(\"div\",sort(\"Expression\")),[label(\"lhs\",sort(\"Expression\")),layouts(\"Layouts\"),lit(\"DIV\"),layouts(\"Layouts\"),label(\"rhs\",sort(\"Expression\"))],{assoc(left())})", Factory.Production);
  private static final IConstructor prod__lit_VAR__char_class___range__86_86_char_class___range__65_65_char_class___range__82_82_ = (IConstructor) _read("prod(lit(\"VAR\"),[\\char-class([range(86,86)]),\\char-class([range(65,65)]),\\char-class([range(82,82)])],{})", Factory.Production);
  private static final IConstructor prod__Actuals__lit___40_layouts_Layouts_expressions_iter_star_seps__Expression__layouts_Layouts_lit___44_layouts_Layouts_layouts_Layouts_lit___41_ = (IConstructor) _read("prod(sort(\"Actuals\"),[lit(\"(\"),layouts(\"Layouts\"),label(\"expressions\",\\iter-star-seps(sort(\"Expression\"),[layouts(\"Layouts\"),lit(\",\"),layouts(\"Layouts\")])),layouts(\"Layouts\"),lit(\")\")],{})", Factory.Production);
  private static final IConstructor prod__start__Module__layouts_Layouts_top_Module_layouts_Layouts_ = (IConstructor) _read("prod(start(sort(\"Module\")),[layouts(\"Layouts\"),label(\"top\",sort(\"Module\")),layouts(\"Layouts\")],{})", Factory.Production);
  private static final IConstructor prod__expression_Label__exp_Expression_ = (IConstructor) _read("prod(label(\"expression\",sort(\"Label\")),[label(\"exp\",sort(\"Expression\"))],{})", Factory.Production);
  private static final IConstructor prod__lit_TO__char_class___range__84_84_char_class___range__79_79_ = (IConstructor) _read("prod(lit(\"TO\"),[\\char-class([range(84,84)]),\\char-class([range(79,79)])],{})", Factory.Production);
  private static final IConstructor prod__CommentElt__iter__CommentChar_ = (IConstructor) _read("prod(lex(\"CommentElt\"),[iter(lex(\"CommentChar\"))],{})", Factory.Production);
  private static final IConstructor prod__Layout__Comment__tag__category___67_111_109_109_101_110_116 = (IConstructor) _read("prod(lex(\"Layout\"),[lex(\"Comment\")],{tag(category(\"Comment\"))})", Factory.Production);
  private static final IConstructor prod__VarSect__lit_VAR_layouts_Layouts_vars_iter_star_seps__VarDecl__layouts_Layouts__tag__Foldable = (IConstructor) _read("prod(sort(\"VarSect\"),[lit(\"VAR\"),layouts(\"Layouts\"),label(\"vars\",\\iter-star-seps(sort(\"VarDecl\"),[layouts(\"Layouts\")]))],{tag(Foldable())})", Factory.Production);
  private static final IConstructor regular__opt__seq___lit_BY_layouts_Layouts_Expression = (IConstructor) _read("regular(opt(seq([lit(\"BY\"),layouts(\"Layouts\"),sort(\"Expression\")])))", Factory.Production);
  private static final IConstructor regular__opt__Body = (IConstructor) _read("regular(opt(sort(\"Body\")))", Factory.Production);
  private static final IConstructor prod__Natural__char_class___range__49_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_conditional__char_class___range__48_57__not_follow__char_class___range__48_57_ = (IConstructor) _read("prod(lex(\"Natural\"),[\\char-class([range(49,57)]),\\char-class([range(48,57)]),\\char-class([range(48,57)]),\\char-class([range(48,57)]),\\char-class([range(48,57)]),conditional(\\char-class([range(48,57)]),{\\not-follow(\\char-class([range(48,57)]))})],{})", Factory.Production);
  private static final IConstructor prod__lit_CONST__char_class___range__67_67_char_class___range__79_79_char_class___range__78_78_char_class___range__83_83_char_class___range__84_84_ = (IConstructor) _read("prod(lit(\"CONST\"),[\\char-class([range(67,67)]),\\char-class([range(79,79)]),\\char-class([range(78,78)]),\\char-class([range(83,83)]),\\char-class([range(84,84)])],{})", Factory.Production);
  private static final IConstructor regular__iter_seps__Case__layouts_Layouts_lit___124_layouts_Layouts = (IConstructor) _read("regular(\\iter-seps(sort(\"Case\"),[layouts(\"Layouts\"),lit(\"|\"),layouts(\"Layouts\")]))", Factory.Production);
  private static final IConstructor prod__Keywords__lit_FOR_ = (IConstructor) _read("prod(keywords(\"Keywords\"),[lit(\"FOR\")],{})", Factory.Production);
  private static final IConstructor prod__lit___126__char_class___range__126_126_ = (IConstructor) _read("prod(lit(\"~\"),[\\char-class([range(126,126)])],{})", Factory.Production);
  private static final IConstructor prod__Natural__char_class___range__49_57_char_class___range__48_57_conditional__char_class___range__48_57__not_follow__char_class___range__48_57_ = (IConstructor) _read("prod(lex(\"Natural\"),[\\char-class([range(49,57)]),\\char-class([range(48,57)]),conditional(\\char-class([range(48,57)]),{\\not-follow(\\char-class([range(48,57)]))})],{})", Factory.Production);
  private static final IConstructor prod__lit___124__char_class___range__124_124_ = (IConstructor) _read("prod(lit(\"|\"),[\\char-class([range(124,124)])],{})", Factory.Production);
  private static final IConstructor prod__lit___58_61__char_class___range__58_58_char_class___range__61_61_ = (IConstructor) _read("prod(lit(\":=\"),[\\char-class([range(58,58)]),\\char-class([range(61,61)])],{})", Factory.Production);
  private static final IConstructor prod__Comment__lit___40_42_iter_star__CommentElt_lit___42_41_ = (IConstructor) _read("prod(lex(\"Comment\"),[lit(\"(*\"),\\iter-star(lex(\"CommentElt\")),lit(\"*)\")],{})", Factory.Production);
  private static final IConstructor prod__whitespace_Layout__char_class___range__9_10_range__13_13_range__32_32_ = (IConstructor) _read("prod(label(\"whitespace\",lex(\"Layout\")),[\\char-class([range(9,10),range(13,13),range(32,32)])],{})", Factory.Production);
  private static final IConstructor prod__add_Expression__lhs_Expression_layouts_Layouts_lit___43_layouts_Layouts_rhs_Expression__assoc__left = (IConstructor) _read("prod(label(\"add\",sort(\"Expression\")),[label(\"lhs\",sort(\"Expression\")),layouts(\"Layouts\"),lit(\"+\"),layouts(\"Layouts\"),label(\"rhs\",sort(\"Expression\"))],{assoc(left())})", Factory.Production);
  private static final IConstructor prod__user_Type__name_Ident_ = (IConstructor) _read("prod(label(\"user\",sort(\"Type\")),[label(\"name\",lex(\"Ident\"))],{})", Factory.Production);
  private static final IConstructor prod__Keywords__lit_PROCEDURE_ = (IConstructor) _read("prod(keywords(\"Keywords\"),[lit(\"PROCEDURE\")],{})", Factory.Production);
  private static final IConstructor prod__layouts_Layouts__conditional__iter_star__Layout__not_follow__char_class___range__9_10_range__13_13_range__32_32_not_follow__lit___40_42_ = (IConstructor) _read("prod(layouts(\"Layouts\"),[conditional(\\iter-star(lex(\"Layout\")),{\\not-follow(\\char-class([range(9,10),range(13,13),range(32,32)])),\\not-follow(lit(\"(*\"))})],{})", Factory.Production);
  private static final IConstructor prod__Keywords__lit_WHILE_ = (IConstructor) _read("prod(keywords(\"Keywords\"),[lit(\"WHILE\")],{})", Factory.Production);
  private static final IConstructor regular__iter_seps__Statement__layouts_Layouts_lit___59_layouts_Layouts = (IConstructor) _read("regular(\\iter-seps(sort(\"Statement\"),[layouts(\"Layouts\"),lit(\";\"),layouts(\"Layouts\")]))", Factory.Production);
  private static final IConstructor prod__varDecl_VarDecl__names_iter_star_seps__Ident__layouts_Layouts_lit___44_layouts_Layouts_layouts_Layouts_lit___58_layouts_Layouts_type_Type_layouts_Layouts_lit___59_ = (IConstructor) _read("prod(label(\"varDecl\",sort(\"VarDecl\")),[label(\"names\",\\iter-star-seps(lex(\"Ident\"),[layouts(\"Layouts\"),lit(\",\"),layouts(\"Layouts\")])),layouts(\"Layouts\"),lit(\":\"),layouts(\"Layouts\"),label(\"type\",sort(\"Type\")),layouts(\"Layouts\"),lit(\";\")],{})", Factory.Production);
  private static final IConstructor prod__Keywords__lit_CASE_ = (IConstructor) _read("prod(keywords(\"Keywords\"),[lit(\"CASE\")],{})", Factory.Production);
  private static final IConstructor regular__opt__ElsePart = (IConstructor) _read("regular(opt(sort(\"ElsePart\")))", Factory.Production);
  private static final IConstructor prod__ConstSect__lit_CONST_layouts_Layouts_consts_iter_star_seps__ConstDecl__layouts_Layouts_ = (IConstructor) _read("prod(sort(\"ConstSect\"),[lit(\"CONST\"),layouts(\"Layouts\"),label(\"consts\",\\iter-star-seps(sort(\"ConstDecl\"),[layouts(\"Layouts\")]))],{})", Factory.Production);
  private static final IConstructor prod__layouts_$QUOTES__conditional__iter_star__char_class___range__9_10_range__13_13_range__32_32__not_follow__char_class___range__9_10_range__13_13_range__32_32_ = (IConstructor) _read("prod(layouts(\"$QUOTES\"),[conditional(\\iter-star(\\char-class([range(9,10),range(13,13),range(32,32)])),{\\not-follow(\\char-class([range(9,10),range(13,13),range(32,32)]))})],{})", Factory.Production);
  private static final IConstructor prod__lit_BY__char_class___range__66_66_char_class___range__89_89_ = (IConstructor) _read("prod(lit(\"BY\"),[\\char-class([range(66,66)]),\\char-class([range(89,89)])],{})", Factory.Production);
  private static final IConstructor regular__opt__VarSect = (IConstructor) _read("regular(opt(sort(\"VarSect\")))", Factory.Production);
    
  // Item declarations
	
	
  protected static class CommentElt {
    public final static AbstractStackNode[] EXPECTS;
    static{
      ExpectBuilder builder = new ExpectBuilder(_resultStoreIdMappings);
      init(builder);
      EXPECTS = builder.buildExpectArray();
    }
    
    protected static final void _init_prod__CommentElt__iter__CommentChar_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new ListStackNode(10, 0, regular__iter__CommentChar, new NonTerminalStackNode(12, 0, "CommentChar", null, null), true, null, null);
      builder.addAlternative(Parser.prod__CommentElt__iter__CommentChar_, tmp);
	}
    protected static final void _init_prod__CommentElt__Comment_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new NonTerminalStackNode(14, 0, "Comment", null, null);
      builder.addAlternative(Parser.prod__CommentElt__Comment_, tmp);
	}
    public static void init(ExpectBuilder builder){
      
      
        _init_prod__CommentElt__iter__CommentChar_(builder);
      
        _init_prod__CommentElt__Comment_(builder);
      
    }
  }
	
  protected static class Actuals {
    public final static AbstractStackNode[] EXPECTS;
    static{
      ExpectBuilder builder = new ExpectBuilder(_resultStoreIdMappings);
      init(builder);
      EXPECTS = builder.buildExpectArray();
    }
    
    protected static final void _init_prod__Actuals__lit___40_layouts_Layouts_expressions_iter_star_seps__Expression__layouts_Layouts_lit___44_layouts_Layouts_layouts_Layouts_lit___41_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[5];
      
      tmp[4] = new LiteralStackNode(34, 4, prod__lit___41__char_class___range__41_41_, new int[] {41}, null, null);
      tmp[3] = new NonTerminalStackNode(32, 3, "layouts_Layouts", null, null);
      tmp[2] = new SeparatedListStackNode(22, 2, regular__iter_star_seps__Expression__layouts_Layouts_lit___44_layouts_Layouts, new NonTerminalStackNode(24, 0, "Expression", null, null), new AbstractStackNode[]{new NonTerminalStackNode(26, 1, "layouts_Layouts", null, null), new LiteralStackNode(28, 2, prod__lit___44__char_class___range__44_44_, new int[] {44}, null, null), new NonTerminalStackNode(30, 3, "layouts_Layouts", null, null)}, false, null, null);
      tmp[1] = new NonTerminalStackNode(20, 1, "layouts_Layouts", null, null);
      tmp[0] = new LiteralStackNode(18, 0, prod__lit___40__char_class___range__40_40_, new int[] {40}, null, null);
      builder.addAlternative(Parser.prod__Actuals__lit___40_layouts_Layouts_expressions_iter_star_seps__Expression__layouts_Layouts_lit___44_layouts_Layouts_layouts_Layouts_lit___41_, tmp);
	}
    public static void init(ExpectBuilder builder){
      
      
        _init_prod__Actuals__lit___40_layouts_Layouts_expressions_iter_star_seps__Expression__layouts_Layouts_lit___44_layouts_Layouts_layouts_Layouts_lit___41_(builder);
      
    }
  }
	
  protected static class Formal {
    public final static AbstractStackNode[] EXPECTS;
    static{
      ExpectBuilder builder = new ExpectBuilder(_resultStoreIdMappings);
      init(builder);
      EXPECTS = builder.buildExpectArray();
    }
    
    protected static final void _init_prod__formal_Formal__hasVar_opt__lit_VAR_layouts_Layouts_params_iter_seps__Ident__layouts_Layouts_lit___44_layouts_Layouts_layouts_Layouts_lit___58_layouts_Layouts_type_Type_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[7];
      
      tmp[6] = new NonTerminalStackNode(70, 6, "Type", null, null);
      tmp[5] = new NonTerminalStackNode(68, 5, "layouts_Layouts", null, null);
      tmp[4] = new LiteralStackNode(66, 4, prod__lit___58__char_class___range__58_58_, new int[] {58}, null, null);
      tmp[3] = new NonTerminalStackNode(64, 3, "layouts_Layouts", null, null);
      tmp[2] = new SeparatedListStackNode(54, 2, regular__iter_seps__Ident__layouts_Layouts_lit___44_layouts_Layouts, new NonTerminalStackNode(56, 0, "Ident", null, null), new AbstractStackNode[]{new NonTerminalStackNode(58, 1, "layouts_Layouts", null, null), new LiteralStackNode(60, 2, prod__lit___44__char_class___range__44_44_, new int[] {44}, null, null), new NonTerminalStackNode(62, 3, "layouts_Layouts", null, null)}, true, null, null);
      tmp[1] = new NonTerminalStackNode(52, 1, "layouts_Layouts", null, null);
      tmp[0] = new OptionalStackNode(48, 0, regular__opt__lit_VAR, new LiteralStackNode(50, 0, prod__lit_VAR__char_class___range__86_86_char_class___range__65_65_char_class___range__82_82_, new int[] {86,65,82}, null, null), null, null);
      builder.addAlternative(Parser.prod__formal_Formal__hasVar_opt__lit_VAR_layouts_Layouts_params_iter_seps__Ident__layouts_Layouts_lit___44_layouts_Layouts_layouts_Layouts_lit___58_layouts_Layouts_type_Type_, tmp);
	}
    public static void init(ExpectBuilder builder){
      
      
        _init_prod__formal_Formal__hasVar_opt__lit_VAR_layouts_Layouts_params_iter_seps__Ident__layouts_Layouts_lit___44_layouts_Layouts_layouts_Layouts_lit___58_layouts_Layouts_type_Type_(builder);
      
    }
  }
	
  protected static class Module {
    public final static AbstractStackNode[] EXPECTS;
    static{
      ExpectBuilder builder = new ExpectBuilder(_resultStoreIdMappings);
      init(builder);
      EXPECTS = builder.buildExpectArray();
    }
    
    protected static final void _init_prod__mod_Module__lit_MODULE_layouts_Layouts_name_Ident_layouts_Layouts_lit___59_layouts_Layouts_decls_Declarations_layouts_Layouts_body_opt__Body_layouts_Layouts_lit_END_layouts_Layouts_Ident_layouts_Layouts_lit___46_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[15];
      
      tmp[14] = new LiteralStackNode(102, 14, prod__lit___46__char_class___range__46_46_, new int[] {46}, null, null);
      tmp[13] = new NonTerminalStackNode(100, 13, "layouts_Layouts", null, null);
      tmp[12] = new NonTerminalStackNode(98, 12, "Ident", null, null);
      tmp[11] = new NonTerminalStackNode(96, 11, "layouts_Layouts", null, null);
      tmp[10] = new LiteralStackNode(94, 10, prod__lit_END__char_class___range__69_69_char_class___range__78_78_char_class___range__68_68_, new int[] {69,78,68}, null, null);
      tmp[9] = new NonTerminalStackNode(92, 9, "layouts_Layouts", null, null);
      tmp[8] = new OptionalStackNode(88, 8, regular__opt__Body, new NonTerminalStackNode(90, 0, "Body", null, null), null, null);
      tmp[7] = new NonTerminalStackNode(86, 7, "layouts_Layouts", null, null);
      tmp[6] = new NonTerminalStackNode(84, 6, "Declarations", null, null);
      tmp[5] = new NonTerminalStackNode(82, 5, "layouts_Layouts", null, null);
      tmp[4] = new LiteralStackNode(80, 4, prod__lit___59__char_class___range__59_59_, new int[] {59}, null, null);
      tmp[3] = new NonTerminalStackNode(78, 3, "layouts_Layouts", null, null);
      tmp[2] = new NonTerminalStackNode(76, 2, "Ident", null, null);
      tmp[1] = new NonTerminalStackNode(74, 1, "layouts_Layouts", null, null);
      tmp[0] = new LiteralStackNode(72, 0, prod__lit_MODULE__char_class___range__77_77_char_class___range__79_79_char_class___range__68_68_char_class___range__85_85_char_class___range__76_76_char_class___range__69_69_, new int[] {77,79,68,85,76,69}, null, null);
      builder.addAlternative(Parser.prod__mod_Module__lit_MODULE_layouts_Layouts_name_Ident_layouts_Layouts_lit___59_layouts_Layouts_decls_Declarations_layouts_Layouts_body_opt__Body_layouts_Layouts_lit_END_layouts_Layouts_Ident_layouts_Layouts_lit___46_, tmp);
	}
    public static void init(ExpectBuilder builder){
      
      
        _init_prod__mod_Module__lit_MODULE_layouts_Layouts_name_Ident_layouts_Layouts_lit___59_layouts_Layouts_decls_Declarations_layouts_Layouts_body_opt__Body_layouts_Layouts_lit_END_layouts_Layouts_Ident_layouts_Layouts_lit___46_(builder);
      
    }
  }
	
  protected static class ConstDecl {
    public final static AbstractStackNode[] EXPECTS;
    static{
      ExpectBuilder builder = new ExpectBuilder(_resultStoreIdMappings);
      init(builder);
      EXPECTS = builder.buildExpectArray();
    }
    
    protected static final void _init_prod__constDecl_ConstDecl__name_Ident_layouts_Layouts_lit___61_layouts_Layouts_value_Expression_layouts_Layouts_lit___59_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[7];
      
      tmp[6] = new LiteralStackNode(116, 6, prod__lit___59__char_class___range__59_59_, new int[] {59}, null, null);
      tmp[5] = new NonTerminalStackNode(114, 5, "layouts_Layouts", null, null);
      tmp[4] = new NonTerminalStackNode(112, 4, "Expression", null, null);
      tmp[3] = new NonTerminalStackNode(110, 3, "layouts_Layouts", null, null);
      tmp[2] = new LiteralStackNode(108, 2, prod__lit___61__char_class___range__61_61_, new int[] {61}, null, null);
      tmp[1] = new NonTerminalStackNode(106, 1, "layouts_Layouts", null, null);
      tmp[0] = new NonTerminalStackNode(104, 0, "Ident", null, null);
      builder.addAlternative(Parser.prod__constDecl_ConstDecl__name_Ident_layouts_Layouts_lit___61_layouts_Layouts_value_Expression_layouts_Layouts_lit___59_, tmp);
	}
    public static void init(ExpectBuilder builder){
      
      
        _init_prod__constDecl_ConstDecl__name_Ident_layouts_Layouts_lit___61_layouts_Layouts_value_Expression_layouts_Layouts_lit___59_(builder);
      
    }
  }
	
  protected static class start__Module {
    public final static AbstractStackNode[] EXPECTS;
    static{
      ExpectBuilder builder = new ExpectBuilder(_resultStoreIdMappings);
      init(builder);
      EXPECTS = builder.buildExpectArray();
    }
    
    protected static final void _init_prod__start__Module__layouts_Layouts_top_Module_layouts_Layouts_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[3];
      
      tmp[2] = new NonTerminalStackNode(172, 2, "layouts_Layouts", null, null);
      tmp[1] = new NonTerminalStackNode(170, 1, "Module", null, null);
      tmp[0] = new NonTerminalStackNode(168, 0, "layouts_Layouts", null, null);
      builder.addAlternative(Parser.prod__start__Module__layouts_Layouts_top_Module_layouts_Layouts_, tmp);
	}
    public static void init(ExpectBuilder builder){
      
      
        _init_prod__start__Module__layouts_Layouts_top_Module_layouts_Layouts_(builder);
      
    }
  }
	
  protected static class ConstSect {
    public final static AbstractStackNode[] EXPECTS;
    static{
      ExpectBuilder builder = new ExpectBuilder(_resultStoreIdMappings);
      init(builder);
      EXPECTS = builder.buildExpectArray();
    }
    
    protected static final void _init_prod__ConstSect__lit_CONST_layouts_Layouts_consts_iter_star_seps__ConstDecl__layouts_Layouts_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[3];
      
      tmp[2] = new SeparatedListStackNode(182, 2, regular__iter_star_seps__ConstDecl__layouts_Layouts, new NonTerminalStackNode(184, 0, "ConstDecl", null, null), new AbstractStackNode[]{new NonTerminalStackNode(186, 1, "layouts_Layouts", null, null)}, false, null, null);
      tmp[1] = new NonTerminalStackNode(180, 1, "layouts_Layouts", null, null);
      tmp[0] = new LiteralStackNode(178, 0, prod__lit_CONST__char_class___range__67_67_char_class___range__79_79_char_class___range__78_78_char_class___range__83_83_char_class___range__84_84_, new int[] {67,79,78,83,84}, null, null);
      builder.addAlternative(Parser.prod__ConstSect__lit_CONST_layouts_Layouts_consts_iter_star_seps__ConstDecl__layouts_Layouts_, tmp);
	}
    public static void init(ExpectBuilder builder){
      
      
        _init_prod__ConstSect__lit_CONST_layouts_Layouts_consts_iter_star_seps__ConstDecl__layouts_Layouts_(builder);
      
    }
  }
	
  protected static class TypeDecl {
    public final static AbstractStackNode[] EXPECTS;
    static{
      ExpectBuilder builder = new ExpectBuilder(_resultStoreIdMappings);
      init(builder);
      EXPECTS = builder.buildExpectArray();
    }
    
    protected static final void _init_prod__typeDecl_TypeDecl__name_Ident_layouts_Layouts_lit___61_layouts_Layouts_type_Type_layouts_Layouts_lit___59_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[7];
      
      tmp[6] = new LiteralStackNode(200, 6, prod__lit___59__char_class___range__59_59_, new int[] {59}, null, null);
      tmp[5] = new NonTerminalStackNode(198, 5, "layouts_Layouts", null, null);
      tmp[4] = new NonTerminalStackNode(196, 4, "Type", null, null);
      tmp[3] = new NonTerminalStackNode(194, 3, "layouts_Layouts", null, null);
      tmp[2] = new LiteralStackNode(192, 2, prod__lit___61__char_class___range__61_61_, new int[] {61}, null, null);
      tmp[1] = new NonTerminalStackNode(190, 1, "layouts_Layouts", null, null);
      tmp[0] = new NonTerminalStackNode(188, 0, "Ident", null, null);
      builder.addAlternative(Parser.prod__typeDecl_TypeDecl__name_Ident_layouts_Layouts_lit___61_layouts_Layouts_type_Type_layouts_Layouts_lit___59_, tmp);
	}
    public static void init(ExpectBuilder builder){
      
      
        _init_prod__typeDecl_TypeDecl__name_Ident_layouts_Layouts_lit___61_layouts_Layouts_type_Type_layouts_Layouts_lit___59_(builder);
      
    }
  }
	
  protected static class Layout {
    public final static AbstractStackNode[] EXPECTS;
    static{
      ExpectBuilder builder = new ExpectBuilder(_resultStoreIdMappings);
      init(builder);
      EXPECTS = builder.buildExpectArray();
    }
    
    protected static final void _init_prod__whitespace_Layout__char_class___range__9_10_range__13_13_range__32_32_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new CharStackNode(208, 0, new int[][]{{9,10},{13,13},{32,32}}, null, null);
      builder.addAlternative(Parser.prod__whitespace_Layout__char_class___range__9_10_range__13_13_range__32_32_, tmp);
	}
    protected static final void _init_prod__Layout__Comment__tag__category___67_111_109_109_101_110_116(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new NonTerminalStackNode(210, 0, "Comment", null, null);
      builder.addAlternative(Parser.prod__Layout__Comment__tag__category___67_111_109_109_101_110_116, tmp);
	}
    public static void init(ExpectBuilder builder){
      
      
        _init_prod__whitespace_Layout__char_class___range__9_10_range__13_13_range__32_32_(builder);
      
        _init_prod__Layout__Comment__tag__category___67_111_109_109_101_110_116(builder);
      
    }
  }
	
  protected static class layouts_Layouts {
    public final static AbstractStackNode[] EXPECTS;
    static{
      ExpectBuilder builder = new ExpectBuilder(_resultStoreIdMappings);
      init(builder);
      EXPECTS = builder.buildExpectArray();
    }
    
    protected static final void _init_prod__layouts_Layouts__conditional__iter_star__Layout__not_follow__char_class___range__9_10_range__13_13_range__32_32_not_follow__lit___40_42_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new ListStackNode(228, 0, regular__iter_star__Layout, new NonTerminalStackNode(230, 0, "Layout", null, null), false, null, new ICompletionFilter[] {new CharFollowRestriction(new int[][]{{9,10},{13,13},{32,32}}), new StringFollowRestriction(new int[] {40,42})});
      builder.addAlternative(Parser.prod__layouts_Layouts__conditional__iter_star__Layout__not_follow__char_class___range__9_10_range__13_13_range__32_32_not_follow__lit___40_42_, tmp);
	}
    public static void init(ExpectBuilder builder){
      
      
        _init_prod__layouts_Layouts__conditional__iter_star__Layout__not_follow__char_class___range__9_10_range__13_13_range__32_32_not_follow__lit___40_42_(builder);
      
    }
  }
	
  protected static class TypeSect {
    public final static AbstractStackNode[] EXPECTS;
    static{
      ExpectBuilder builder = new ExpectBuilder(_resultStoreIdMappings);
      init(builder);
      EXPECTS = builder.buildExpectArray();
    }
    
    protected static final void _init_prod__TypeSect__lit_TYPE_layouts_Layouts_types_iter_star_seps__TypeDecl__layouts_Layouts_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[3];
      
      tmp[2] = new SeparatedListStackNode(250, 2, regular__iter_star_seps__TypeDecl__layouts_Layouts, new NonTerminalStackNode(252, 0, "TypeDecl", null, null), new AbstractStackNode[]{new NonTerminalStackNode(254, 1, "layouts_Layouts", null, null)}, false, null, null);
      tmp[1] = new NonTerminalStackNode(248, 1, "layouts_Layouts", null, null);
      tmp[0] = new LiteralStackNode(246, 0, prod__lit_TYPE__char_class___range__84_84_char_class___range__89_89_char_class___range__80_80_char_class___range__69_69_, new int[] {84,89,80,69}, null, null);
      builder.addAlternative(Parser.prod__TypeSect__lit_TYPE_layouts_Layouts_types_iter_star_seps__TypeDecl__layouts_Layouts_, tmp);
	}
    public static void init(ExpectBuilder builder){
      
      
        _init_prod__TypeSect__lit_TYPE_layouts_Layouts_types_iter_star_seps__TypeDecl__layouts_Layouts_(builder);
      
    }
  }
	
  protected static class Ident {
    public final static AbstractStackNode[] EXPECTS;
    static{
      ExpectBuilder builder = new ExpectBuilder(_resultStoreIdMappings);
      init(builder);
      EXPECTS = builder.buildExpectArray();
    }
    
    protected static final void _init_prod__id_Ident__conditional__seq___conditional__char_class___range__65_90_range__97_122__not_precede__char_class___range__65_90_range__97_122_conditional__iter_star__char_class___range__48_57_range__65_90_range__97_122__not_follow__char_class___range__48_57_range__65_90_range__97_122__delete__Keywords_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new SequenceStackNode(434, 0, regular__seq___conditional__char_class___range__65_90_range__97_122__not_precede__char_class___range__65_90_range__97_122_conditional__iter_star__char_class___range__48_57_range__65_90_range__97_122__not_follow__char_class___range__48_57_range__65_90_range__97_122, new AbstractStackNode[]{new CharStackNode(436, 0, new int[][]{{65,90},{97,122}}, new IEnterFilter[] {new CharPrecedeRestriction(new int[][]{{65,90},{97,122}})}, null), new ListStackNode(438, 1, regular__iter_star__char_class___range__48_57_range__65_90_range__97_122, new CharStackNode(440, 0, new int[][]{{48,57},{65,90},{97,122}}, null, null), false, null, new ICompletionFilter[] {new CharFollowRestriction(new int[][]{{48,57},{65,90},{97,122}})})}, null, new ICompletionFilter[] {new StringMatchRestriction(new int[] {86,65,82}), new StringMatchRestriction(new int[] {77,79,68}), new StringMatchRestriction(new int[] {79,82}), new StringMatchRestriction(new int[] {67,79,78,83,84}), new StringMatchRestriction(new int[] {77,79,68,85,76,69}), new StringMatchRestriction(new int[] {66,69,71,73,78}), new StringMatchRestriction(new int[] {70,79,82}), new StringMatchRestriction(new int[] {69,76,83,73,70}), new StringMatchRestriction(new int[] {68,79}), new StringMatchRestriction(new int[] {79,70}), new StringMatchRestriction(new int[] {66,89}), new StringMatchRestriction(new int[] {67,65,83,69}), new StringMatchRestriction(new int[] {68,73,86}), new StringMatchRestriction(new int[] {87,72,73,76,69}), new StringMatchRestriction(new int[] {80,82,79,67,69,68,85,82,69}), new StringMatchRestriction(new int[] {73,70}), new StringMatchRestriction(new int[] {84,72,69,78}), new StringMatchRestriction(new int[] {85,78,84,73,76}), new StringMatchRestriction(new int[] {69,76,83,69}), new StringMatchRestriction(new int[] {84,89,80,69}), new StringMatchRestriction(new int[] {84,79}), new StringMatchRestriction(new int[] {82,69,80,69,65,84}), new StringMatchRestriction(new int[] {69,78,68})});
      builder.addAlternative(Parser.prod__id_Ident__conditional__seq___conditional__char_class___range__65_90_range__97_122__not_precede__char_class___range__65_90_range__97_122_conditional__iter_star__char_class___range__48_57_range__65_90_range__97_122__not_follow__char_class___range__48_57_range__65_90_range__97_122__delete__Keywords_, tmp);
	}
    public static void init(ExpectBuilder builder){
      
      
        _init_prod__id_Ident__conditional__seq___conditional__char_class___range__65_90_range__97_122__not_precede__char_class___range__65_90_range__97_122_conditional__iter_star__char_class___range__48_57_range__65_90_range__97_122__not_follow__char_class___range__48_57_range__65_90_range__97_122__delete__Keywords_(builder);
      
    }
  }
	
  protected static class Expression {
    public final static AbstractStackNode[] EXPECTS;
    static{
      ExpectBuilder builder = new ExpectBuilder(_resultStoreIdMappings);
      init(builder);
      EXPECTS = builder.buildExpectArray();
    }
    
    protected static final void _init_prod__neq_Expression__lhs_Expression_layouts_Layouts_lit___35_layouts_Layouts_rhs_Expression__assoc__non_assoc(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[5];
      
      tmp[4] = new NonTerminalStackNode(410, 4, "Expression", null, null);
      tmp[3] = new NonTerminalStackNode(408, 3, "layouts_Layouts", null, null);
      tmp[2] = new LiteralStackNode(406, 2, prod__lit___35__char_class___range__35_35_, new int[] {35}, null, null);
      tmp[1] = new NonTerminalStackNode(404, 1, "layouts_Layouts", null, null);
      tmp[0] = new NonTerminalStackNode(402, 0, "Expression", null, null);
      builder.addAlternative(Parser.prod__neq_Expression__lhs_Expression_layouts_Layouts_lit___35_layouts_Layouts_rhs_Expression__assoc__non_assoc, tmp);
	}
    protected static final void _init_prod__lookup_Expression__var_Ident_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new NonTerminalStackNode(286, 0, "Ident", null, null);
      builder.addAlternative(Parser.prod__lookup_Expression__var_Ident_, tmp);
	}
    protected static final void _init_prod__or_Expression__lhs_Expression_layouts_Layouts_lit_OR_layouts_Layouts_rhs_Expression__assoc__left(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[5];
      
      tmp[0] = new NonTerminalStackNode(356, 0, "Expression", null, null);
      tmp[1] = new NonTerminalStackNode(358, 1, "layouts_Layouts", null, null);
      tmp[2] = new LiteralStackNode(360, 2, prod__lit_OR__char_class___range__79_79_char_class___range__82_82_, new int[] {79,82}, null, null);
      tmp[3] = new NonTerminalStackNode(362, 3, "layouts_Layouts", null, null);
      tmp[4] = new NonTerminalStackNode(364, 4, "Expression", null, null);
      builder.addAlternative(Parser.prod__or_Expression__lhs_Expression_layouts_Layouts_lit_OR_layouts_Layouts_rhs_Expression__assoc__left, tmp);
	}
    protected static final void _init_prod__div_Expression__lhs_Expression_layouts_Layouts_lit_DIV_layouts_Layouts_rhs_Expression__assoc__left(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[5];
      
      tmp[4] = new NonTerminalStackNode(318, 4, "Expression", null, null);
      tmp[3] = new NonTerminalStackNode(316, 3, "layouts_Layouts", null, null);
      tmp[2] = new LiteralStackNode(314, 2, prod__lit_DIV__char_class___range__68_68_char_class___range__73_73_char_class___range__86_86_, new int[] {68,73,86}, null, null);
      tmp[1] = new NonTerminalStackNode(312, 1, "layouts_Layouts", null, null);
      tmp[0] = new NonTerminalStackNode(310, 0, "Expression", null, null);
      builder.addAlternative(Parser.prod__div_Expression__lhs_Expression_layouts_Layouts_lit_DIV_layouts_Layouts_rhs_Expression__assoc__left, tmp);
	}
    protected static final void _init_prod__neg_Expression__lit___layouts_Layouts_exp_Expression__assoc__right(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[3];
      
      tmp[2] = new NonTerminalStackNode(354, 2, "Expression", null, null);
      tmp[1] = new NonTerminalStackNode(352, 1, "layouts_Layouts", null, null);
      tmp[0] = new LiteralStackNode(350, 0, prod__lit____char_class___range__45_45_, new int[] {45}, null, null);
      builder.addAlternative(Parser.prod__neg_Expression__lit___layouts_Layouts_exp_Expression__assoc__right, tmp);
	}
    protected static final void _init_prod__mod_Expression__lhs_Expression_layouts_Layouts_lit_MOD_layouts_Layouts_rhs_Expression__assoc__left(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[5];
      
      tmp[4] = new NonTerminalStackNode(328, 4, "Expression", null, null);
      tmp[3] = new NonTerminalStackNode(326, 3, "layouts_Layouts", null, null);
      tmp[2] = new LiteralStackNode(324, 2, prod__lit_MOD__char_class___range__77_77_char_class___range__79_79_char_class___range__68_68_, new int[] {77,79,68}, null, null);
      tmp[1] = new NonTerminalStackNode(322, 1, "layouts_Layouts", null, null);
      tmp[0] = new NonTerminalStackNode(320, 0, "Expression", null, null);
      builder.addAlternative(Parser.prod__mod_Expression__lhs_Expression_layouts_Layouts_lit_MOD_layouts_Layouts_rhs_Expression__assoc__left, tmp);
	}
    protected static final void _init_prod__pos_Expression__lit___43_layouts_Layouts_exp_Expression__assoc__right(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[3];
      
      tmp[2] = new NonTerminalStackNode(370, 2, "Expression", null, null);
      tmp[1] = new NonTerminalStackNode(368, 1, "layouts_Layouts", null, null);
      tmp[0] = new LiteralStackNode(366, 0, prod__lit___43__char_class___range__43_43_, new int[] {43}, null, null);
      builder.addAlternative(Parser.prod__pos_Expression__lit___43_layouts_Layouts_exp_Expression__assoc__right, tmp);
	}
    protected static final void _init_prod__nat_Expression__value_Natural_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new NonTerminalStackNode(288, 0, "Natural", null, null);
      builder.addAlternative(Parser.prod__nat_Expression__value_Natural_, tmp);
	}
    protected static final void _init_prod__not_Expression__lit___126_layouts_Layouts_exp_Expression_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[3];
      
      tmp[2] = new NonTerminalStackNode(274, 2, "Expression", null, null);
      tmp[1] = new NonTerminalStackNode(272, 1, "layouts_Layouts", null, null);
      tmp[0] = new LiteralStackNode(270, 0, prod__lit___126__char_class___range__126_126_, new int[] {126}, null, null);
      builder.addAlternative(Parser.prod__not_Expression__lit___126_layouts_Layouts_exp_Expression_, tmp);
	}
    protected static final void _init_prod__leq_Expression__lhs_Expression_layouts_Layouts_lit___60_61_layouts_Layouts_rhs_Expression__assoc__non_assoc(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[5];
      
      tmp[4] = new NonTerminalStackNode(380, 4, "Expression", null, null);
      tmp[3] = new NonTerminalStackNode(378, 3, "layouts_Layouts", null, null);
      tmp[2] = new LiteralStackNode(376, 2, prod__lit___60_61__char_class___range__60_60_char_class___range__61_61_, new int[] {60,61}, null, null);
      tmp[1] = new NonTerminalStackNode(374, 1, "layouts_Layouts", null, null);
      tmp[0] = new NonTerminalStackNode(372, 0, "Expression", null, null);
      builder.addAlternative(Parser.prod__leq_Expression__lhs_Expression_layouts_Layouts_lit___60_61_layouts_Layouts_rhs_Expression__assoc__non_assoc, tmp);
	}
    protected static final void _init_prod__sub_Expression__lhs_Expression_layouts_Layouts_lit___layouts_Layouts_rhs_Expression__assoc__left(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[5];
      
      tmp[4] = new NonTerminalStackNode(338, 4, "Expression", null, null);
      tmp[3] = new NonTerminalStackNode(336, 3, "layouts_Layouts", null, null);
      tmp[2] = new LiteralStackNode(334, 2, prod__lit____char_class___range__45_45_, new int[] {45}, null, null);
      tmp[1] = new NonTerminalStackNode(332, 1, "layouts_Layouts", null, null);
      tmp[0] = new NonTerminalStackNode(330, 0, "Expression", null, null);
      builder.addAlternative(Parser.prod__sub_Expression__lhs_Expression_layouts_Layouts_lit___layouts_Layouts_rhs_Expression__assoc__left, tmp);
	}
    protected static final void _init_prod__gt_Expression__lhs_Expression_layouts_Layouts_lit___62_layouts_Layouts_rhs_Expression__assoc__non_assoc(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[5];
      
      tmp[4] = new NonTerminalStackNode(390, 4, "Expression", null, null);
      tmp[3] = new NonTerminalStackNode(388, 3, "layouts_Layouts", null, null);
      tmp[2] = new LiteralStackNode(386, 2, prod__lit___62__char_class___range__62_62_, new int[] {62}, null, null);
      tmp[1] = new NonTerminalStackNode(384, 1, "layouts_Layouts", null, null);
      tmp[0] = new NonTerminalStackNode(382, 0, "Expression", null, null);
      builder.addAlternative(Parser.prod__gt_Expression__lhs_Expression_layouts_Layouts_lit___62_layouts_Layouts_rhs_Expression__assoc__non_assoc, tmp);
	}
    protected static final void _init_prod__eq_Expression__lhs_Expression_layouts_Layouts_lit___61_layouts_Layouts_rhs_Expression__assoc__non_assoc(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[5];
      
      tmp[4] = new NonTerminalStackNode(400, 4, "Expression", null, null);
      tmp[0] = new NonTerminalStackNode(392, 0, "Expression", null, null);
      tmp[1] = new NonTerminalStackNode(394, 1, "layouts_Layouts", null, null);
      tmp[2] = new LiteralStackNode(396, 2, prod__lit___61__char_class___range__61_61_, new int[] {61}, null, null);
      tmp[3] = new NonTerminalStackNode(398, 3, "layouts_Layouts", null, null);
      builder.addAlternative(Parser.prod__eq_Expression__lhs_Expression_layouts_Layouts_lit___61_layouts_Layouts_rhs_Expression__assoc__non_assoc, tmp);
	}
    protected static final void _init_prod__add_Expression__lhs_Expression_layouts_Layouts_lit___43_layouts_Layouts_rhs_Expression__assoc__left(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[5];
      
      tmp[4] = new NonTerminalStackNode(348, 4, "Expression", null, null);
      tmp[3] = new NonTerminalStackNode(346, 3, "layouts_Layouts", null, null);
      tmp[2] = new LiteralStackNode(344, 2, prod__lit___43__char_class___range__43_43_, new int[] {43}, null, null);
      tmp[1] = new NonTerminalStackNode(342, 1, "layouts_Layouts", null, null);
      tmp[0] = new NonTerminalStackNode(340, 0, "Expression", null, null);
      builder.addAlternative(Parser.prod__add_Expression__lhs_Expression_layouts_Layouts_lit___43_layouts_Layouts_rhs_Expression__assoc__left, tmp);
	}
    protected static final void _init_prod__Bracket_Expression__lit___40_layouts_Layouts_exp_Expression_layouts_Layouts_lit___41__bracket(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[5];
      
      tmp[4] = new LiteralStackNode(284, 4, prod__lit___41__char_class___range__41_41_, new int[] {41}, null, null);
      tmp[3] = new NonTerminalStackNode(282, 3, "layouts_Layouts", null, null);
      tmp[2] = new NonTerminalStackNode(280, 2, "Expression", null, null);
      tmp[1] = new NonTerminalStackNode(278, 1, "layouts_Layouts", null, null);
      tmp[0] = new LiteralStackNode(276, 0, prod__lit___40__char_class___range__40_40_, new int[] {40}, null, null);
      builder.addAlternative(Parser.prod__Bracket_Expression__lit___40_layouts_Layouts_exp_Expression_layouts_Layouts_lit___41__bracket, tmp);
	}
    protected static final void _init_prod__mul_Expression__lhs_Expression_layouts_Layouts_lit___42_layouts_Layouts_rhs_Expression__assoc__left(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[5];
      
      tmp[4] = new NonTerminalStackNode(298, 4, "Expression", null, null);
      tmp[3] = new NonTerminalStackNode(296, 3, "layouts_Layouts", null, null);
      tmp[2] = new LiteralStackNode(294, 2, prod__lit___42__char_class___range__42_42_, new int[] {42}, null, null);
      tmp[1] = new NonTerminalStackNode(292, 1, "layouts_Layouts", null, null);
      tmp[0] = new NonTerminalStackNode(290, 0, "Expression", null, null);
      builder.addAlternative(Parser.prod__mul_Expression__lhs_Expression_layouts_Layouts_lit___42_layouts_Layouts_rhs_Expression__assoc__left, tmp);
	}
    protected static final void _init_prod__lt_Expression__lhs_Expression_layouts_Layouts_lit___60_layouts_Layouts_rhs_Expression__assoc__non_assoc(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[5];
      
      tmp[4] = new NonTerminalStackNode(420, 4, "Expression", null, null);
      tmp[3] = new NonTerminalStackNode(418, 3, "layouts_Layouts", null, null);
      tmp[2] = new LiteralStackNode(416, 2, prod__lit___60__char_class___range__60_60_, new int[] {60}, null, null);
      tmp[1] = new NonTerminalStackNode(414, 1, "layouts_Layouts", null, null);
      tmp[0] = new NonTerminalStackNode(412, 0, "Expression", null, null);
      builder.addAlternative(Parser.prod__lt_Expression__lhs_Expression_layouts_Layouts_lit___60_layouts_Layouts_rhs_Expression__assoc__non_assoc, tmp);
	}
    protected static final void _init_prod__amp_Expression__lhs_Expression_layouts_Layouts_lit___38_layouts_Layouts_rhs_Expression__assoc__left(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[5];
      
      tmp[4] = new NonTerminalStackNode(308, 4, "Expression", null, null);
      tmp[3] = new NonTerminalStackNode(306, 3, "layouts_Layouts", null, null);
      tmp[2] = new LiteralStackNode(304, 2, prod__lit___38__char_class___range__38_38_, new int[] {38}, null, null);
      tmp[0] = new NonTerminalStackNode(300, 0, "Expression", null, null);
      tmp[1] = new NonTerminalStackNode(302, 1, "layouts_Layouts", null, null);
      builder.addAlternative(Parser.prod__amp_Expression__lhs_Expression_layouts_Layouts_lit___38_layouts_Layouts_rhs_Expression__assoc__left, tmp);
	}
    protected static final void _init_prod__geq_Expression__lhs_Expression_layouts_Layouts_lit___62_61_layouts_Layouts_rhs_Expression__assoc__non_assoc(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[5];
      
      tmp[4] = new NonTerminalStackNode(430, 4, "Expression", null, null);
      tmp[3] = new NonTerminalStackNode(428, 3, "layouts_Layouts", null, null);
      tmp[2] = new LiteralStackNode(426, 2, prod__lit___62_61__char_class___range__62_62_char_class___range__61_61_, new int[] {62,61}, null, null);
      tmp[1] = new NonTerminalStackNode(424, 1, "layouts_Layouts", null, null);
      tmp[0] = new NonTerminalStackNode(422, 0, "Expression", null, null);
      builder.addAlternative(Parser.prod__geq_Expression__lhs_Expression_layouts_Layouts_lit___62_61_layouts_Layouts_rhs_Expression__assoc__non_assoc, tmp);
	}
    public static void init(ExpectBuilder builder){
      
      
        _init_prod__neq_Expression__lhs_Expression_layouts_Layouts_lit___35_layouts_Layouts_rhs_Expression__assoc__non_assoc(builder);
      
        _init_prod__lookup_Expression__var_Ident_(builder);
      
        _init_prod__or_Expression__lhs_Expression_layouts_Layouts_lit_OR_layouts_Layouts_rhs_Expression__assoc__left(builder);
      
        _init_prod__div_Expression__lhs_Expression_layouts_Layouts_lit_DIV_layouts_Layouts_rhs_Expression__assoc__left(builder);
      
        _init_prod__neg_Expression__lit___layouts_Layouts_exp_Expression__assoc__right(builder);
      
        _init_prod__mod_Expression__lhs_Expression_layouts_Layouts_lit_MOD_layouts_Layouts_rhs_Expression__assoc__left(builder);
      
        _init_prod__pos_Expression__lit___43_layouts_Layouts_exp_Expression__assoc__right(builder);
      
        _init_prod__nat_Expression__value_Natural_(builder);
      
        _init_prod__not_Expression__lit___126_layouts_Layouts_exp_Expression_(builder);
      
        _init_prod__leq_Expression__lhs_Expression_layouts_Layouts_lit___60_61_layouts_Layouts_rhs_Expression__assoc__non_assoc(builder);
      
        _init_prod__sub_Expression__lhs_Expression_layouts_Layouts_lit___layouts_Layouts_rhs_Expression__assoc__left(builder);
      
        _init_prod__gt_Expression__lhs_Expression_layouts_Layouts_lit___62_layouts_Layouts_rhs_Expression__assoc__non_assoc(builder);
      
        _init_prod__eq_Expression__lhs_Expression_layouts_Layouts_lit___61_layouts_Layouts_rhs_Expression__assoc__non_assoc(builder);
      
        _init_prod__add_Expression__lhs_Expression_layouts_Layouts_lit___43_layouts_Layouts_rhs_Expression__assoc__left(builder);
      
        _init_prod__Bracket_Expression__lit___40_layouts_Layouts_exp_Expression_layouts_Layouts_lit___41__bracket(builder);
      
        _init_prod__mul_Expression__lhs_Expression_layouts_Layouts_lit___42_layouts_Layouts_rhs_Expression__assoc__left(builder);
      
        _init_prod__lt_Expression__lhs_Expression_layouts_Layouts_lit___60_layouts_Layouts_rhs_Expression__assoc__non_assoc(builder);
      
        _init_prod__amp_Expression__lhs_Expression_layouts_Layouts_lit___38_layouts_Layouts_rhs_Expression__assoc__left(builder);
      
        _init_prod__geq_Expression__lhs_Expression_layouts_Layouts_lit___62_61_layouts_Layouts_rhs_Expression__assoc__non_assoc(builder);
      
    }
  }
	
  protected static class layouts_$QUOTES {
    public final static AbstractStackNode[] EXPECTS;
    static{
      ExpectBuilder builder = new ExpectBuilder(_resultStoreIdMappings);
      init(builder);
      EXPECTS = builder.buildExpectArray();
    }
    
    protected static final void _init_prod__layouts_$QUOTES__conditional__iter_star__char_class___range__9_10_range__13_13_range__32_32__not_follow__char_class___range__9_10_range__13_13_range__32_32_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new ListStackNode(460, 0, regular__iter_star__char_class___range__9_10_range__13_13_range__32_32, new CharStackNode(462, 0, new int[][]{{9,10},{13,13},{32,32}}, null, null), false, null, new ICompletionFilter[] {new CharFollowRestriction(new int[][]{{9,10},{13,13},{32,32}})});
      builder.addAlternative(Parser.prod__layouts_$QUOTES__conditional__iter_star__char_class___range__9_10_range__13_13_range__32_32__not_follow__char_class___range__9_10_range__13_13_range__32_32_, tmp);
	}
    public static void init(ExpectBuilder builder){
      
      
        _init_prod__layouts_$QUOTES__conditional__iter_star__char_class___range__9_10_range__13_13_range__32_32__not_follow__char_class___range__9_10_range__13_13_range__32_32_(builder);
      
    }
  }
	
  protected static class Formals {
    public final static AbstractStackNode[] EXPECTS;
    static{
      ExpectBuilder builder = new ExpectBuilder(_resultStoreIdMappings);
      init(builder);
      EXPECTS = builder.buildExpectArray();
    }
    
    protected static final void _init_prod__Formals__lit___40_layouts_Layouts_formals_iter_star_seps__Formal__layouts_Layouts_lit___59_layouts_Layouts_layouts_Layouts_lit___41_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[5];
      
      tmp[4] = new LiteralStackNode(458, 4, prod__lit___41__char_class___range__41_41_, new int[] {41}, null, null);
      tmp[3] = new NonTerminalStackNode(456, 3, "layouts_Layouts", null, null);
      tmp[2] = new SeparatedListStackNode(446, 2, regular__iter_star_seps__Formal__layouts_Layouts_lit___59_layouts_Layouts, new NonTerminalStackNode(448, 0, "Formal", null, null), new AbstractStackNode[]{new NonTerminalStackNode(450, 1, "layouts_Layouts", null, null), new LiteralStackNode(452, 2, prod__lit___59__char_class___range__59_59_, new int[] {59}, null, null), new NonTerminalStackNode(454, 3, "layouts_Layouts", null, null)}, false, null, null);
      tmp[1] = new NonTerminalStackNode(444, 1, "layouts_Layouts", null, null);
      tmp[0] = new LiteralStackNode(442, 0, prod__lit___40__char_class___range__40_40_, new int[] {40}, null, null);
      builder.addAlternative(Parser.prod__Formals__lit___40_layouts_Layouts_formals_iter_star_seps__Formal__layouts_Layouts_lit___59_layouts_Layouts_layouts_Layouts_lit___41_, tmp);
	}
    public static void init(ExpectBuilder builder){
      
      
        _init_prod__Formals__lit___40_layouts_Layouts_formals_iter_star_seps__Formal__layouts_Layouts_lit___59_layouts_Layouts_layouts_Layouts_lit___41_(builder);
      
    }
  }
	
  protected static class Body {
    public final static AbstractStackNode[] EXPECTS;
    static{
      ExpectBuilder builder = new ExpectBuilder(_resultStoreIdMappings);
      init(builder);
      EXPECTS = builder.buildExpectArray();
    }
    
    protected static final void _init_prod__Body__lit_BEGIN_layouts_Layouts_iter_seps__Statement__layouts_Layouts_lit___59_layouts_Layouts__tag__Foldable(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[3];
      
      tmp[2] = new SeparatedListStackNode(486, 2, regular__iter_seps__Statement__layouts_Layouts_lit___59_layouts_Layouts, new NonTerminalStackNode(488, 0, "Statement", null, null), new AbstractStackNode[]{new NonTerminalStackNode(490, 1, "layouts_Layouts", null, null), new LiteralStackNode(492, 2, prod__lit___59__char_class___range__59_59_, new int[] {59}, null, null), new NonTerminalStackNode(494, 3, "layouts_Layouts", null, null)}, true, null, null);
      tmp[1] = new NonTerminalStackNode(484, 1, "layouts_Layouts", null, null);
      tmp[0] = new LiteralStackNode(482, 0, prod__lit_BEGIN__char_class___range__66_66_char_class___range__69_69_char_class___range__71_71_char_class___range__73_73_char_class___range__78_78_, new int[] {66,69,71,73,78}, null, null);
      builder.addAlternative(Parser.prod__Body__lit_BEGIN_layouts_Layouts_iter_seps__Statement__layouts_Layouts_lit___59_layouts_Layouts__tag__Foldable, tmp);
	}
    public static void init(ExpectBuilder builder){
      
      
        _init_prod__Body__lit_BEGIN_layouts_Layouts_iter_seps__Statement__layouts_Layouts_lit___59_layouts_Layouts__tag__Foldable(builder);
      
    }
  }
	
  protected static class Statement {
    public final static AbstractStackNode[] EXPECTS;
    static{
      ExpectBuilder builder = new ExpectBuilder(_resultStoreIdMappings);
      init(builder);
      EXPECTS = builder.buildExpectArray();
    }
    
    protected static final void _init_prod__assign_Statement__var_Ident_layouts_Layouts_lit___58_61_layouts_Layouts_exp_Expression_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[5];
      
      tmp[4] = new NonTerminalStackNode(518, 4, "Expression", null, null);
      tmp[3] = new NonTerminalStackNode(516, 3, "layouts_Layouts", null, null);
      tmp[2] = new LiteralStackNode(514, 2, prod__lit___58_61__char_class___range__58_58_char_class___range__61_61_, new int[] {58,61}, null, null);
      tmp[1] = new NonTerminalStackNode(512, 1, "layouts_Layouts", null, null);
      tmp[0] = new NonTerminalStackNode(510, 0, "Ident", null, null);
      builder.addAlternative(Parser.prod__assign_Statement__var_Ident_layouts_Layouts_lit___58_61_layouts_Layouts_exp_Expression_, tmp);
	}
    protected static final void _init_prod__skip_Statement__(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new EpsilonStackNode(552, 0);
      builder.addAlternative(Parser.prod__skip_Statement__, tmp);
	}
    protected static final void _init_prod__caseOf_Statement__lit_CASE_layouts_Layouts_exp_Expression_layouts_Layouts_lit_OF_layouts_Layouts_cases_iter_seps__Case__layouts_Layouts_lit___124_layouts_Layouts_layouts_Layouts_elsePart_opt__ElsePart_layouts_Layouts_lit_END_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[11];
      
      tmp[10] = new LiteralStackNode(550, 10, prod__lit_END__char_class___range__69_69_char_class___range__78_78_char_class___range__68_68_, new int[] {69,78,68}, null, null);
      tmp[9] = new NonTerminalStackNode(548, 9, "layouts_Layouts", null, null);
      tmp[8] = new OptionalStackNode(544, 8, regular__opt__ElsePart, new NonTerminalStackNode(546, 0, "ElsePart", null, null), null, null);
      tmp[7] = new NonTerminalStackNode(542, 7, "layouts_Layouts", null, null);
      tmp[6] = new SeparatedListStackNode(532, 6, regular__iter_seps__Case__layouts_Layouts_lit___124_layouts_Layouts, new NonTerminalStackNode(534, 0, "Case", null, null), new AbstractStackNode[]{new NonTerminalStackNode(536, 1, "layouts_Layouts", null, null), new LiteralStackNode(538, 2, prod__lit___124__char_class___range__124_124_, new int[] {124}, null, null), new NonTerminalStackNode(540, 3, "layouts_Layouts", null, null)}, true, null, null);
      tmp[5] = new NonTerminalStackNode(530, 5, "layouts_Layouts", null, null);
      tmp[4] = new LiteralStackNode(528, 4, prod__lit_OF__char_class___range__79_79_char_class___range__70_70_, new int[] {79,70}, null, null);
      tmp[3] = new NonTerminalStackNode(526, 3, "layouts_Layouts", null, null);
      tmp[2] = new NonTerminalStackNode(524, 2, "Expression", null, null);
      tmp[1] = new NonTerminalStackNode(522, 1, "layouts_Layouts", null, null);
      tmp[0] = new LiteralStackNode(520, 0, prod__lit_CASE__char_class___range__67_67_char_class___range__65_65_char_class___range__83_83_char_class___range__69_69_, new int[] {67,65,83,69}, null, null);
      builder.addAlternative(Parser.prod__caseOf_Statement__lit_CASE_layouts_Layouts_exp_Expression_layouts_Layouts_lit_OF_layouts_Layouts_cases_iter_seps__Case__layouts_Layouts_lit___124_layouts_Layouts_layouts_Layouts_elsePart_opt__ElsePart_layouts_Layouts_lit_END_, tmp);
	}
    protected static final void _init_prod__forDo_Statement__lit_FOR_layouts_Layouts_name_Ident_layouts_Layouts_lit___58_61_layouts_Layouts_from_Expression_layouts_Layouts_lit_TO_layouts_Layouts_to_Expression_layouts_Layouts_opt__seq___lit_BY_layouts_Layouts_Expression_layouts_Layouts_lit_DO_layouts_Layouts_body_iter_seps__Statement__layouts_Layouts_lit___59_layouts_Layouts_layouts_Layouts_lit_END_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[19];
      
      tmp[18] = new LiteralStackNode(606, 18, prod__lit_END__char_class___range__69_69_char_class___range__78_78_char_class___range__68_68_, new int[] {69,78,68}, null, null);
      tmp[17] = new NonTerminalStackNode(604, 17, "layouts_Layouts", null, null);
      tmp[16] = new SeparatedListStackNode(594, 16, regular__iter_seps__Statement__layouts_Layouts_lit___59_layouts_Layouts, new NonTerminalStackNode(596, 0, "Statement", null, null), new AbstractStackNode[]{new NonTerminalStackNode(598, 1, "layouts_Layouts", null, null), new LiteralStackNode(600, 2, prod__lit___59__char_class___range__59_59_, new int[] {59}, null, null), new NonTerminalStackNode(602, 3, "layouts_Layouts", null, null)}, true, null, null);
      tmp[15] = new NonTerminalStackNode(592, 15, "layouts_Layouts", null, null);
      tmp[14] = new LiteralStackNode(590, 14, prod__lit_DO__char_class___range__68_68_char_class___range__79_79_, new int[] {68,79}, null, null);
      tmp[13] = new NonTerminalStackNode(588, 13, "layouts_Layouts", null, null);
      tmp[12] = new OptionalStackNode(578, 12, regular__opt__seq___lit_BY_layouts_Layouts_Expression, new SequenceStackNode(580, 0, regular__seq___lit_BY_layouts_Layouts_Expression, new AbstractStackNode[]{new LiteralStackNode(582, 0, prod__lit_BY__char_class___range__66_66_char_class___range__89_89_, new int[] {66,89}, null, null), new NonTerminalStackNode(584, 1, "layouts_Layouts", null, null), new NonTerminalStackNode(586, 2, "Expression", null, null)}, null, null), null, null);
      tmp[11] = new NonTerminalStackNode(576, 11, "layouts_Layouts", null, null);
      tmp[10] = new NonTerminalStackNode(574, 10, "Expression", null, null);
      tmp[9] = new NonTerminalStackNode(572, 9, "layouts_Layouts", null, null);
      tmp[8] = new LiteralStackNode(570, 8, prod__lit_TO__char_class___range__84_84_char_class___range__79_79_, new int[] {84,79}, null, null);
      tmp[7] = new NonTerminalStackNode(568, 7, "layouts_Layouts", null, null);
      tmp[6] = new NonTerminalStackNode(566, 6, "Expression", null, null);
      tmp[5] = new NonTerminalStackNode(564, 5, "layouts_Layouts", null, null);
      tmp[4] = new LiteralStackNode(562, 4, prod__lit___58_61__char_class___range__58_58_char_class___range__61_61_, new int[] {58,61}, null, null);
      tmp[3] = new NonTerminalStackNode(560, 3, "layouts_Layouts", null, null);
      tmp[2] = new NonTerminalStackNode(558, 2, "Ident", null, null);
      tmp[1] = new NonTerminalStackNode(556, 1, "layouts_Layouts", null, null);
      tmp[0] = new LiteralStackNode(554, 0, prod__lit_FOR__char_class___range__70_70_char_class___range__79_79_char_class___range__82_82_, new int[] {70,79,82}, null, null);
      builder.addAlternative(Parser.prod__forDo_Statement__lit_FOR_layouts_Layouts_name_Ident_layouts_Layouts_lit___58_61_layouts_Layouts_from_Expression_layouts_Layouts_lit_TO_layouts_Layouts_to_Expression_layouts_Layouts_opt__seq___lit_BY_layouts_Layouts_Expression_layouts_Layouts_lit_DO_layouts_Layouts_body_iter_seps__Statement__layouts_Layouts_lit___59_layouts_Layouts_layouts_Layouts_lit_END_, tmp);
	}
    protected static final void _init_prod__call_Statement__name_Ident_layouts_Layouts_actuals_opt__Actuals_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[3];
      
      tmp[2] = new OptionalStackNode(612, 2, regular__opt__Actuals, new NonTerminalStackNode(614, 0, "Actuals", null, null), null, null);
      tmp[1] = new NonTerminalStackNode(610, 1, "layouts_Layouts", null, null);
      tmp[0] = new NonTerminalStackNode(608, 0, "Ident", null, null);
      builder.addAlternative(Parser.prod__call_Statement__name_Ident_layouts_Layouts_actuals_opt__Actuals_, tmp);
	}
    protected static final void _init_prod__whileDo_Statement__lit_WHILE_layouts_Layouts_condition_Expression_layouts_Layouts_lit_DO_layouts_Layouts_body_iter_seps__Statement__layouts_Layouts_lit___59_layouts_Layouts_layouts_Layouts_lit_END_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[9];
      
      tmp[8] = new LiteralStackNode(640, 8, prod__lit_END__char_class___range__69_69_char_class___range__78_78_char_class___range__68_68_, new int[] {69,78,68}, null, null);
      tmp[7] = new NonTerminalStackNode(638, 7, "layouts_Layouts", null, null);
      tmp[6] = new SeparatedListStackNode(628, 6, regular__iter_seps__Statement__layouts_Layouts_lit___59_layouts_Layouts, new NonTerminalStackNode(630, 0, "Statement", null, null), new AbstractStackNode[]{new NonTerminalStackNode(632, 1, "layouts_Layouts", null, null), new LiteralStackNode(634, 2, prod__lit___59__char_class___range__59_59_, new int[] {59}, null, null), new NonTerminalStackNode(636, 3, "layouts_Layouts", null, null)}, true, null, null);
      tmp[5] = new NonTerminalStackNode(626, 5, "layouts_Layouts", null, null);
      tmp[4] = new LiteralStackNode(624, 4, prod__lit_DO__char_class___range__68_68_char_class___range__79_79_, new int[] {68,79}, null, null);
      tmp[3] = new NonTerminalStackNode(622, 3, "layouts_Layouts", null, null);
      tmp[2] = new NonTerminalStackNode(620, 2, "Expression", null, null);
      tmp[1] = new NonTerminalStackNode(618, 1, "layouts_Layouts", null, null);
      tmp[0] = new LiteralStackNode(616, 0, prod__lit_WHILE__char_class___range__87_87_char_class___range__72_72_char_class___range__73_73_char_class___range__76_76_char_class___range__69_69_, new int[] {87,72,73,76,69}, null, null);
      builder.addAlternative(Parser.prod__whileDo_Statement__lit_WHILE_layouts_Layouts_condition_Expression_layouts_Layouts_lit_DO_layouts_Layouts_body_iter_seps__Statement__layouts_Layouts_lit___59_layouts_Layouts_layouts_Layouts_lit_END_, tmp);
	}
    protected static final void _init_prod__ifThen_Statement__lit_IF_layouts_Layouts_condition_Expression_layouts_Layouts_lit_THEN_layouts_Layouts_body_iter_seps__Statement__layouts_Layouts_lit___59_layouts_Layouts_layouts_Layouts_iter_star_seps__ElsIfPart__layouts_Layouts_layouts_Layouts_opt__ElsePart_layouts_Layouts_lit_END_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[13];
      
      tmp[12] = new LiteralStackNode(680, 12, prod__lit_END__char_class___range__69_69_char_class___range__78_78_char_class___range__68_68_, new int[] {69,78,68}, null, null);
      tmp[11] = new NonTerminalStackNode(678, 11, "layouts_Layouts", null, null);
      tmp[10] = new OptionalStackNode(674, 10, regular__opt__ElsePart, new NonTerminalStackNode(676, 0, "ElsePart", null, null), null, null);
      tmp[9] = new NonTerminalStackNode(672, 9, "layouts_Layouts", null, null);
      tmp[8] = new SeparatedListStackNode(666, 8, regular__iter_star_seps__ElsIfPart__layouts_Layouts, new NonTerminalStackNode(668, 0, "ElsIfPart", null, null), new AbstractStackNode[]{new NonTerminalStackNode(670, 1, "layouts_Layouts", null, null)}, false, null, null);
      tmp[7] = new NonTerminalStackNode(664, 7, "layouts_Layouts", null, null);
      tmp[6] = new SeparatedListStackNode(654, 6, regular__iter_seps__Statement__layouts_Layouts_lit___59_layouts_Layouts, new NonTerminalStackNode(656, 0, "Statement", null, null), new AbstractStackNode[]{new NonTerminalStackNode(658, 1, "layouts_Layouts", null, null), new LiteralStackNode(660, 2, prod__lit___59__char_class___range__59_59_, new int[] {59}, null, null), new NonTerminalStackNode(662, 3, "layouts_Layouts", null, null)}, true, null, null);
      tmp[5] = new NonTerminalStackNode(652, 5, "layouts_Layouts", null, null);
      tmp[4] = new LiteralStackNode(650, 4, prod__lit_THEN__char_class___range__84_84_char_class___range__72_72_char_class___range__69_69_char_class___range__78_78_, new int[] {84,72,69,78}, null, null);
      tmp[3] = new NonTerminalStackNode(648, 3, "layouts_Layouts", null, null);
      tmp[2] = new NonTerminalStackNode(646, 2, "Expression", null, null);
      tmp[1] = new NonTerminalStackNode(644, 1, "layouts_Layouts", null, null);
      tmp[0] = new LiteralStackNode(642, 0, prod__lit_IF__char_class___range__73_73_char_class___range__70_70_, new int[] {73,70}, null, null);
      builder.addAlternative(Parser.prod__ifThen_Statement__lit_IF_layouts_Layouts_condition_Expression_layouts_Layouts_lit_THEN_layouts_Layouts_body_iter_seps__Statement__layouts_Layouts_lit___59_layouts_Layouts_layouts_Layouts_iter_star_seps__ElsIfPart__layouts_Layouts_layouts_Layouts_opt__ElsePart_layouts_Layouts_lit_END_, tmp);
	}
    public static void init(ExpectBuilder builder){
      
      
        _init_prod__assign_Statement__var_Ident_layouts_Layouts_lit___58_61_layouts_Layouts_exp_Expression_(builder);
      
        _init_prod__skip_Statement__(builder);
      
        _init_prod__caseOf_Statement__lit_CASE_layouts_Layouts_exp_Expression_layouts_Layouts_lit_OF_layouts_Layouts_cases_iter_seps__Case__layouts_Layouts_lit___124_layouts_Layouts_layouts_Layouts_elsePart_opt__ElsePart_layouts_Layouts_lit_END_(builder);
      
        _init_prod__forDo_Statement__lit_FOR_layouts_Layouts_name_Ident_layouts_Layouts_lit___58_61_layouts_Layouts_from_Expression_layouts_Layouts_lit_TO_layouts_Layouts_to_Expression_layouts_Layouts_opt__seq___lit_BY_layouts_Layouts_Expression_layouts_Layouts_lit_DO_layouts_Layouts_body_iter_seps__Statement__layouts_Layouts_lit___59_layouts_Layouts_layouts_Layouts_lit_END_(builder);
      
        _init_prod__call_Statement__name_Ident_layouts_Layouts_actuals_opt__Actuals_(builder);
      
        _init_prod__whileDo_Statement__lit_WHILE_layouts_Layouts_condition_Expression_layouts_Layouts_lit_DO_layouts_Layouts_body_iter_seps__Statement__layouts_Layouts_lit___59_layouts_Layouts_layouts_Layouts_lit_END_(builder);
      
        _init_prod__ifThen_Statement__lit_IF_layouts_Layouts_condition_Expression_layouts_Layouts_lit_THEN_layouts_Layouts_body_iter_seps__Statement__layouts_Layouts_lit___59_layouts_Layouts_layouts_Layouts_iter_star_seps__ElsIfPart__layouts_Layouts_layouts_Layouts_opt__ElsePart_layouts_Layouts_lit_END_(builder);
      
    }
  }
	
  protected static class Keywords {
    public final static AbstractStackNode[] EXPECTS;
    static{
      ExpectBuilder builder = new ExpectBuilder(_resultStoreIdMappings);
      init(builder);
      EXPECTS = builder.buildExpectArray();
    }
    
    protected static final void _init_prod__Keywords__lit_BY_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new LiteralStackNode(682, 0, prod__lit_BY__char_class___range__66_66_char_class___range__89_89_, new int[] {66,89}, null, null);
      builder.addAlternative(Parser.prod__Keywords__lit_BY_, tmp);
	}
    protected static final void _init_prod__Keywords__lit_DIV_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new LiteralStackNode(684, 0, prod__lit_DIV__char_class___range__68_68_char_class___range__73_73_char_class___range__86_86_, new int[] {68,73,86}, null, null);
      builder.addAlternative(Parser.prod__Keywords__lit_DIV_, tmp);
	}
    protected static final void _init_prod__Keywords__lit_DO_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new LiteralStackNode(686, 0, prod__lit_DO__char_class___range__68_68_char_class___range__79_79_, new int[] {68,79}, null, null);
      builder.addAlternative(Parser.prod__Keywords__lit_DO_, tmp);
	}
    protected static final void _init_prod__Keywords__lit_BEGIN_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new LiteralStackNode(688, 0, prod__lit_BEGIN__char_class___range__66_66_char_class___range__69_69_char_class___range__71_71_char_class___range__73_73_char_class___range__78_78_, new int[] {66,69,71,73,78}, null, null);
      builder.addAlternative(Parser.prod__Keywords__lit_BEGIN_, tmp);
	}
    protected static final void _init_prod__Keywords__lit_END_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new LiteralStackNode(690, 0, prod__lit_END__char_class___range__69_69_char_class___range__78_78_char_class___range__68_68_, new int[] {69,78,68}, null, null);
      builder.addAlternative(Parser.prod__Keywords__lit_END_, tmp);
	}
    protected static final void _init_prod__Keywords__lit_FOR_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new LiteralStackNode(692, 0, prod__lit_FOR__char_class___range__70_70_char_class___range__79_79_char_class___range__82_82_, new int[] {70,79,82}, null, null);
      builder.addAlternative(Parser.prod__Keywords__lit_FOR_, tmp);
	}
    protected static final void _init_prod__Keywords__lit_IF_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new LiteralStackNode(694, 0, prod__lit_IF__char_class___range__73_73_char_class___range__70_70_, new int[] {73,70}, null, null);
      builder.addAlternative(Parser.prod__Keywords__lit_IF_, tmp);
	}
    protected static final void _init_prod__Keywords__lit_ELSE_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new LiteralStackNode(696, 0, prod__lit_ELSE__char_class___range__69_69_char_class___range__76_76_char_class___range__83_83_char_class___range__69_69_, new int[] {69,76,83,69}, null, null);
      builder.addAlternative(Parser.prod__Keywords__lit_ELSE_, tmp);
	}
    protected static final void _init_prod__Keywords__lit_REPEAT_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new LiteralStackNode(698, 0, prod__lit_REPEAT__char_class___range__82_82_char_class___range__69_69_char_class___range__80_80_char_class___range__69_69_char_class___range__65_65_char_class___range__84_84_, new int[] {82,69,80,69,65,84}, null, null);
      builder.addAlternative(Parser.prod__Keywords__lit_REPEAT_, tmp);
	}
    protected static final void _init_prod__Keywords__lit_OF_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new LiteralStackNode(700, 0, prod__lit_OF__char_class___range__79_79_char_class___range__70_70_, new int[] {79,70}, null, null);
      builder.addAlternative(Parser.prod__Keywords__lit_OF_, tmp);
	}
    protected static final void _init_prod__Keywords__lit_OR_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new LiteralStackNode(702, 0, prod__lit_OR__char_class___range__79_79_char_class___range__82_82_, new int[] {79,82}, null, null);
      builder.addAlternative(Parser.prod__Keywords__lit_OR_, tmp);
	}
    protected static final void _init_prod__Keywords__lit_THEN_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new LiteralStackNode(704, 0, prod__lit_THEN__char_class___range__84_84_char_class___range__72_72_char_class___range__69_69_char_class___range__78_78_, new int[] {84,72,69,78}, null, null);
      builder.addAlternative(Parser.prod__Keywords__lit_THEN_, tmp);
	}
    protected static final void _init_prod__Keywords__lit_MODULE_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new LiteralStackNode(706, 0, prod__lit_MODULE__char_class___range__77_77_char_class___range__79_79_char_class___range__68_68_char_class___range__85_85_char_class___range__76_76_char_class___range__69_69_, new int[] {77,79,68,85,76,69}, null, null);
      builder.addAlternative(Parser.prod__Keywords__lit_MODULE_, tmp);
	}
    protected static final void _init_prod__Keywords__lit_TO_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new LiteralStackNode(708, 0, prod__lit_TO__char_class___range__84_84_char_class___range__79_79_, new int[] {84,79}, null, null);
      builder.addAlternative(Parser.prod__Keywords__lit_TO_, tmp);
	}
    protected static final void _init_prod__Keywords__lit_ELSIF_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new LiteralStackNode(710, 0, prod__lit_ELSIF__char_class___range__69_69_char_class___range__76_76_char_class___range__83_83_char_class___range__73_73_char_class___range__70_70_, new int[] {69,76,83,73,70}, null, null);
      builder.addAlternative(Parser.prod__Keywords__lit_ELSIF_, tmp);
	}
    protected static final void _init_prod__Keywords__lit_PROCEDURE_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new LiteralStackNode(712, 0, prod__lit_PROCEDURE__char_class___range__80_80_char_class___range__82_82_char_class___range__79_79_char_class___range__67_67_char_class___range__69_69_char_class___range__68_68_char_class___range__85_85_char_class___range__82_82_char_class___range__69_69_, new int[] {80,82,79,67,69,68,85,82,69}, null, null);
      builder.addAlternative(Parser.prod__Keywords__lit_PROCEDURE_, tmp);
	}
    protected static final void _init_prod__Keywords__lit_MOD_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new LiteralStackNode(714, 0, prod__lit_MOD__char_class___range__77_77_char_class___range__79_79_char_class___range__68_68_, new int[] {77,79,68}, null, null);
      builder.addAlternative(Parser.prod__Keywords__lit_MOD_, tmp);
	}
    protected static final void _init_prod__Keywords__lit_WHILE_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new LiteralStackNode(716, 0, prod__lit_WHILE__char_class___range__87_87_char_class___range__72_72_char_class___range__73_73_char_class___range__76_76_char_class___range__69_69_, new int[] {87,72,73,76,69}, null, null);
      builder.addAlternative(Parser.prod__Keywords__lit_WHILE_, tmp);
	}
    protected static final void _init_prod__Keywords__lit_VAR_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new LiteralStackNode(718, 0, prod__lit_VAR__char_class___range__86_86_char_class___range__65_65_char_class___range__82_82_, new int[] {86,65,82}, null, null);
      builder.addAlternative(Parser.prod__Keywords__lit_VAR_, tmp);
	}
    protected static final void _init_prod__Keywords__lit_TYPE_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new LiteralStackNode(720, 0, prod__lit_TYPE__char_class___range__84_84_char_class___range__89_89_char_class___range__80_80_char_class___range__69_69_, new int[] {84,89,80,69}, null, null);
      builder.addAlternative(Parser.prod__Keywords__lit_TYPE_, tmp);
	}
    protected static final void _init_prod__Keywords__lit_CASE_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new LiteralStackNode(722, 0, prod__lit_CASE__char_class___range__67_67_char_class___range__65_65_char_class___range__83_83_char_class___range__69_69_, new int[] {67,65,83,69}, null, null);
      builder.addAlternative(Parser.prod__Keywords__lit_CASE_, tmp);
	}
    protected static final void _init_prod__Keywords__lit_UNTIL_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new LiteralStackNode(724, 0, prod__lit_UNTIL__char_class___range__85_85_char_class___range__78_78_char_class___range__84_84_char_class___range__73_73_char_class___range__76_76_, new int[] {85,78,84,73,76}, null, null);
      builder.addAlternative(Parser.prod__Keywords__lit_UNTIL_, tmp);
	}
    protected static final void _init_prod__Keywords__lit_CONST_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new LiteralStackNode(726, 0, prod__lit_CONST__char_class___range__67_67_char_class___range__79_79_char_class___range__78_78_char_class___range__83_83_char_class___range__84_84_, new int[] {67,79,78,83,84}, null, null);
      builder.addAlternative(Parser.prod__Keywords__lit_CONST_, tmp);
	}
    public static void init(ExpectBuilder builder){
      
      
        _init_prod__Keywords__lit_BY_(builder);
      
        _init_prod__Keywords__lit_DIV_(builder);
      
        _init_prod__Keywords__lit_DO_(builder);
      
        _init_prod__Keywords__lit_BEGIN_(builder);
      
        _init_prod__Keywords__lit_END_(builder);
      
        _init_prod__Keywords__lit_FOR_(builder);
      
        _init_prod__Keywords__lit_IF_(builder);
      
        _init_prod__Keywords__lit_ELSE_(builder);
      
        _init_prod__Keywords__lit_REPEAT_(builder);
      
        _init_prod__Keywords__lit_OF_(builder);
      
        _init_prod__Keywords__lit_OR_(builder);
      
        _init_prod__Keywords__lit_THEN_(builder);
      
        _init_prod__Keywords__lit_MODULE_(builder);
      
        _init_prod__Keywords__lit_TO_(builder);
      
        _init_prod__Keywords__lit_ELSIF_(builder);
      
        _init_prod__Keywords__lit_PROCEDURE_(builder);
      
        _init_prod__Keywords__lit_MOD_(builder);
      
        _init_prod__Keywords__lit_WHILE_(builder);
      
        _init_prod__Keywords__lit_VAR_(builder);
      
        _init_prod__Keywords__lit_TYPE_(builder);
      
        _init_prod__Keywords__lit_CASE_(builder);
      
        _init_prod__Keywords__lit_UNTIL_(builder);
      
        _init_prod__Keywords__lit_CONST_(builder);
      
    }
  }
	
  protected static class Comment {
    public final static AbstractStackNode[] EXPECTS;
    static{
      ExpectBuilder builder = new ExpectBuilder(_resultStoreIdMappings);
      init(builder);
      EXPECTS = builder.buildExpectArray();
    }
    
    protected static final void _init_prod__Comment__lit___40_42_iter_star__CommentElt_lit___42_41_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[3];
      
      tmp[2] = new LiteralStackNode(754, 2, prod__lit___42_41__char_class___range__42_42_char_class___range__41_41_, new int[] {42,41}, null, null);
      tmp[1] = new ListStackNode(750, 1, regular__iter_star__CommentElt, new NonTerminalStackNode(752, 0, "CommentElt", null, null), false, null, null);
      tmp[0] = new LiteralStackNode(748, 0, prod__lit___40_42__char_class___range__40_40_char_class___range__42_42_, new int[] {40,42}, null, null);
      builder.addAlternative(Parser.prod__Comment__lit___40_42_iter_star__CommentElt_lit___42_41_, tmp);
	}
    public static void init(ExpectBuilder builder){
      
      
        _init_prod__Comment__lit___40_42_iter_star__CommentElt_lit___42_41_(builder);
      
    }
  }
	
  protected static class Label {
    public final static AbstractStackNode[] EXPECTS;
    static{
      ExpectBuilder builder = new ExpectBuilder(_resultStoreIdMappings);
      init(builder);
      EXPECTS = builder.buildExpectArray();
    }
    
    protected static final void _init_prod__range_Label__from_Expression_layouts_Layouts_lit___46_46_layouts_Layouts_to_Expression_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[5];
      
      tmp[4] = new NonTerminalStackNode(764, 4, "Expression", null, null);
      tmp[3] = new NonTerminalStackNode(762, 3, "layouts_Layouts", null, null);
      tmp[2] = new LiteralStackNode(760, 2, prod__lit___46_46__char_class___range__46_46_char_class___range__46_46_, new int[] {46,46}, null, null);
      tmp[1] = new NonTerminalStackNode(758, 1, "layouts_Layouts", null, null);
      tmp[0] = new NonTerminalStackNode(756, 0, "Expression", null, null);
      builder.addAlternative(Parser.prod__range_Label__from_Expression_layouts_Layouts_lit___46_46_layouts_Layouts_to_Expression_, tmp);
	}
    protected static final void _init_prod__expression_Label__exp_Expression_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new NonTerminalStackNode(766, 0, "Expression", null, null);
      builder.addAlternative(Parser.prod__expression_Label__exp_Expression_, tmp);
	}
    public static void init(ExpectBuilder builder){
      
      
        _init_prod__range_Label__from_Expression_layouts_Layouts_lit___46_46_layouts_Layouts_to_Expression_(builder);
      
        _init_prod__expression_Label__exp_Expression_(builder);
      
    }
  }
	
  protected static class Case {
    public final static AbstractStackNode[] EXPECTS;
    static{
      ExpectBuilder builder = new ExpectBuilder(_resultStoreIdMappings);
      init(builder);
      EXPECTS = builder.buildExpectArray();
    }
    
    protected static final void _init_prod__guard_Case__iter_seps__Label__layouts_Layouts_lit___44_layouts_Layouts_layouts_Layouts_lit___58_layouts_Layouts_body_iter_seps__Statement__layouts_Layouts_lit___59_layouts_Layouts_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[5];
      
      tmp[4] = new SeparatedListStackNode(796, 4, regular__iter_seps__Statement__layouts_Layouts_lit___59_layouts_Layouts, new NonTerminalStackNode(798, 0, "Statement", null, null), new AbstractStackNode[]{new NonTerminalStackNode(800, 1, "layouts_Layouts", null, null), new LiteralStackNode(802, 2, prod__lit___59__char_class___range__59_59_, new int[] {59}, null, null), new NonTerminalStackNode(804, 3, "layouts_Layouts", null, null)}, true, null, null);
      tmp[3] = new NonTerminalStackNode(794, 3, "layouts_Layouts", null, null);
      tmp[2] = new LiteralStackNode(792, 2, prod__lit___58__char_class___range__58_58_, new int[] {58}, null, null);
      tmp[1] = new NonTerminalStackNode(790, 1, "layouts_Layouts", null, null);
      tmp[0] = new SeparatedListStackNode(780, 0, regular__iter_seps__Label__layouts_Layouts_lit___44_layouts_Layouts, new NonTerminalStackNode(782, 0, "Label", null, null), new AbstractStackNode[]{new NonTerminalStackNode(784, 1, "layouts_Layouts", null, null), new LiteralStackNode(786, 2, prod__lit___44__char_class___range__44_44_, new int[] {44}, null, null), new NonTerminalStackNode(788, 3, "layouts_Layouts", null, null)}, true, null, null);
      builder.addAlternative(Parser.prod__guard_Case__iter_seps__Label__layouts_Layouts_lit___44_layouts_Layouts_layouts_Layouts_lit___58_layouts_Layouts_body_iter_seps__Statement__layouts_Layouts_lit___59_layouts_Layouts_, tmp);
	}
    public static void init(ExpectBuilder builder){
      
      
        _init_prod__guard_Case__iter_seps__Label__layouts_Layouts_lit___44_layouts_Layouts_layouts_Layouts_lit___58_layouts_Layouts_body_iter_seps__Statement__layouts_Layouts_lit___59_layouts_Layouts_(builder);
      
    }
  }
	
  protected static class VarDecl {
    public final static AbstractStackNode[] EXPECTS;
    static{
      ExpectBuilder builder = new ExpectBuilder(_resultStoreIdMappings);
      init(builder);
      EXPECTS = builder.buildExpectArray();
    }
    
    protected static final void _init_prod__varDecl_VarDecl__names_iter_star_seps__Ident__layouts_Layouts_lit___44_layouts_Layouts_layouts_Layouts_lit___58_layouts_Layouts_type_Type_layouts_Layouts_lit___59_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[7];
      
      tmp[6] = new LiteralStackNode(826, 6, prod__lit___59__char_class___range__59_59_, new int[] {59}, null, null);
      tmp[5] = new NonTerminalStackNode(824, 5, "layouts_Layouts", null, null);
      tmp[4] = new NonTerminalStackNode(822, 4, "Type", null, null);
      tmp[3] = new NonTerminalStackNode(820, 3, "layouts_Layouts", null, null);
      tmp[2] = new LiteralStackNode(818, 2, prod__lit___58__char_class___range__58_58_, new int[] {58}, null, null);
      tmp[1] = new NonTerminalStackNode(816, 1, "layouts_Layouts", null, null);
      tmp[0] = new SeparatedListStackNode(806, 0, regular__iter_star_seps__Ident__layouts_Layouts_lit___44_layouts_Layouts, new NonTerminalStackNode(808, 0, "Ident", null, null), new AbstractStackNode[]{new NonTerminalStackNode(810, 1, "layouts_Layouts", null, null), new LiteralStackNode(812, 2, prod__lit___44__char_class___range__44_44_, new int[] {44}, null, null), new NonTerminalStackNode(814, 3, "layouts_Layouts", null, null)}, false, null, null);
      builder.addAlternative(Parser.prod__varDecl_VarDecl__names_iter_star_seps__Ident__layouts_Layouts_lit___44_layouts_Layouts_layouts_Layouts_lit___58_layouts_Layouts_type_Type_layouts_Layouts_lit___59_, tmp);
	}
    public static void init(ExpectBuilder builder){
      
      
        _init_prod__varDecl_VarDecl__names_iter_star_seps__Ident__layouts_Layouts_lit___44_layouts_Layouts_layouts_Layouts_lit___58_layouts_Layouts_type_Type_layouts_Layouts_lit___59_(builder);
      
    }
  }
	
  protected static class ElsIfPart {
    public final static AbstractStackNode[] EXPECTS;
    static{
      ExpectBuilder builder = new ExpectBuilder(_resultStoreIdMappings);
      init(builder);
      EXPECTS = builder.buildExpectArray();
    }
    
    protected static final void _init_prod__ElsIfPart__lit_ELSIF_layouts_Layouts_condition_Expression_layouts_Layouts_lit_THEN_layouts_Layouts_body_iter_seps__Statement__layouts_Layouts_lit___59_layouts_Layouts_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[7];
      
      tmp[6] = new SeparatedListStackNode(860, 6, regular__iter_seps__Statement__layouts_Layouts_lit___59_layouts_Layouts, new NonTerminalStackNode(862, 0, "Statement", null, null), new AbstractStackNode[]{new NonTerminalStackNode(864, 1, "layouts_Layouts", null, null), new LiteralStackNode(866, 2, prod__lit___59__char_class___range__59_59_, new int[] {59}, null, null), new NonTerminalStackNode(868, 3, "layouts_Layouts", null, null)}, true, null, null);
      tmp[5] = new NonTerminalStackNode(858, 5, "layouts_Layouts", null, null);
      tmp[4] = new LiteralStackNode(856, 4, prod__lit_THEN__char_class___range__84_84_char_class___range__72_72_char_class___range__69_69_char_class___range__78_78_, new int[] {84,72,69,78}, null, null);
      tmp[3] = new NonTerminalStackNode(854, 3, "layouts_Layouts", null, null);
      tmp[2] = new NonTerminalStackNode(852, 2, "Expression", null, null);
      tmp[1] = new NonTerminalStackNode(850, 1, "layouts_Layouts", null, null);
      tmp[0] = new LiteralStackNode(848, 0, prod__lit_ELSIF__char_class___range__69_69_char_class___range__76_76_char_class___range__83_83_char_class___range__73_73_char_class___range__70_70_, new int[] {69,76,83,73,70}, null, null);
      builder.addAlternative(Parser.prod__ElsIfPart__lit_ELSIF_layouts_Layouts_condition_Expression_layouts_Layouts_lit_THEN_layouts_Layouts_body_iter_seps__Statement__layouts_Layouts_lit___59_layouts_Layouts_, tmp);
	}
    public static void init(ExpectBuilder builder){
      
      
        _init_prod__ElsIfPart__lit_ELSIF_layouts_Layouts_condition_Expression_layouts_Layouts_lit_THEN_layouts_Layouts_body_iter_seps__Statement__layouts_Layouts_lit___59_layouts_Layouts_(builder);
      
    }
  }
	
  protected static class CommentChar {
    public final static AbstractStackNode[] EXPECTS;
    static{
      ExpectBuilder builder = new ExpectBuilder(_resultStoreIdMappings);
      init(builder);
      EXPECTS = builder.buildExpectArray();
    }
    
    protected static final void _init_prod__CommentChar__conditional__char_class___range__40_40__not_follow__char_class___range__42_42_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new CharStackNode(880, 0, new int[][]{{40,40}}, null, new ICompletionFilter[] {new CharFollowRestriction(new int[][]{{42,42}})});
      builder.addAlternative(Parser.prod__CommentChar__conditional__char_class___range__40_40__not_follow__char_class___range__42_42_, tmp);
	}
    protected static final void _init_prod__CommentChar__conditional__char_class___range__42_42__not_follow__char_class___range__41_41_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new CharStackNode(882, 0, new int[][]{{42,42}}, null, new ICompletionFilter[] {new CharFollowRestriction(new int[][]{{41,41}})});
      builder.addAlternative(Parser.prod__CommentChar__conditional__char_class___range__42_42__not_follow__char_class___range__41_41_, tmp);
	}
    protected static final void _init_prod__CommentChar__char_class___range__0_39_range__41_41_range__43_16777215_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new CharStackNode(884, 0, new int[][]{{0,39},{41,41},{43,16777215}}, null, null);
      builder.addAlternative(Parser.prod__CommentChar__char_class___range__0_39_range__41_41_range__43_16777215_, tmp);
	}
    public static void init(ExpectBuilder builder){
      
      
        _init_prod__CommentChar__conditional__char_class___range__40_40__not_follow__char_class___range__42_42_(builder);
      
        _init_prod__CommentChar__conditional__char_class___range__42_42__not_follow__char_class___range__41_41_(builder);
      
        _init_prod__CommentChar__char_class___range__0_39_range__41_41_range__43_16777215_(builder);
      
    }
  }
	
  protected static class Type {
    public final static AbstractStackNode[] EXPECTS;
    static{
      ExpectBuilder builder = new ExpectBuilder(_resultStoreIdMappings);
      init(builder);
      EXPECTS = builder.buildExpectArray();
    }
    
    protected static final void _init_prod__user_Type__name_Ident_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new NonTerminalStackNode(886, 0, "Ident", null, null);
      builder.addAlternative(Parser.prod__user_Type__name_Ident_, tmp);
	}
    public static void init(ExpectBuilder builder){
      
      
        _init_prod__user_Type__name_Ident_(builder);
      
    }
  }
	
  protected static class Declarations {
    public final static AbstractStackNode[] EXPECTS;
    static{
      ExpectBuilder builder = new ExpectBuilder(_resultStoreIdMappings);
      init(builder);
      EXPECTS = builder.buildExpectArray();
    }
    
    protected static final void _init_prod__decls_Declarations__consts_opt__ConstSect_layouts_Layouts_types_opt__TypeSect_layouts_Layouts_vars_opt__VarSect_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[5];
      
      tmp[4] = new OptionalStackNode(902, 4, regular__opt__VarSect, new NonTerminalStackNode(904, 0, "VarSect", null, null), null, null);
      tmp[3] = new NonTerminalStackNode(900, 3, "layouts_Layouts", null, null);
      tmp[2] = new OptionalStackNode(896, 2, regular__opt__TypeSect, new NonTerminalStackNode(898, 0, "TypeSect", null, null), null, null);
      tmp[1] = new NonTerminalStackNode(894, 1, "layouts_Layouts", null, null);
      tmp[0] = new OptionalStackNode(890, 0, regular__opt__ConstSect, new NonTerminalStackNode(892, 0, "ConstSect", null, null), null, null);
      builder.addAlternative(Parser.prod__decls_Declarations__consts_opt__ConstSect_layouts_Layouts_types_opt__TypeSect_layouts_Layouts_vars_opt__VarSect_, tmp);
	}
    protected static final void _init_prod__decls_Declarations__consts_opt__ConstSect_layouts_Layouts_types_opt__TypeSect_layouts_Layouts_vars_opt__VarSect_layouts_Layouts_procs_iter_seps__ProcedureDecl__layouts_Layouts_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[7];
      
      tmp[6] = new SeparatedListStackNode(924, 6, regular__iter_seps__ProcedureDecl__layouts_Layouts, new NonTerminalStackNode(926, 0, "ProcedureDecl", null, null), new AbstractStackNode[]{new NonTerminalStackNode(928, 1, "layouts_Layouts", null, null)}, true, null, null);
      tmp[5] = new NonTerminalStackNode(922, 5, "layouts_Layouts", null, null);
      tmp[4] = new OptionalStackNode(918, 4, regular__opt__VarSect, new NonTerminalStackNode(920, 0, "VarSect", null, null), null, null);
      tmp[3] = new NonTerminalStackNode(916, 3, "layouts_Layouts", null, null);
      tmp[2] = new OptionalStackNode(912, 2, regular__opt__TypeSect, new NonTerminalStackNode(914, 0, "TypeSect", null, null), null, null);
      tmp[1] = new NonTerminalStackNode(910, 1, "layouts_Layouts", null, null);
      tmp[0] = new OptionalStackNode(906, 0, regular__opt__ConstSect, new NonTerminalStackNode(908, 0, "ConstSect", null, null), null, null);
      builder.addAlternative(Parser.prod__decls_Declarations__consts_opt__ConstSect_layouts_Layouts_types_opt__TypeSect_layouts_Layouts_vars_opt__VarSect_layouts_Layouts_procs_iter_seps__ProcedureDecl__layouts_Layouts_, tmp);
	}
    public static void init(ExpectBuilder builder){
      
      
        _init_prod__decls_Declarations__consts_opt__ConstSect_layouts_Layouts_types_opt__TypeSect_layouts_Layouts_vars_opt__VarSect_(builder);
      
        _init_prod__decls_Declarations__consts_opt__ConstSect_layouts_Layouts_types_opt__TypeSect_layouts_Layouts_vars_opt__VarSect_layouts_Layouts_procs_iter_seps__ProcedureDecl__layouts_Layouts_(builder);
      
    }
  }
	
  protected static class Natural {
    public final static AbstractStackNode[] EXPECTS;
    static{
      ExpectBuilder builder = new ExpectBuilder(_resultStoreIdMappings);
      init(builder);
      EXPECTS = builder.buildExpectArray();
    }
    
    protected static final void _init_prod__Natural__char_class___range__49_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_conditional__char_class___range__48_57__not_follow__char_class___range__48_57_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[9];
      
      tmp[8] = new CharStackNode(986, 8, new int[][]{{48,57}}, null, new ICompletionFilter[] {new CharFollowRestriction(new int[][]{{48,57}})});
      tmp[7] = new CharStackNode(984, 7, new int[][]{{48,57}}, null, null);
      tmp[6] = new CharStackNode(982, 6, new int[][]{{48,57}}, null, null);
      tmp[5] = new CharStackNode(980, 5, new int[][]{{48,57}}, null, null);
      tmp[4] = new CharStackNode(978, 4, new int[][]{{48,57}}, null, null);
      tmp[3] = new CharStackNode(976, 3, new int[][]{{48,57}}, null, null);
      tmp[2] = new CharStackNode(974, 2, new int[][]{{48,57}}, null, null);
      tmp[1] = new CharStackNode(972, 1, new int[][]{{48,57}}, null, null);
      tmp[0] = new CharStackNode(970, 0, new int[][]{{49,57}}, null, null);
      builder.addAlternative(Parser.prod__Natural__char_class___range__49_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_conditional__char_class___range__48_57__not_follow__char_class___range__48_57_, tmp);
	}
    protected static final void _init_prod__Natural__char_class___range__49_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_conditional__char_class___range__48_57__not_follow__char_class___range__48_57_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[5];
      
      tmp[0] = new CharStackNode(988, 0, new int[][]{{49,57}}, null, null);
      tmp[1] = new CharStackNode(990, 1, new int[][]{{48,57}}, null, null);
      tmp[2] = new CharStackNode(992, 2, new int[][]{{48,57}}, null, null);
      tmp[3] = new CharStackNode(994, 3, new int[][]{{48,57}}, null, null);
      tmp[4] = new CharStackNode(996, 4, new int[][]{{48,57}}, null, new ICompletionFilter[] {new CharFollowRestriction(new int[][]{{48,57}})});
      builder.addAlternative(Parser.prod__Natural__char_class___range__49_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_conditional__char_class___range__48_57__not_follow__char_class___range__48_57_, tmp);
	}
    protected static final void _init_prod__Natural__char_class___range__49_57_char_class___range__48_57_char_class___range__48_57_conditional__char_class___range__48_57__not_follow__char_class___range__48_57_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[4];
      
      tmp[3] = new CharStackNode(1004, 3, new int[][]{{48,57}}, null, new ICompletionFilter[] {new CharFollowRestriction(new int[][]{{48,57}})});
      tmp[2] = new CharStackNode(1002, 2, new int[][]{{48,57}}, null, null);
      tmp[1] = new CharStackNode(1000, 1, new int[][]{{48,57}}, null, null);
      tmp[0] = new CharStackNode(998, 0, new int[][]{{49,57}}, null, null);
      builder.addAlternative(Parser.prod__Natural__char_class___range__49_57_char_class___range__48_57_char_class___range__48_57_conditional__char_class___range__48_57__not_follow__char_class___range__48_57_, tmp);
	}
    protected static final void _init_prod__Natural__char_class___range__49_57_char_class___range__48_57_conditional__char_class___range__48_57__not_follow__char_class___range__48_57_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[3];
      
      tmp[2] = new CharStackNode(1010, 2, new int[][]{{48,57}}, null, new ICompletionFilter[] {new CharFollowRestriction(new int[][]{{48,57}})});
      tmp[1] = new CharStackNode(1008, 1, new int[][]{{48,57}}, null, null);
      tmp[0] = new CharStackNode(1006, 0, new int[][]{{49,57}}, null, null);
      builder.addAlternative(Parser.prod__Natural__char_class___range__49_57_char_class___range__48_57_conditional__char_class___range__48_57__not_follow__char_class___range__48_57_, tmp);
	}
    protected static final void _init_prod__Natural__char_class___range__49_50_char_class___range__48_49_char_class___range__48_52_char_class___range__48_55_char_class___range__48_52_char_class___range__48_56_char_class___range__48_51_char_class___range__48_54_char_class___range__48_52_conditional__char_class___range__48_55__not_follow__char_class___range__48_57_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[10];
      
      tmp[9] = new CharStackNode(1030, 9, new int[][]{{48,55}}, null, new ICompletionFilter[] {new CharFollowRestriction(new int[][]{{48,57}})});
      tmp[8] = new CharStackNode(1028, 8, new int[][]{{48,52}}, null, null);
      tmp[7] = new CharStackNode(1026, 7, new int[][]{{48,54}}, null, null);
      tmp[6] = new CharStackNode(1024, 6, new int[][]{{48,51}}, null, null);
      tmp[5] = new CharStackNode(1022, 5, new int[][]{{48,56}}, null, null);
      tmp[4] = new CharStackNode(1020, 4, new int[][]{{48,52}}, null, null);
      tmp[3] = new CharStackNode(1018, 3, new int[][]{{48,55}}, null, null);
      tmp[2] = new CharStackNode(1016, 2, new int[][]{{48,52}}, null, null);
      tmp[1] = new CharStackNode(1014, 1, new int[][]{{48,49}}, null, null);
      tmp[0] = new CharStackNode(1012, 0, new int[][]{{49,50}}, null, null);
      builder.addAlternative(Parser.prod__Natural__char_class___range__49_50_char_class___range__48_49_char_class___range__48_52_char_class___range__48_55_char_class___range__48_52_char_class___range__48_56_char_class___range__48_51_char_class___range__48_54_char_class___range__48_52_conditional__char_class___range__48_55__not_follow__char_class___range__48_57_, tmp);
	}
    protected static final void _init_prod__Natural__char_class___range__49_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_conditional__char_class___range__48_57__not_follow__char_class___range__48_57_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[6];
      
      tmp[5] = new CharStackNode(1042, 5, new int[][]{{48,57}}, null, new ICompletionFilter[] {new CharFollowRestriction(new int[][]{{48,57}})});
      tmp[4] = new CharStackNode(1040, 4, new int[][]{{48,57}}, null, null);
      tmp[3] = new CharStackNode(1038, 3, new int[][]{{48,57}}, null, null);
      tmp[2] = new CharStackNode(1036, 2, new int[][]{{48,57}}, null, null);
      tmp[1] = new CharStackNode(1034, 1, new int[][]{{48,57}}, null, null);
      tmp[0] = new CharStackNode(1032, 0, new int[][]{{49,57}}, null, null);
      builder.addAlternative(Parser.prod__Natural__char_class___range__49_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_conditional__char_class___range__48_57__not_follow__char_class___range__48_57_, tmp);
	}
    protected static final void _init_prod__Natural__char_class___range__49_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_conditional__char_class___range__48_57__not_follow__char_class___range__48_57_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[7];
      
      tmp[6] = new CharStackNode(1056, 6, new int[][]{{48,57}}, null, new ICompletionFilter[] {new CharFollowRestriction(new int[][]{{48,57}})});
      tmp[5] = new CharStackNode(1054, 5, new int[][]{{48,57}}, null, null);
      tmp[4] = new CharStackNode(1052, 4, new int[][]{{48,57}}, null, null);
      tmp[3] = new CharStackNode(1050, 3, new int[][]{{48,57}}, null, null);
      tmp[2] = new CharStackNode(1048, 2, new int[][]{{48,57}}, null, null);
      tmp[1] = new CharStackNode(1046, 1, new int[][]{{48,57}}, null, null);
      tmp[0] = new CharStackNode(1044, 0, new int[][]{{49,57}}, null, null);
      builder.addAlternative(Parser.prod__Natural__char_class___range__49_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_conditional__char_class___range__48_57__not_follow__char_class___range__48_57_, tmp);
	}
    protected static final void _init_prod__Natural__conditional__char_class___range__48_57__not_follow__char_class___range__48_57_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new CharStackNode(1058, 0, new int[][]{{48,57}}, null, new ICompletionFilter[] {new CharFollowRestriction(new int[][]{{48,57}})});
      builder.addAlternative(Parser.prod__Natural__conditional__char_class___range__48_57__not_follow__char_class___range__48_57_, tmp);
	}
    protected static final void _init_prod__Natural__char_class___range__49_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_conditional__char_class___range__48_57__not_follow__char_class___range__48_57_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[8];
      
      tmp[7] = new CharStackNode(1074, 7, new int[][]{{48,57}}, null, new ICompletionFilter[] {new CharFollowRestriction(new int[][]{{48,57}})});
      tmp[6] = new CharStackNode(1072, 6, new int[][]{{48,57}}, null, null);
      tmp[5] = new CharStackNode(1070, 5, new int[][]{{48,57}}, null, null);
      tmp[4] = new CharStackNode(1068, 4, new int[][]{{48,57}}, null, null);
      tmp[3] = new CharStackNode(1066, 3, new int[][]{{48,57}}, null, null);
      tmp[2] = new CharStackNode(1064, 2, new int[][]{{48,57}}, null, null);
      tmp[1] = new CharStackNode(1062, 1, new int[][]{{48,57}}, null, null);
      tmp[0] = new CharStackNode(1060, 0, new int[][]{{49,57}}, null, null);
      builder.addAlternative(Parser.prod__Natural__char_class___range__49_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_conditional__char_class___range__48_57__not_follow__char_class___range__48_57_, tmp);
	}
    protected static final void _init_prod__Natural__char_class___range__49_57_conditional__char_class___range__48_57__not_follow__char_class___range__48_57_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[2];
      
      tmp[1] = new CharStackNode(1078, 1, new int[][]{{48,57}}, null, new ICompletionFilter[] {new CharFollowRestriction(new int[][]{{48,57}})});
      tmp[0] = new CharStackNode(1076, 0, new int[][]{{49,57}}, null, null);
      builder.addAlternative(Parser.prod__Natural__char_class___range__49_57_conditional__char_class___range__48_57__not_follow__char_class___range__48_57_, tmp);
	}
    public static void init(ExpectBuilder builder){
      
      
        _init_prod__Natural__char_class___range__49_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_conditional__char_class___range__48_57__not_follow__char_class___range__48_57_(builder);
      
        _init_prod__Natural__char_class___range__49_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_conditional__char_class___range__48_57__not_follow__char_class___range__48_57_(builder);
      
        _init_prod__Natural__char_class___range__49_57_char_class___range__48_57_char_class___range__48_57_conditional__char_class___range__48_57__not_follow__char_class___range__48_57_(builder);
      
        _init_prod__Natural__char_class___range__49_57_char_class___range__48_57_conditional__char_class___range__48_57__not_follow__char_class___range__48_57_(builder);
      
        _init_prod__Natural__char_class___range__49_50_char_class___range__48_49_char_class___range__48_52_char_class___range__48_55_char_class___range__48_52_char_class___range__48_56_char_class___range__48_51_char_class___range__48_54_char_class___range__48_52_conditional__char_class___range__48_55__not_follow__char_class___range__48_57_(builder);
      
        _init_prod__Natural__char_class___range__49_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_conditional__char_class___range__48_57__not_follow__char_class___range__48_57_(builder);
      
        _init_prod__Natural__char_class___range__49_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_conditional__char_class___range__48_57__not_follow__char_class___range__48_57_(builder);
      
        _init_prod__Natural__conditional__char_class___range__48_57__not_follow__char_class___range__48_57_(builder);
      
        _init_prod__Natural__char_class___range__49_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_conditional__char_class___range__48_57__not_follow__char_class___range__48_57_(builder);
      
        _init_prod__Natural__char_class___range__49_57_conditional__char_class___range__48_57__not_follow__char_class___range__48_57_(builder);
      
    }
  }
	
  protected static class ElsePart {
    public final static AbstractStackNode[] EXPECTS;
    static{
      ExpectBuilder builder = new ExpectBuilder(_resultStoreIdMappings);
      init(builder);
      EXPECTS = builder.buildExpectArray();
    }
    
    protected static final void _init_prod__ElsePart__lit_ELSE_layouts_Layouts_body_iter_seps__Statement__layouts_Layouts_lit___59_layouts_Layouts_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[3];
      
      tmp[2] = new SeparatedListStackNode(1102, 2, regular__iter_seps__Statement__layouts_Layouts_lit___59_layouts_Layouts, new NonTerminalStackNode(1104, 0, "Statement", null, null), new AbstractStackNode[]{new NonTerminalStackNode(1106, 1, "layouts_Layouts", null, null), new LiteralStackNode(1108, 2, prod__lit___59__char_class___range__59_59_, new int[] {59}, null, null), new NonTerminalStackNode(1110, 3, "layouts_Layouts", null, null)}, true, null, null);
      tmp[1] = new NonTerminalStackNode(1100, 1, "layouts_Layouts", null, null);
      tmp[0] = new LiteralStackNode(1098, 0, prod__lit_ELSE__char_class___range__69_69_char_class___range__76_76_char_class___range__83_83_char_class___range__69_69_, new int[] {69,76,83,69}, null, null);
      builder.addAlternative(Parser.prod__ElsePart__lit_ELSE_layouts_Layouts_body_iter_seps__Statement__layouts_Layouts_lit___59_layouts_Layouts_, tmp);
	}
    public static void init(ExpectBuilder builder){
      
      
        _init_prod__ElsePart__lit_ELSE_layouts_Layouts_body_iter_seps__Statement__layouts_Layouts_lit___59_layouts_Layouts_(builder);
      
    }
  }
	
  protected static class VarSect {
    public final static AbstractStackNode[] EXPECTS;
    static{
      ExpectBuilder builder = new ExpectBuilder(_resultStoreIdMappings);
      init(builder);
      EXPECTS = builder.buildExpectArray();
    }
    
    protected static final void _init_prod__VarSect__lit_VAR_layouts_Layouts_vars_iter_star_seps__VarDecl__layouts_Layouts__tag__Foldable(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[3];
      
      tmp[2] = new SeparatedListStackNode(1144, 2, regular__iter_star_seps__VarDecl__layouts_Layouts, new NonTerminalStackNode(1146, 0, "VarDecl", null, null), new AbstractStackNode[]{new NonTerminalStackNode(1148, 1, "layouts_Layouts", null, null)}, false, null, null);
      tmp[1] = new NonTerminalStackNode(1142, 1, "layouts_Layouts", null, null);
      tmp[0] = new LiteralStackNode(1140, 0, prod__lit_VAR__char_class___range__86_86_char_class___range__65_65_char_class___range__82_82_, new int[] {86,65,82}, null, null);
      builder.addAlternative(Parser.prod__VarSect__lit_VAR_layouts_Layouts_vars_iter_star_seps__VarDecl__layouts_Layouts__tag__Foldable, tmp);
	}
    public static void init(ExpectBuilder builder){
      
      
        _init_prod__VarSect__lit_VAR_layouts_Layouts_vars_iter_star_seps__VarDecl__layouts_Layouts__tag__Foldable(builder);
      
    }
  }
	
  protected static class layouts_$BACKTICKS {
    public final static AbstractStackNode[] EXPECTS;
    static{
      ExpectBuilder builder = new ExpectBuilder(_resultStoreIdMappings);
      init(builder);
      EXPECTS = builder.buildExpectArray();
    }
    
    protected static final void _init_prod__layouts_$BACKTICKS__(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new EpsilonStackNode(1164, 0);
      builder.addAlternative(Parser.prod__layouts_$BACKTICKS__, tmp);
	}
    public static void init(ExpectBuilder builder){
      
      
        _init_prod__layouts_$BACKTICKS__(builder);
      
    }
  }
	
  protected static class ProcedureDecl {
    public final static AbstractStackNode[] EXPECTS;
    static{
      ExpectBuilder builder = new ExpectBuilder(_resultStoreIdMappings);
      init(builder);
      EXPECTS = builder.buildExpectArray();
    }
    
    protected static final void _init_prod__proc_ProcedureDecl__lit_PROCEDURE_layouts_Layouts_name_Ident_layouts_Layouts_formals_opt__Formals_layouts_Layouts_lit___59_layouts_Layouts_decls_Declarations_layouts_Layouts_body_opt__Body_layouts_Layouts_lit_END_layouts_Layouts_Ident_layouts_Layouts_lit___59__tag__Foldable(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[17];
      
      tmp[16] = new LiteralStackNode(1228, 16, prod__lit___59__char_class___range__59_59_, new int[] {59}, null, null);
      tmp[15] = new NonTerminalStackNode(1226, 15, "layouts_Layouts", null, null);
      tmp[14] = new NonTerminalStackNode(1224, 14, "Ident", null, null);
      tmp[13] = new NonTerminalStackNode(1222, 13, "layouts_Layouts", null, null);
      tmp[12] = new LiteralStackNode(1220, 12, prod__lit_END__char_class___range__69_69_char_class___range__78_78_char_class___range__68_68_, new int[] {69,78,68}, null, null);
      tmp[11] = new NonTerminalStackNode(1218, 11, "layouts_Layouts", null, null);
      tmp[10] = new OptionalStackNode(1214, 10, regular__opt__Body, new NonTerminalStackNode(1216, 0, "Body", null, null), null, null);
      tmp[9] = new NonTerminalStackNode(1212, 9, "layouts_Layouts", null, null);
      tmp[8] = new NonTerminalStackNode(1210, 8, "Declarations", null, null);
      tmp[7] = new NonTerminalStackNode(1208, 7, "layouts_Layouts", null, null);
      tmp[6] = new LiteralStackNode(1206, 6, prod__lit___59__char_class___range__59_59_, new int[] {59}, null, null);
      tmp[5] = new NonTerminalStackNode(1204, 5, "layouts_Layouts", null, null);
      tmp[4] = new OptionalStackNode(1200, 4, regular__opt__Formals, new NonTerminalStackNode(1202, 0, "Formals", null, null), null, null);
      tmp[3] = new NonTerminalStackNode(1198, 3, "layouts_Layouts", null, null);
      tmp[2] = new NonTerminalStackNode(1196, 2, "Ident", null, null);
      tmp[1] = new NonTerminalStackNode(1194, 1, "layouts_Layouts", null, null);
      tmp[0] = new LiteralStackNode(1192, 0, prod__lit_PROCEDURE__char_class___range__80_80_char_class___range__82_82_char_class___range__79_79_char_class___range__67_67_char_class___range__69_69_char_class___range__68_68_char_class___range__85_85_char_class___range__82_82_char_class___range__69_69_, new int[] {80,82,79,67,69,68,85,82,69}, null, null);
      builder.addAlternative(Parser.prod__proc_ProcedureDecl__lit_PROCEDURE_layouts_Layouts_name_Ident_layouts_Layouts_formals_opt__Formals_layouts_Layouts_lit___59_layouts_Layouts_decls_Declarations_layouts_Layouts_body_opt__Body_layouts_Layouts_lit_END_layouts_Layouts_Ident_layouts_Layouts_lit___59__tag__Foldable, tmp);
	}
    public static void init(ExpectBuilder builder){
      
      
        _init_prod__proc_ProcedureDecl__lit_PROCEDURE_layouts_Layouts_name_Ident_layouts_Layouts_formals_opt__Formals_layouts_Layouts_lit___59_layouts_Layouts_decls_Declarations_layouts_Layouts_body_opt__Body_layouts_Layouts_lit_END_layouts_Layouts_Ident_layouts_Layouts_lit___59__tag__Foldable(builder);
      
    }
  }
	
  protected static class layouts_$default$ {
    public final static AbstractStackNode[] EXPECTS;
    static{
      ExpectBuilder builder = new ExpectBuilder(_resultStoreIdMappings);
      init(builder);
      EXPECTS = builder.buildExpectArray();
    }
    
    protected static final void _init_prod__layouts_$default$__(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new EpsilonStackNode(1238, 0);
      builder.addAlternative(Parser.prod__layouts_$default$__, tmp);
	}
    public static void init(ExpectBuilder builder){
      
      
        _init_prod__layouts_$default$__(builder);
      
    }
  }
	
  public Parser() {
    super();
  }

  // Parse methods    
  
  public AbstractStackNode[] CommentElt() {
    return CommentElt.EXPECTS;
  }
  public AbstractStackNode[] Actuals() {
    return Actuals.EXPECTS;
  }
  public AbstractStackNode[] Formal() {
    return Formal.EXPECTS;
  }
  public AbstractStackNode[] Module() {
    return Module.EXPECTS;
  }
  public AbstractStackNode[] ConstDecl() {
    return ConstDecl.EXPECTS;
  }
  public AbstractStackNode[] start__Module() {
    return start__Module.EXPECTS;
  }
  public AbstractStackNode[] ConstSect() {
    return ConstSect.EXPECTS;
  }
  public AbstractStackNode[] TypeDecl() {
    return TypeDecl.EXPECTS;
  }
  public AbstractStackNode[] Layout() {
    return Layout.EXPECTS;
  }
  public AbstractStackNode[] layouts_Layouts() {
    return layouts_Layouts.EXPECTS;
  }
  public AbstractStackNode[] TypeSect() {
    return TypeSect.EXPECTS;
  }
  public AbstractStackNode[] Expression() {
    return Expression.EXPECTS;
  }
  public AbstractStackNode[] Ident() {
    return Ident.EXPECTS;
  }
  public AbstractStackNode[] Formals() {
    return Formals.EXPECTS;
  }
  public AbstractStackNode[] layouts_$QUOTES() {
    return layouts_$QUOTES.EXPECTS;
  }
  public AbstractStackNode[] Body() {
    return Body.EXPECTS;
  }
  public AbstractStackNode[] Statement() {
    return Statement.EXPECTS;
  }
  public AbstractStackNode[] Keywords() {
    return Keywords.EXPECTS;
  }
  public AbstractStackNode[] Comment() {
    return Comment.EXPECTS;
  }
  public AbstractStackNode[] Label() {
    return Label.EXPECTS;
  }
  public AbstractStackNode[] Case() {
    return Case.EXPECTS;
  }
  public AbstractStackNode[] VarDecl() {
    return VarDecl.EXPECTS;
  }
  public AbstractStackNode[] ElsIfPart() {
    return ElsIfPart.EXPECTS;
  }
  public AbstractStackNode[] CommentChar() {
    return CommentChar.EXPECTS;
  }
  public AbstractStackNode[] Type() {
    return Type.EXPECTS;
  }
  public AbstractStackNode[] Declarations() {
    return Declarations.EXPECTS;
  }
  public AbstractStackNode[] Natural() {
    return Natural.EXPECTS;
  }
  public AbstractStackNode[] ElsePart() {
    return ElsePart.EXPECTS;
  }
  public AbstractStackNode[] VarSect() {
    return VarSect.EXPECTS;
  }
  public AbstractStackNode[] layouts_$BACKTICKS() {
    return layouts_$BACKTICKS.EXPECTS;
  }
  public AbstractStackNode[] ProcedureDecl() {
    return ProcedureDecl.EXPECTS;
  }
  public AbstractStackNode[] layouts_$default$() {
    return layouts_$default$.EXPECTS;
  }
}