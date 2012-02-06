package ldta.oberon0.l4;

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
    
    
    
    
    _putDontNest(result, 430, 428);
    
    _putDontNest(result, 312, 346);
    
    _putDontNest(result, 346, 376);
    
    _putDontNest(result, 420, 438);
    
    _putDontNest(result, 460, 458);
    
    _putDontNest(result, 450, 468);
    
    _putDontNest(result, 356, 366);
    
    _putDontNest(result, 408, 386);
    
    _putDontNest(result, 448, 458);
    
    _putDontNest(result, 392, 402);
    
    _putDontNest(result, 338, 376);
    
    _putDontNest(result, 386, 392);
    
    _putDontNest(result, 428, 438);
    
    _putDontNest(result, 440, 418);
    
    _putDontNest(result, 458, 468);
    
    _putDontNest(result, 418, 428);
    
    _putDontNest(result, 450, 448);
    
    _putDontNest(result, 420, 418);
    
    _putDontNest(result, 366, 408);
    
    _putDontNest(result, 408, 402);
    
    _putDontNest(result, 438, 428);
    
    _putDontNest(result, 392, 386);
    
    _putDontNest(result, 366, 356);
    
    _putDontNest(result, 458, 448);
    
    _putDontNest(result, 346, 336);
    
    _putDontNest(result, 402, 392);
    
    _putDontNest(result, 440, 438);
    
    _putDontNest(result, 428, 418);
    
    _putDontNest(result, 468, 458);
    
    _putDontNest(result, 358, 408);
    
    _putDontNest(result, 346, 408);
    
    _putDontNest(result, 394, 428);
    
    _putDontNest(result, 408, 418);
    
    _putDontNest(result, 338, 408);
    
    _putDontNest(result, 386, 428);
    
    _putDontNest(result, 366, 336);
    
    _putDontNest(result, 346, 356);
    
    _putDontNest(result, 392, 438);
    
    _putDontNest(result, 366, 376);
    
    _putDontNest(result, 410, 428);
    
    _putDontNest(result, 392, 418);
    
    _putDontNest(result, 408, 438);
    
    _putDontNest(result, 358, 376);
    
    _putDontNest(result, 402, 428);
    
    _putDontNest(result, 336, 366);
    
    _putDontNest(result, 392, 458);
    
    _putDontNest(result, 402, 448);
    
    _putDontNest(result, 386, 468);
    
    _putDontNest(result, 410, 448);
    
    _putDontNest(result, 394, 468);
    
    _putDontNest(result, 386, 448);
    
    _putDontNest(result, 408, 458);
    
    _putDontNest(result, 312, 366);
    
    _putDontNest(result, 402, 468);
    
    _putDontNest(result, 394, 448);
    
    _putDontNest(result, 410, 468);
    
    _putDontNest(result, 356, 346);
    
    _putDontNest(result, 418, 468);
    
    _putDontNest(result, 438, 448);
    
    _putDontNest(result, 448, 438);
    
    _putDontNest(result, 428, 458);
    
    _putDontNest(result, 468, 418);
    
    _putDontNest(result, 458, 428);
    
    _putDontNest(result, 430, 468);
    
    _putDontNest(result, 460, 438);
    
    _putDontNest(result, 336, 346);
    
    _putDontNest(result, 420, 458);
    
    _putDontNest(result, 450, 428);
    
    _putDontNest(result, 418, 448);
    
    _putDontNest(result, 468, 438);
    
    _putDontNest(result, 438, 468);
    
    _putDontNest(result, 440, 458);
    
    _putDontNest(result, 448, 418);
    
    _putDontNest(result, 430, 448);
    
    _putDontNest(result, 460, 418);
    
    _putDontNest(result, 328, 458);
    
    _putDontNest(result, 338, 448);
    
    _putDontNest(result, 346, 448);
    
    _putDontNest(result, 312, 418);
    
    _putDontNest(result, 348, 458);
    
    _putDontNest(result, 338, 468);
    
    _putDontNest(result, 336, 458);
    
    _putDontNest(result, 346, 468);
    
    _putDontNest(result, 312, 438);
    
    _putDontNest(result, 358, 468);
    
    _putDontNest(result, 378, 448);
    
    _putDontNest(result, 366, 468);
    
    _putDontNest(result, 312, 386);
    
    _putDontNest(result, 356, 458);
    
    _putDontNest(result, 376, 458);
    
    _putDontNest(result, 358, 448);
    
    _putDontNest(result, 368, 458);
    
    _putDontNest(result, 312, 402);
    
    _putDontNest(result, 378, 468);
    
    _putDontNest(result, 366, 448);
    
    _putDontNest(result, 336, 386);
    
    _putDontNest(result, 356, 438);
    
    _putDontNest(result, 368, 418);
    
    _putDontNest(result, 366, 428);
    
    _putDontNest(result, 328, 402);
    
    _putDontNest(result, 376, 418);
    
    _putDontNest(result, 358, 428);
    
    _putDontNest(result, 402, 376);
    
    _putDontNest(result, 348, 386);
    
    _putDontNest(result, 336, 402);
    
    _putDontNest(result, 346, 392);
    
    _putDontNest(result, 378, 428);
    
    _putDontNest(result, 368, 438);
    
    _putDontNest(result, 356, 418);
    
    _putDontNest(result, 386, 376);
    
    _putDontNest(result, 328, 386);
    
    _putDontNest(result, 338, 392);
    
    _putDontNest(result, 376, 438);
    
    _putDontNest(result, 348, 402);
    
    _putDontNest(result, 336, 418);
    
    _putDontNest(result, 366, 392);
    
    _putDontNest(result, 356, 402);
    
    _putDontNest(result, 376, 386);
    
    _putDontNest(result, 402, 408);
    
    _putDontNest(result, 358, 392);
    
    _putDontNest(result, 348, 418);
    
    _putDontNest(result, 328, 438);
    
    _putDontNest(result, 312, 458);
    
    _putDontNest(result, 346, 428);
    
    _putDontNest(result, 356, 386);
    
    _putDontNest(result, 336, 438);
    
    _putDontNest(result, 328, 418);
    
    _putDontNest(result, 386, 408);
    
    _putDontNest(result, 348, 438);
    
    _putDontNest(result, 376, 402);
    
    _putDontNest(result, 338, 428);
    
    _putDontNest(result, 428, 428);
    
    _putDontNest(result, 402, 386);
    
    _putDontNest(result, 386, 402);
    
    _putDontNest(result, 458, 458);
    
    _putDontNest(result, 366, 366);
    
    _putDontNest(result, 376, 408);
    
    _putDontNest(result, 418, 438);
    
    _putDontNest(result, 448, 468);
    
    _putDontNest(result, 348, 376);
    
    _putDontNest(result, 438, 418);
    
    _putDontNest(result, 468, 448);
    
    _putDontNest(result, 420, 428);
    
    _putDontNest(result, 460, 468);
    
    _putDontNest(result, 450, 458);
    
    _putDontNest(result, 430, 438);
    
    _putDontNest(result, 336, 376);
    
    _putDontNest(result, 402, 402);
    
    _putDontNest(result, 356, 356);
    
    _putDontNest(result, 336, 336);
    
    _putDontNest(result, 408, 392);
    
    _putDontNest(result, 386, 386);
    
    _putDontNest(result, 448, 448);
    
    _putDontNest(result, 468, 468);
    
    _putDontNest(result, 418, 418);
    
    _putDontNest(result, 328, 376);
    
    _putDontNest(result, 438, 438);
    
    _putDontNest(result, 440, 428);
    
    _putDontNest(result, 356, 408);
    
    _putDontNest(result, 430, 418);
    
    _putDontNest(result, 460, 448);
    
    _putDontNest(result, 376, 376);
    
    _putDontNest(result, 402, 418);
    
    _putDontNest(result, 348, 408);
    
    _putDontNest(result, 336, 356);
    
    _putDontNest(result, 356, 336);
    
    _putDontNest(result, 386, 438);
    
    _putDontNest(result, 392, 428);
    
    _putDontNest(result, 410, 418);
    
    _putDontNest(result, 336, 408);
    
    _putDontNest(result, 394, 438);
    
    _putDontNest(result, 328, 408);
    
    _putDontNest(result, 386, 418);
    
    _putDontNest(result, 408, 428);
    
    _putDontNest(result, 346, 366);
    
    _putDontNest(result, 402, 438);
    
    _putDontNest(result, 394, 418);
    
    _putDontNest(result, 410, 438);
    
    _putDontNest(result, 356, 376);
    
    _putDontNest(result, 312, 408);
    
    _putDontNest(result, 394, 458);
    
    _putDontNest(result, 408, 448);
    
    _putDontNest(result, 386, 458);
    
    _putDontNest(result, 312, 356);
    
    _putDontNest(result, 392, 468);
    
    _putDontNest(result, 410, 458);
    
    _putDontNest(result, 366, 346);
    
    _putDontNest(result, 392, 448);
    
    _putDontNest(result, 402, 458);
    
    _putDontNest(result, 408, 468);
    
    _putDontNest(result, 460, 428);
    
    _putDontNest(result, 312, 376);
    
    _putDontNest(result, 346, 346);
    
    _putDontNest(result, 420, 468);
    
    _putDontNest(result, 430, 458);
    
    _putDontNest(result, 450, 438);
    
    _putDontNest(result, 440, 448);
    
    _putDontNest(result, 428, 468);
    
    _putDontNest(result, 418, 458);
    
    _putDontNest(result, 458, 438);
    
    _putDontNest(result, 448, 428);
    
    _putDontNest(result, 450, 418);
    
    _putDontNest(result, 420, 448);
    
    _putDontNest(result, 468, 428);
    
    _putDontNest(result, 458, 418);
    
    _putDontNest(result, 312, 336);
    
    _putDontNest(result, 440, 468);
    
    _putDontNest(result, 438, 458);
    
    _putDontNest(result, 428, 448);
    
    _putDontNest(result, 336, 448);
    
    _putDontNest(result, 348, 448);
    
    _putDontNest(result, 328, 468);
    
    _putDontNest(result, 346, 458);
    
    _putDontNest(result, 312, 428);
    
    _putDontNest(result, 336, 468);
    
    _putDontNest(result, 348, 468);
    
    _putDontNest(result, 338, 458);
    
    _putDontNest(result, 328, 448);
    
    _putDontNest(result, 356, 468);
    
    _putDontNest(result, 368, 448);
    
    _putDontNest(result, 366, 458);
    
    _putDontNest(result, 376, 448);
    
    _putDontNest(result, 358, 458);
    
    _putDontNest(result, 312, 392);
    
    _putDontNest(result, 378, 458);
    
    _putDontNest(result, 356, 448);
    
    _putDontNest(result, 368, 468);
    
    _putDontNest(result, 376, 468);
    
    _putDontNest(result, 358, 438);
    
    _putDontNest(result, 408, 376);
    
    _putDontNest(result, 338, 386);
    
    _putDontNest(result, 328, 392);
    
    _putDontNest(result, 366, 438);
    
    _putDontNest(result, 378, 418);
    
    _putDontNest(result, 346, 386);
    
    _putDontNest(result, 356, 428);
    
    _putDontNest(result, 338, 402);
    
    _putDontNest(result, 392, 376);
    
    _putDontNest(result, 376, 428);
    
    _putDontNest(result, 358, 418);
    
    _putDontNest(result, 348, 392);
    
    _putDontNest(result, 346, 402);
    
    _putDontNest(result, 336, 392);
    
    _putDontNest(result, 368, 428);
    
    _putDontNest(result, 366, 418);
    
    _putDontNest(result, 378, 438);
    
    _putDontNest(result, 338, 418);
    
    _putDontNest(result, 328, 428);
    
    _putDontNest(result, 358, 402);
    
    _putDontNest(result, 312, 448);
    
    _putDontNest(result, 346, 418);
    
    _putDontNest(result, 366, 402);
    
    _putDontNest(result, 356, 392);
    
    _putDontNest(result, 392, 408);
    
    _putDontNest(result, 376, 392);
    
    _putDontNest(result, 348, 428);
    
    _putDontNest(result, 338, 438);
    
    _putDontNest(result, 358, 386);
    
    _putDontNest(result, 346, 438);
    
    _putDontNest(result, 366, 386);
    
    _putDontNest(result, 336, 428);
    
    _putDontNest(result, 312, 468);
   return result;
  }
    
  protected static IntegerMap _initDontNestGroups() {
    IntegerMap result = org.rascalmpl.library.lang.rascal.syntax.RascalRascal._initDontNestGroups();
    int resultStoreId = result.size();
    
    
    ++resultStoreId;
    
    result.putUnsafe(430, resultStoreId);
    result.putUnsafe(428, resultStoreId);
    result.putUnsafe(460, resultStoreId);
    result.putUnsafe(378, resultStoreId);
    result.putUnsafe(410, resultStoreId);
    result.putUnsafe(394, resultStoreId);
    result.putUnsafe(458, resultStoreId);
    result.putUnsafe(440, resultStoreId);
    result.putUnsafe(438, resultStoreId);
    result.putUnsafe(468, resultStoreId);
    result.putUnsafe(420, resultStoreId);
    result.putUnsafe(418, resultStoreId);
    result.putUnsafe(450, resultStoreId);
    result.putUnsafe(448, resultStoreId);
    result.putUnsafe(368, resultStoreId);
    ++resultStoreId;
    
    result.putUnsafe(366, resultStoreId);
    result.putUnsafe(346, resultStoreId);
    result.putUnsafe(312, resultStoreId);
    result.putUnsafe(356, resultStoreId);
    result.putUnsafe(336, resultStoreId);
    ++resultStoreId;
    
    result.putUnsafe(348, resultStoreId);
    result.putUnsafe(328, resultStoreId);
    result.putUnsafe(376, resultStoreId);
    result.putUnsafe(358, resultStoreId);
    result.putUnsafe(402, resultStoreId);
    result.putUnsafe(338, resultStoreId);
    result.putUnsafe(386, resultStoreId);
    ++resultStoreId;
    
    result.putUnsafe(392, resultStoreId);
    ++resultStoreId;
    
    result.putUnsafe(408, resultStoreId);
      
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
  private static final IConstructor regular__opt__ConstSect = (IConstructor) _read("regular(opt(sort(\"ConstSect\")))", Factory.Production);
  private static final IConstructor prod__Keywords__lit_TO_ = (IConstructor) _read("prod(keywords(\"Keywords\"),[lit(\"TO\")],{})", Factory.Production);
  private static final IConstructor prod__eq_Expression__lhs_Expression_layouts_Layouts_lit___61_layouts_Layouts_rhs_Expression__assoc__non_assoc = (IConstructor) _read("prod(label(\"eq\",sort(\"Expression\")),[label(\"lhs\",sort(\"Expression\")),layouts(\"Layouts\"),lit(\"=\"),layouts(\"Layouts\"),label(\"rhs\",sort(\"Expression\"))],{assoc(\\non-assoc())})", Factory.Production);
  private static final IConstructor prod__Natural__char_class___range__49_57_char_class___range__48_57_char_class___range__48_57_conditional__char_class___range__48_57__not_follow__char_class___range__48_57_ = (IConstructor) _read("prod(lex(\"Natural\"),[\\char-class([range(49,57)]),\\char-class([range(48,57)]),\\char-class([range(48,57)]),conditional(\\char-class([range(48,57)]),{\\not-follow(\\char-class([range(48,57)]))})],{})", Factory.Production);
  private static final IConstructor regular__iter_star_seps__Ident__layouts_Layouts_lit___44_layouts_Layouts = (IConstructor) _read("regular(\\iter-star-seps(lex(\"Ident\"),[layouts(\"Layouts\"),lit(\",\"),layouts(\"Layouts\")]))", Factory.Production);
  private static final IConstructor prod__lit_ELSIF__char_class___range__69_69_char_class___range__76_76_char_class___range__83_83_char_class___range__73_73_char_class___range__70_70_ = (IConstructor) _read("prod(lit(\"ELSIF\"),[\\char-class([range(69,69)]),\\char-class([range(76,76)]),\\char-class([range(83,83)]),\\char-class([range(73,73)]),\\char-class([range(70,70)])],{})", Factory.Production);
  private static final IConstructor prod__Keywords__lit_MOD_ = (IConstructor) _read("prod(keywords(\"Keywords\"),[lit(\"MOD\")],{})", Factory.Production);
  private static final IConstructor prod__lit_ELSE__char_class___range__69_69_char_class___range__76_76_char_class___range__83_83_char_class___range__69_69_ = (IConstructor) _read("prod(lit(\"ELSE\"),[\\char-class([range(69,69)]),\\char-class([range(76,76)]),\\char-class([range(83,83)]),\\char-class([range(69,69)])],{})", Factory.Production);
  private static final IConstructor prod__Keywords__lit_VAR_ = (IConstructor) _read("prod(keywords(\"Keywords\"),[lit(\"VAR\")],{})", Factory.Production);
  private static final IConstructor prod__geq_Expression__lhs_Expression_layouts_Layouts_lit___62_61_layouts_Layouts_rhs_Expression__assoc__non_assoc = (IConstructor) _read("prod(label(\"geq\",sort(\"Expression\")),[label(\"lhs\",sort(\"Expression\")),layouts(\"Layouts\"),lit(\"\\>=\"),layouts(\"Layouts\"),label(\"rhs\",sort(\"Expression\"))],{assoc(\\non-assoc())})", Factory.Production);
  private static final IConstructor prod__lit_TYPE__char_class___range__84_84_char_class___range__89_89_char_class___range__80_80_char_class___range__69_69_ = (IConstructor) _read("prod(lit(\"TYPE\"),[\\char-class([range(84,84)]),\\char-class([range(89,89)]),\\char-class([range(80,80)]),\\char-class([range(69,69)])],{})", Factory.Production);
  private static final IConstructor prod__lookup_Expression__var_Ident_layouts_Layouts_selectors_iter_seps__Selector__layouts_Layouts_ = (IConstructor) _read("prod(label(\"lookup\",sort(\"Expression\")),[label(\"var\",lex(\"Ident\")),layouts(\"Layouts\"),label(\"selectors\",\\iter-seps(sort(\"Selector\"),[layouts(\"Layouts\")]))],{})", Factory.Production);
  private static final IConstructor prod__Keywords__lit_ELSE_ = (IConstructor) _read("prod(keywords(\"Keywords\"),[lit(\"ELSE\")],{})", Factory.Production);
  private static final IConstructor prod__Natural__char_class___range__49_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_conditional__char_class___range__48_57__not_follow__char_class___range__48_57_ = (IConstructor) _read("prod(lex(\"Natural\"),[\\char-class([range(49,57)]),\\char-class([range(48,57)]),\\char-class([range(48,57)]),\\char-class([range(48,57)]),\\char-class([range(48,57)]),\\char-class([range(48,57)]),conditional(\\char-class([range(48,57)]),{\\not-follow(\\char-class([range(48,57)]))})],{})", Factory.Production);
  private static final IConstructor prod__lit_OR__char_class___range__79_79_char_class___range__82_82_ = (IConstructor) _read("prod(lit(\"OR\"),[\\char-class([range(79,79)]),\\char-class([range(82,82)])],{})", Factory.Production);
  private static final IConstructor prod__array_Type__lit_ARRAY_layouts_Layouts_exp_Expression_layouts_Layouts_lit_OF_layouts_Layouts_type_Type_ = (IConstructor) _read("prod(label(\"array\",sort(\"Type\")),[lit(\"ARRAY\"),layouts(\"Layouts\"),label(\"exp\",sort(\"Expression\")),layouts(\"Layouts\"),lit(\"OF\"),layouts(\"Layouts\"),label(\"type\",sort(\"Type\"))],{})", Factory.Production);
  private static final IConstructor prod__call_Statement__name_Ident_layouts_Layouts_actuals_opt__Actuals_ = (IConstructor) _read("prod(label(\"call\",sort(\"Statement\")),[label(\"name\",lex(\"Ident\")),layouts(\"Layouts\"),label(\"actuals\",opt(sort(\"Actuals\")))],{})", Factory.Production);
  private static final IConstructor prod__Keywords__lit_THEN_ = (IConstructor) _read("prod(keywords(\"Keywords\"),[lit(\"THEN\")],{})", Factory.Production);
  private static final IConstructor prod__Formals__lit___40_layouts_Layouts_formals_iter_star_seps__Formal__layouts_Layouts_lit___59_layouts_Layouts_layouts_Layouts_lit___41_ = (IConstructor) _read("prod(sort(\"Formals\"),[lit(\"(\"),layouts(\"Layouts\"),label(\"formals\",\\iter-star-seps(sort(\"Formal\"),[layouts(\"Layouts\"),lit(\";\"),layouts(\"Layouts\")])),layouts(\"Layouts\"),lit(\")\")],{})", Factory.Production);
  private static final IConstructor regular__opt__Formals = (IConstructor) _read("regular(opt(sort(\"Formals\")))", Factory.Production);
  private static final IConstructor prod__guard_Case__iter_seps__Label__layouts_Layouts_lit___44_layouts_Layouts_layouts_Layouts_lit___58_layouts_Layouts_body_iter_seps__Statement__layouts_Layouts_lit___59_layouts_Layouts_ = (IConstructor) _read("prod(label(\"guard\",sort(\"Case\")),[\\iter-seps(sort(\"Label\"),[layouts(\"Layouts\"),lit(\",\"),layouts(\"Layouts\")]),layouts(\"Layouts\"),lit(\":\"),layouts(\"Layouts\"),label(\"body\",\\iter-seps(sort(\"Statement\"),[layouts(\"Layouts\"),lit(\";\"),layouts(\"Layouts\")]))],{})", Factory.Production);
  private static final IConstructor regular__iter_star__char_class___range__48_57_range__65_90_range__97_122 = (IConstructor) _read("regular(\\iter-star(\\char-class([range(48,57),range(65,90),range(97,122)])))", Factory.Production);
  private static final IConstructor prod__typeDecl_TypeDecl__name_Ident_layouts_Layouts_lit___61_layouts_Layouts_type_Type_layouts_Layouts_lit___59_ = (IConstructor) _read("prod(label(\"typeDecl\",sort(\"TypeDecl\")),[label(\"name\",lex(\"Ident\")),layouts(\"Layouts\"),lit(\"=\"),layouts(\"Layouts\"),label(\"type\",sort(\"Type\")),layouts(\"Layouts\"),lit(\";\")],{})", Factory.Production);
  private static final IConstructor prod__decls_Declarations__consts_opt__ConstSect_layouts_Layouts_types_opt__TypeSect_layouts_Layouts_vars_opt__VarSect_ = (IConstructor) _read("prod(label(\"decls\",sort(\"Declarations\")),[label(\"consts\",opt(sort(\"ConstSect\"))),layouts(\"Layouts\"),label(\"types\",opt(sort(\"TypeSect\"))),layouts(\"Layouts\"),label(\"vars\",opt(sort(\"VarSect\")))],{})", Factory.Production);
  private static final IConstructor prod__empty_Field__ = (IConstructor) _read("prod(label(\"empty\",sort(\"Field\")),[],{})", Factory.Production);
  private static final IConstructor prod__Keywords__lit_UNTIL_ = (IConstructor) _read("prod(keywords(\"Keywords\"),[lit(\"UNTIL\")],{})", Factory.Production);
  private static final IConstructor prod__Keywords__lit_TYPE_ = (IConstructor) _read("prod(keywords(\"Keywords\"),[lit(\"TYPE\")],{})", Factory.Production);
  private static final IConstructor prod__Keywords__lit_RECORD_ = (IConstructor) _read("prod(keywords(\"Keywords\"),[lit(\"RECORD\")],{})", Factory.Production);
  private static final IConstructor regular__iter_seps__Label__layouts_Layouts_lit___44_layouts_Layouts = (IConstructor) _read("regular(\\iter-seps(sort(\"Label\"),[layouts(\"Layouts\"),lit(\",\"),layouts(\"Layouts\")]))", Factory.Production);
  private static final IConstructor prod__Keywords__lit_BEGIN_ = (IConstructor) _read("prod(keywords(\"Keywords\"),[lit(\"BEGIN\")],{})", Factory.Production);
  private static final IConstructor prod__assign_Statement__var_Ident_layouts_Layouts_lit___58_61_layouts_Layouts_exp_Expression_ = (IConstructor) _read("prod(label(\"assign\",sort(\"Statement\")),[label(\"var\",lex(\"Ident\")),layouts(\"Layouts\"),lit(\":=\"),layouts(\"Layouts\"),label(\"exp\",sort(\"Expression\"))],{})", Factory.Production);
  private static final IConstructor prod__lit_FOR__char_class___range__70_70_char_class___range__79_79_char_class___range__82_82_ = (IConstructor) _read("prod(lit(\"FOR\"),[\\char-class([range(70,70)]),\\char-class([range(79,79)]),\\char-class([range(82,82)])],{})", Factory.Production);
  private static final IConstructor regular__iter_seps__Selector__layouts_Layouts = (IConstructor) _read("regular(\\iter-seps(sort(\"Selector\"),[layouts(\"Layouts\")]))", Factory.Production);
  private static final IConstructor regular__iter_seps__ProcedureDecl__layouts_Layouts = (IConstructor) _read("regular(\\iter-seps(sort(\"ProcedureDecl\"),[layouts(\"Layouts\")]))", Factory.Production);
  private static final IConstructor prod__Natural__char_class___range__49_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_conditional__char_class___range__48_57__not_follow__char_class___range__48_57_ = (IConstructor) _read("prod(lex(\"Natural\"),[\\char-class([range(49,57)]),\\char-class([range(48,57)]),\\char-class([range(48,57)]),\\char-class([range(48,57)]),\\char-class([range(48,57)]),\\char-class([range(48,57)]),\\char-class([range(48,57)]),conditional(\\char-class([range(48,57)]),{\\not-follow(\\char-class([range(48,57)]))})],{})", Factory.Production);
  private static final IConstructor prod__Keywords__lit_REPEAT_ = (IConstructor) _read("prod(keywords(\"Keywords\"),[lit(\"REPEAT\")],{})", Factory.Production);
  private static final IConstructor prod__lit___46_46__char_class___range__46_46_char_class___range__46_46_ = (IConstructor) _read("prod(lit(\"..\"),[\\char-class([range(46,46)]),\\char-class([range(46,46)])],{})", Factory.Production);
  private static final IConstructor regular__seq___conditional__char_class___range__65_90_range__97_122__not_precede__char_class___range__65_90_range__97_122_conditional__iter_star__char_class___range__48_57_range__65_90_range__97_122__not_follow__char_class___range__48_57_range__65_90_range__97_122 = (IConstructor) _read("regular(seq([conditional(\\char-class([range(65,90),range(97,122)]),{\\not-precede(\\char-class([range(65,90),range(97,122)]))}),conditional(\\iter-star(\\char-class([range(48,57),range(65,90),range(97,122)])),{\\not-follow(\\char-class([range(48,57),range(65,90),range(97,122)]))})]))", Factory.Production);
  private static final IConstructor regular__iter_star__char_class___range__9_10_range__13_13_range__32_32 = (IConstructor) _read("regular(\\iter-star(\\char-class([range(9,10),range(13,13),range(32,32)])))", Factory.Production);
  private static final IConstructor regular__iter_seps__Field__layouts_Layouts_lit___59_layouts_Layouts = (IConstructor) _read("regular(\\iter-seps(sort(\"Field\"),[layouts(\"Layouts\"),lit(\";\"),layouts(\"Layouts\")]))", Factory.Production);
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
  private static final IConstructor prod__lit_ARRAY__char_class___range__65_65_char_class___range__82_82_char_class___range__82_82_char_class___range__65_65_char_class___range__89_89_ = (IConstructor) _read("prod(lit(\"ARRAY\"),[\\char-class([range(65,65)]),\\char-class([range(82,82)]),\\char-class([range(82,82)]),\\char-class([range(65,65)]),\\char-class([range(89,89)])],{})", Factory.Production);
  private static final IConstructor prod__lit___59__char_class___range__59_59_ = (IConstructor) _read("prod(lit(\";\"),[\\char-class([range(59,59)])],{})", Factory.Production);
  private static final IConstructor regular__iter_star_seps__ConstDecl__layouts_Layouts = (IConstructor) _read("regular(\\iter-star-seps(sort(\"ConstDecl\"),[layouts(\"Layouts\")]))", Factory.Production);
  private static final IConstructor prod__lit___58__char_class___range__58_58_ = (IConstructor) _read("prod(lit(\":\"),[\\char-class([range(58,58)])],{})", Factory.Production);
  private static final IConstructor prod__lit___61__char_class___range__61_61_ = (IConstructor) _read("prod(lit(\"=\"),[\\char-class([range(61,61)])],{})", Factory.Production);
  private static final IConstructor prod__lit___60__char_class___range__60_60_ = (IConstructor) _read("prod(lit(\"\\<\"),[\\char-class([range(60,60)])],{})", Factory.Production);
  private static final IConstructor prod__lit___62__char_class___range__62_62_ = (IConstructor) _read("prod(lit(\"\\>\"),[\\char-class([range(62,62)])],{})", Factory.Production);
  private static final IConstructor prod__skip_Statement__ = (IConstructor) _read("prod(label(\"skip\",sort(\"Statement\")),[],{})", Factory.Production);
  private static final IConstructor prod__lit_UNTIL__char_class___range__85_85_char_class___range__78_78_char_class___range__84_84_char_class___range__73_73_char_class___range__76_76_ = (IConstructor) _read("prod(lit(\"UNTIL\"),[\\char-class([range(85,85)]),\\char-class([range(78,78)]),\\char-class([range(84,84)]),\\char-class([range(73,73)]),\\char-class([range(76,76)])],{})", Factory.Production);
  private static final IConstructor regular__opt__TypeSect = (IConstructor) _read("regular(opt(sort(\"TypeSect\")))", Factory.Production);
  private static final IConstructor regular__seq___lit_BY_layouts_Layouts_Expression = (IConstructor) _read("regular(seq([lit(\"BY\"),layouts(\"Layouts\"),sort(\"Expression\")]))", Factory.Production);
  private static final IConstructor prod__range_Label__from_Expression_layouts_Layouts_lit___46_46_layouts_Layouts_to_Expression_ = (IConstructor) _read("prod(label(\"range\",sort(\"Label\")),[label(\"from\",sort(\"Expression\")),layouts(\"Layouts\"),lit(\"..\"),layouts(\"Layouts\"),label(\"to\",sort(\"Expression\"))],{})", Factory.Production);
  private static final IConstructor prod__empty__ = (IConstructor) _read("prod(empty(),[],{})", Factory.Production);
  private static final IConstructor prod__lit___40_42__char_class___range__40_40_char_class___range__42_42_ = (IConstructor) _read("prod(lit(\"(*\"),[\\char-class([range(40,40)]),\\char-class([range(42,42)])],{})", Factory.Production);
  private static final IConstructor prod__nat_Expression__value_Natural_ = (IConstructor) _read("prod(label(\"nat\",sort(\"Expression\")),[label(\"value\",lex(\"Natural\"))],{})", Factory.Production);
  private static final IConstructor prod__field_Selector__lit___46_layouts_Layouts_field_Ident_ = (IConstructor) _read("prod(label(\"field\",sort(\"Selector\")),[lit(\".\"),layouts(\"Layouts\"),label(\"field\",lex(\"Ident\"))],{})", Factory.Production);
  private static final IConstructor prod__decls_Declarations__consts_opt__ConstSect_layouts_Layouts_types_opt__TypeSect_layouts_Layouts_vars_opt__VarSect_layouts_Layouts_procs_iter_seps__ProcedureDecl__layouts_Layouts_ = (IConstructor) _read("prod(label(\"decls\",sort(\"Declarations\")),[label(\"consts\",opt(sort(\"ConstSect\"))),layouts(\"Layouts\"),label(\"types\",opt(sort(\"TypeSect\"))),layouts(\"Layouts\"),label(\"vars\",opt(sort(\"VarSect\"))),layouts(\"Layouts\"),label(\"procs\",\\iter-seps(sort(\"ProcedureDecl\"),[layouts(\"Layouts\")]))],{})", Factory.Production);
  private static final IConstructor prod__lit___41__char_class___range__41_41_ = (IConstructor) _read("prod(lit(\")\"),[\\char-class([range(41,41)])],{})", Factory.Production);
  private static final IConstructor prod__lit___40__char_class___range__40_40_ = (IConstructor) _read("prod(lit(\"(\"),[\\char-class([range(40,40)])],{})", Factory.Production);
  private static final IConstructor prod__Keywords__lit_ARRAY_ = (IConstructor) _read("prod(keywords(\"Keywords\"),[lit(\"ARRAY\")],{})", Factory.Production);
  private static final IConstructor prod__lit___43__char_class___range__43_43_ = (IConstructor) _read("prod(lit(\"+\"),[\\char-class([range(43,43)])],{})", Factory.Production);
  private static final IConstructor prod__lit___42__char_class___range__42_42_ = (IConstructor) _read("prod(lit(\"*\"),[\\char-class([range(42,42)])],{})", Factory.Production);
  private static final IConstructor prod__Keywords__lit_MODULE_ = (IConstructor) _read("prod(keywords(\"Keywords\"),[lit(\"MODULE\")],{})", Factory.Production);
  private static final IConstructor prod__lit____char_class___range__45_45_ = (IConstructor) _read("prod(lit(\"-\"),[\\char-class([range(45,45)])],{})", Factory.Production);
  private static final IConstructor prod__lit_IF__char_class___range__73_73_char_class___range__70_70_ = (IConstructor) _read("prod(lit(\"IF\"),[\\char-class([range(73,73)]),\\char-class([range(70,70)])],{})", Factory.Production);
  private static final IConstructor prod__lit___44__char_class___range__44_44_ = (IConstructor) _read("prod(lit(\",\"),[\\char-class([range(44,44)])],{})", Factory.Production);
  private static final IConstructor prod__Bracket_Expression__lit___40_layouts_Layouts_exp_Expression_layouts_Layouts_lit___41__bracket = (IConstructor) _read("prod(label(\"Bracket\",sort(\"Expression\")),[lit(\"(\"),layouts(\"Layouts\"),label(\"exp\",sort(\"Expression\")),layouts(\"Layouts\"),lit(\")\")],{bracket()})", Factory.Production);
  private static final IConstructor regular__iter_star_seps__Expression__layouts_Layouts_lit___44_layouts_Layouts = (IConstructor) _read("regular(\\iter-star-seps(sort(\"Expression\"),[layouts(\"Layouts\"),lit(\",\"),layouts(\"Layouts\")]))", Factory.Production);
  private static final IConstructor prod__lit___46__char_class___range__46_46_ = (IConstructor) _read("prod(lit(\".\"),[\\char-class([range(46,46)])],{})", Factory.Production);
  private static final IConstructor prod__subscript_Selector__lit___91_layouts_Layouts_exp_Expression_layouts_Layouts_lit___93_ = (IConstructor) _read("prod(label(\"subscript\",sort(\"Selector\")),[lit(\"[\"),layouts(\"Layouts\"),label(\"exp\",sort(\"Expression\")),layouts(\"Layouts\"),lit(\"]\")],{})", Factory.Production);
  private static final IConstructor prod__Natural__char_class___range__49_50_char_class___range__48_49_char_class___range__48_52_char_class___range__48_55_char_class___range__48_52_char_class___range__48_56_char_class___range__48_51_char_class___range__48_54_char_class___range__48_52_conditional__char_class___range__48_55__not_follow__char_class___range__48_57_ = (IConstructor) _read("prod(lex(\"Natural\"),[\\char-class([range(49,50)]),\\char-class([range(48,49)]),\\char-class([range(48,52)]),\\char-class([range(48,55)]),\\char-class([range(48,52)]),\\char-class([range(48,56)]),\\char-class([range(48,51)]),\\char-class([range(48,54)]),\\char-class([range(48,52)]),conditional(\\char-class([range(48,55)]),{\\not-follow(\\char-class([range(48,57)]))})],{})", Factory.Production);
  private static final IConstructor prod__lit___35__char_class___range__35_35_ = (IConstructor) _read("prod(lit(\"#\"),[\\char-class([range(35,35)])],{})", Factory.Production);
  private static final IConstructor prod__Natural__conditional__char_class___range__48_57__not_follow__char_class___range__48_57_ = (IConstructor) _read("prod(lex(\"Natural\"),[conditional(\\char-class([range(48,57)]),{\\not-follow(\\char-class([range(48,57)]))})],{})", Factory.Production);
  private static final IConstructor prod__lit___38__char_class___range__38_38_ = (IConstructor) _read("prod(lit(\"&\"),[\\char-class([range(38,38)])],{})", Factory.Production);
  private static final IConstructor regular__iter__CommentChar = (IConstructor) _read("regular(iter(lex(\"CommentChar\")))", Factory.Production);
  private static final IConstructor prod__lit_DIV__char_class___range__68_68_char_class___range__73_73_char_class___range__86_86_ = (IConstructor) _read("prod(lit(\"DIV\"),[\\char-class([range(68,68)]),\\char-class([range(73,73)]),\\char-class([range(86,86)])],{})", Factory.Production);
  private static final IConstructor prod__lit___91__char_class___range__91_91_ = (IConstructor) _read("prod(lit(\"[\"),[\\char-class([range(91,91)])],{})", Factory.Production);
  private static final IConstructor prod__lit_MODULE__char_class___range__77_77_char_class___range__79_79_char_class___range__68_68_char_class___range__85_85_char_class___range__76_76_char_class___range__69_69_ = (IConstructor) _read("prod(lit(\"MODULE\"),[\\char-class([range(77,77)]),\\char-class([range(79,79)]),\\char-class([range(68,68)]),\\char-class([range(85,85)]),\\char-class([range(76,76)]),\\char-class([range(69,69)])],{})", Factory.Production);
  private static final IConstructor regular__opt__lit_VAR = (IConstructor) _read("regular(opt(lit(\"VAR\")))", Factory.Production);
  private static final IConstructor prod__caseOf_Statement__lit_CASE_layouts_Layouts_exp_Expression_layouts_Layouts_lit_OF_layouts_Layouts_cases_iter_seps__Case__layouts_Layouts_lit___124_layouts_Layouts_layouts_Layouts_elsePart_opt__ElsePart_layouts_Layouts_lit_END_ = (IConstructor) _read("prod(label(\"caseOf\",sort(\"Statement\")),[lit(\"CASE\"),layouts(\"Layouts\"),label(\"exp\",sort(\"Expression\")),layouts(\"Layouts\"),lit(\"OF\"),layouts(\"Layouts\"),label(\"cases\",\\iter-seps(sort(\"Case\"),[layouts(\"Layouts\"),lit(\"|\"),layouts(\"Layouts\")])),layouts(\"Layouts\"),label(\"elsePart\",opt(sort(\"ElsePart\"))),layouts(\"Layouts\"),lit(\"END\")],{})", Factory.Production);
  private static final IConstructor prod__lookup_Expression__var_Ident_ = (IConstructor) _read("prod(label(\"lookup\",sort(\"Expression\")),[label(\"var\",lex(\"Ident\"))],{})", Factory.Production);
  private static final IConstructor prod__lit___93__char_class___range__93_93_ = (IConstructor) _read("prod(lit(\"]\"),[\\char-class([range(93,93)])],{})", Factory.Production);
  private static final IConstructor prod__neg_Expression__lit___layouts_Layouts_exp_Expression__assoc__right = (IConstructor) _read("prod(label(\"neg\",sort(\"Expression\")),[lit(\"-\"),layouts(\"Layouts\"),label(\"exp\",sort(\"Expression\"))],{assoc(right())})", Factory.Production);
  private static final IConstructor prod__div_Expression__lhs_Expression_layouts_Layouts_lit_DIV_layouts_Layouts_rhs_Expression__assoc__left = (IConstructor) _read("prod(label(\"div\",sort(\"Expression\")),[label(\"lhs\",sort(\"Expression\")),layouts(\"Layouts\"),lit(\"DIV\"),layouts(\"Layouts\"),label(\"rhs\",sort(\"Expression\"))],{assoc(left())})", Factory.Production);
  private static final IConstructor prod__lit_VAR__char_class___range__86_86_char_class___range__65_65_char_class___range__82_82_ = (IConstructor) _read("prod(lit(\"VAR\"),[\\char-class([range(86,86)]),\\char-class([range(65,65)]),\\char-class([range(82,82)])],{})", Factory.Production);
  private static final IConstructor prod__Actuals__lit___40_layouts_Layouts_expressions_iter_star_seps__Expression__layouts_Layouts_lit___44_layouts_Layouts_layouts_Layouts_lit___41_ = (IConstructor) _read("prod(sort(\"Actuals\"),[lit(\"(\"),layouts(\"Layouts\"),label(\"expressions\",\\iter-star-seps(sort(\"Expression\"),[layouts(\"Layouts\"),lit(\",\"),layouts(\"Layouts\")])),layouts(\"Layouts\"),lit(\")\")],{})", Factory.Production);
  private static final IConstructor prod__start__Module__layouts_Layouts_top_Module_layouts_Layouts_ = (IConstructor) _read("prod(start(sort(\"Module\")),[layouts(\"Layouts\"),label(\"top\",sort(\"Module\")),layouts(\"Layouts\")],{})", Factory.Production);
  private static final IConstructor prod__expression_Label__exp_Expression_ = (IConstructor) _read("prod(label(\"expression\",sort(\"Label\")),[label(\"exp\",sort(\"Expression\"))],{})", Factory.Production);
  private static final IConstructor prod__record_Type__lit_RECORD_layouts_Layouts_fields_iter_seps__Field__layouts_Layouts_lit___59_layouts_Layouts_layouts_Layouts_lit_END_ = (IConstructor) _read("prod(label(\"record\",sort(\"Type\")),[lit(\"RECORD\"),layouts(\"Layouts\"),label(\"fields\",\\iter-seps(sort(\"Field\"),[layouts(\"Layouts\"),lit(\";\"),layouts(\"Layouts\")])),layouts(\"Layouts\"),lit(\"END\")],{})", Factory.Production);
  private static final IConstructor prod__lit_TO__char_class___range__84_84_char_class___range__79_79_ = (IConstructor) _read("prod(lit(\"TO\"),[\\char-class([range(84,84)]),\\char-class([range(79,79)])],{})", Factory.Production);
  private static final IConstructor prod__CommentElt__iter__CommentChar_ = (IConstructor) _read("prod(lex(\"CommentElt\"),[iter(lex(\"CommentChar\"))],{})", Factory.Production);
  private static final IConstructor prod__Layout__Comment__tag__category___67_111_109_109_101_110_116 = (IConstructor) _read("prod(lex(\"Layout\"),[lex(\"Comment\")],{tag(category(\"Comment\"))})", Factory.Production);
  private static final IConstructor prod__VarSect__lit_VAR_layouts_Layouts_vars_iter_star_seps__VarDecl__layouts_Layouts__tag__Foldable = (IConstructor) _read("prod(sort(\"VarSect\"),[lit(\"VAR\"),layouts(\"Layouts\"),label(\"vars\",\\iter-star-seps(sort(\"VarDecl\"),[layouts(\"Layouts\")]))],{tag(Foldable())})", Factory.Production);
  private static final IConstructor regular__opt__seq___lit_BY_layouts_Layouts_Expression = (IConstructor) _read("regular(opt(seq([lit(\"BY\"),layouts(\"Layouts\"),sort(\"Expression\")])))", Factory.Production);
  private static final IConstructor regular__opt__Body = (IConstructor) _read("regular(opt(sort(\"Body\")))", Factory.Production);
  private static final IConstructor prod__Natural__char_class___range__49_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_conditional__char_class___range__48_57__not_follow__char_class___range__48_57_ = (IConstructor) _read("prod(lex(\"Natural\"),[\\char-class([range(49,57)]),\\char-class([range(48,57)]),\\char-class([range(48,57)]),\\char-class([range(48,57)]),\\char-class([range(48,57)]),conditional(\\char-class([range(48,57)]),{\\not-follow(\\char-class([range(48,57)]))})],{})", Factory.Production);
  private static final IConstructor prod__field_Field__names_iter_seps__Ident__layouts_Layouts_lit___44_layouts_Layouts_layouts_Layouts_lit___58_layouts_Layouts_type_Type_ = (IConstructor) _read("prod(label(\"field\",sort(\"Field\")),[label(\"names\",\\iter-seps(lex(\"Ident\"),[layouts(\"Layouts\"),lit(\",\"),layouts(\"Layouts\")])),layouts(\"Layouts\"),lit(\":\"),layouts(\"Layouts\"),label(\"type\",sort(\"Type\"))],{})", Factory.Production);
  private static final IConstructor prod__lit_CONST__char_class___range__67_67_char_class___range__79_79_char_class___range__78_78_char_class___range__83_83_char_class___range__84_84_ = (IConstructor) _read("prod(lit(\"CONST\"),[\\char-class([range(67,67)]),\\char-class([range(79,79)]),\\char-class([range(78,78)]),\\char-class([range(83,83)]),\\char-class([range(84,84)])],{})", Factory.Production);
  private static final IConstructor regular__iter_seps__Case__layouts_Layouts_lit___124_layouts_Layouts = (IConstructor) _read("regular(\\iter-seps(sort(\"Case\"),[layouts(\"Layouts\"),lit(\"|\"),layouts(\"Layouts\")]))", Factory.Production);
  private static final IConstructor prod__Keywords__lit_FOR_ = (IConstructor) _read("prod(keywords(\"Keywords\"),[lit(\"FOR\")],{})", Factory.Production);
  private static final IConstructor prod__lit___126__char_class___range__126_126_ = (IConstructor) _read("prod(lit(\"~\"),[\\char-class([range(126,126)])],{})", Factory.Production);
  private static final IConstructor prod__Natural__char_class___range__49_57_char_class___range__48_57_conditional__char_class___range__48_57__not_follow__char_class___range__48_57_ = (IConstructor) _read("prod(lex(\"Natural\"),[\\char-class([range(49,57)]),\\char-class([range(48,57)]),conditional(\\char-class([range(48,57)]),{\\not-follow(\\char-class([range(48,57)]))})],{})", Factory.Production);
  private static final IConstructor prod__lit___124__char_class___range__124_124_ = (IConstructor) _read("prod(lit(\"|\"),[\\char-class([range(124,124)])],{})", Factory.Production);
  private static final IConstructor prod__lit_RECORD__char_class___range__82_82_char_class___range__69_69_char_class___range__67_67_char_class___range__79_79_char_class___range__82_82_char_class___range__68_68_ = (IConstructor) _read("prod(lit(\"RECORD\"),[\\char-class([range(82,82)]),\\char-class([range(69,69)]),\\char-class([range(67,67)]),\\char-class([range(79,79)]),\\char-class([range(82,82)]),\\char-class([range(68,68)])],{})", Factory.Production);
  private static final IConstructor prod__lit___58_61__char_class___range__58_58_char_class___range__61_61_ = (IConstructor) _read("prod(lit(\":=\"),[\\char-class([range(58,58)]),\\char-class([range(61,61)])],{})", Factory.Production);
  private static final IConstructor prod__Comment__lit___40_42_iter_star__CommentElt_lit___42_41_ = (IConstructor) _read("prod(lex(\"Comment\"),[lit(\"(*\"),\\iter-star(lex(\"CommentElt\")),lit(\"*)\")],{})", Factory.Production);
  private static final IConstructor prod__whitespace_Layout__char_class___range__9_10_range__13_13_range__32_32_ = (IConstructor) _read("prod(label(\"whitespace\",lex(\"Layout\")),[\\char-class([range(9,10),range(13,13),range(32,32)])],{})", Factory.Production);
  private static final IConstructor prod__add_Expression__lhs_Expression_layouts_Layouts_lit___43_layouts_Layouts_rhs_Expression__assoc__left = (IConstructor) _read("prod(label(\"add\",sort(\"Expression\")),[label(\"lhs\",sort(\"Expression\")),layouts(\"Layouts\"),lit(\"+\"),layouts(\"Layouts\"),label(\"rhs\",sort(\"Expression\"))],{assoc(left())})", Factory.Production);
  private static final IConstructor prod__user_Type__name_Ident_ = (IConstructor) _read("prod(label(\"user\",sort(\"Type\")),[label(\"name\",lex(\"Ident\"))],{})", Factory.Production);
  private static final IConstructor prod__Keywords__lit_PROCEDURE_ = (IConstructor) _read("prod(keywords(\"Keywords\"),[lit(\"PROCEDURE\")],{})", Factory.Production);
  private static final IConstructor prod__layouts_Layouts__conditional__iter_star__Layout__not_follow__char_class___range__9_10_range__13_13_range__32_32_not_follow__lit___40_42_ = (IConstructor) _read("prod(layouts(\"Layouts\"),[conditional(\\iter-star(lex(\"Layout\")),{\\not-follow(\\char-class([range(9,10),range(13,13),range(32,32)])),\\not-follow(lit(\"(*\"))})],{})", Factory.Production);
  private static final IConstructor prod__Keywords__lit_WHILE_ = (IConstructor) _read("prod(keywords(\"Keywords\"),[lit(\"WHILE\")],{})", Factory.Production);
  private static final IConstructor prod__assign_Statement__var_Ident_layouts_Layouts_selectors_iter_seps__Selector__layouts_Layouts_layouts_Layouts_lit___58_61_layouts_Layouts_exp_Expression_ = (IConstructor) _read("prod(label(\"assign\",sort(\"Statement\")),[label(\"var\",lex(\"Ident\")),layouts(\"Layouts\"),label(\"selectors\",\\iter-seps(sort(\"Selector\"),[layouts(\"Layouts\")])),layouts(\"Layouts\"),lit(\":=\"),layouts(\"Layouts\"),label(\"exp\",sort(\"Expression\"))],{})", Factory.Production);
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
      
      tmp[4] = new LiteralStackNode(54, 4, prod__lit___41__char_class___range__41_41_, new int[] {41}, null, null);
      tmp[3] = new NonTerminalStackNode(52, 3, "layouts_Layouts", null, null);
      tmp[2] = new SeparatedListStackNode(42, 2, regular__iter_star_seps__Expression__layouts_Layouts_lit___44_layouts_Layouts, new NonTerminalStackNode(44, 0, "Expression", null, null), new AbstractStackNode[]{new NonTerminalStackNode(46, 1, "layouts_Layouts", null, null), new LiteralStackNode(48, 2, prod__lit___44__char_class___range__44_44_, new int[] {44}, null, null), new NonTerminalStackNode(50, 3, "layouts_Layouts", null, null)}, false, null, null);
      tmp[1] = new NonTerminalStackNode(40, 1, "layouts_Layouts", null, null);
      tmp[0] = new LiteralStackNode(38, 0, prod__lit___40__char_class___range__40_40_, new int[] {40}, null, null);
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
      
      tmp[6] = new NonTerminalStackNode(96, 6, "Type", null, null);
      tmp[5] = new NonTerminalStackNode(94, 5, "layouts_Layouts", null, null);
      tmp[4] = new LiteralStackNode(92, 4, prod__lit___58__char_class___range__58_58_, new int[] {58}, null, null);
      tmp[3] = new NonTerminalStackNode(90, 3, "layouts_Layouts", null, null);
      tmp[2] = new SeparatedListStackNode(80, 2, regular__iter_seps__Ident__layouts_Layouts_lit___44_layouts_Layouts, new NonTerminalStackNode(82, 0, "Ident", null, null), new AbstractStackNode[]{new NonTerminalStackNode(84, 1, "layouts_Layouts", null, null), new LiteralStackNode(86, 2, prod__lit___44__char_class___range__44_44_, new int[] {44}, null, null), new NonTerminalStackNode(88, 3, "layouts_Layouts", null, null)}, true, null, null);
      tmp[1] = new NonTerminalStackNode(78, 1, "layouts_Layouts", null, null);
      tmp[0] = new OptionalStackNode(74, 0, regular__opt__lit_VAR, new LiteralStackNode(76, 0, prod__lit_VAR__char_class___range__86_86_char_class___range__65_65_char_class___range__82_82_, new int[] {86,65,82}, null, null), null, null);
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
      
      tmp[14] = new LiteralStackNode(128, 14, prod__lit___46__char_class___range__46_46_, new int[] {46}, null, null);
      tmp[13] = new NonTerminalStackNode(126, 13, "layouts_Layouts", null, null);
      tmp[12] = new NonTerminalStackNode(124, 12, "Ident", null, null);
      tmp[11] = new NonTerminalStackNode(122, 11, "layouts_Layouts", null, null);
      tmp[10] = new LiteralStackNode(120, 10, prod__lit_END__char_class___range__69_69_char_class___range__78_78_char_class___range__68_68_, new int[] {69,78,68}, null, null);
      tmp[9] = new NonTerminalStackNode(118, 9, "layouts_Layouts", null, null);
      tmp[8] = new OptionalStackNode(114, 8, regular__opt__Body, new NonTerminalStackNode(116, 0, "Body", null, null), null, null);
      tmp[7] = new NonTerminalStackNode(112, 7, "layouts_Layouts", null, null);
      tmp[6] = new NonTerminalStackNode(110, 6, "Declarations", null, null);
      tmp[5] = new NonTerminalStackNode(108, 5, "layouts_Layouts", null, null);
      tmp[4] = new LiteralStackNode(106, 4, prod__lit___59__char_class___range__59_59_, new int[] {59}, null, null);
      tmp[3] = new NonTerminalStackNode(104, 3, "layouts_Layouts", null, null);
      tmp[2] = new NonTerminalStackNode(102, 2, "Ident", null, null);
      tmp[1] = new NonTerminalStackNode(100, 1, "layouts_Layouts", null, null);
      tmp[0] = new LiteralStackNode(98, 0, prod__lit_MODULE__char_class___range__77_77_char_class___range__79_79_char_class___range__68_68_char_class___range__85_85_char_class___range__76_76_char_class___range__69_69_, new int[] {77,79,68,85,76,69}, null, null);
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
      
      tmp[6] = new LiteralStackNode(142, 6, prod__lit___59__char_class___range__59_59_, new int[] {59}, null, null);
      tmp[5] = new NonTerminalStackNode(140, 5, "layouts_Layouts", null, null);
      tmp[4] = new NonTerminalStackNode(138, 4, "Expression", null, null);
      tmp[3] = new NonTerminalStackNode(136, 3, "layouts_Layouts", null, null);
      tmp[2] = new LiteralStackNode(134, 2, prod__lit___61__char_class___range__61_61_, new int[] {61}, null, null);
      tmp[1] = new NonTerminalStackNode(132, 1, "layouts_Layouts", null, null);
      tmp[0] = new NonTerminalStackNode(130, 0, "Ident", null, null);
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
      
      tmp[2] = new NonTerminalStackNode(200, 2, "layouts_Layouts", null, null);
      tmp[1] = new NonTerminalStackNode(198, 1, "Module", null, null);
      tmp[0] = new NonTerminalStackNode(196, 0, "layouts_Layouts", null, null);
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
      
      tmp[2] = new SeparatedListStackNode(210, 2, regular__iter_star_seps__ConstDecl__layouts_Layouts, new NonTerminalStackNode(212, 0, "ConstDecl", null, null), new AbstractStackNode[]{new NonTerminalStackNode(214, 1, "layouts_Layouts", null, null)}, false, null, null);
      tmp[1] = new NonTerminalStackNode(208, 1, "layouts_Layouts", null, null);
      tmp[0] = new LiteralStackNode(206, 0, prod__lit_CONST__char_class___range__67_67_char_class___range__79_79_char_class___range__78_78_char_class___range__83_83_char_class___range__84_84_, new int[] {67,79,78,83,84}, null, null);
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
      
      tmp[6] = new LiteralStackNode(228, 6, prod__lit___59__char_class___range__59_59_, new int[] {59}, null, null);
      tmp[5] = new NonTerminalStackNode(226, 5, "layouts_Layouts", null, null);
      tmp[4] = new NonTerminalStackNode(224, 4, "Type", null, null);
      tmp[3] = new NonTerminalStackNode(222, 3, "layouts_Layouts", null, null);
      tmp[2] = new LiteralStackNode(220, 2, prod__lit___61__char_class___range__61_61_, new int[] {61}, null, null);
      tmp[1] = new NonTerminalStackNode(218, 1, "layouts_Layouts", null, null);
      tmp[0] = new NonTerminalStackNode(216, 0, "Ident", null, null);
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
      
      tmp[0] = new CharStackNode(236, 0, new int[][]{{9,10},{13,13},{32,32}}, null, null);
      builder.addAlternative(Parser.prod__whitespace_Layout__char_class___range__9_10_range__13_13_range__32_32_, tmp);
	}
    protected static final void _init_prod__Layout__Comment__tag__category___67_111_109_109_101_110_116(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new NonTerminalStackNode(238, 0, "Comment", null, null);
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
      
      tmp[0] = new ListStackNode(256, 0, regular__iter_star__Layout, new NonTerminalStackNode(258, 0, "Layout", null, null), false, null, new ICompletionFilter[] {new CharFollowRestriction(new int[][]{{9,10},{13,13},{32,32}}), new StringFollowRestriction(new int[] {40,42})});
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
      
      tmp[2] = new SeparatedListStackNode(268, 2, regular__iter_star_seps__TypeDecl__layouts_Layouts, new NonTerminalStackNode(270, 0, "TypeDecl", null, null), new AbstractStackNode[]{new NonTerminalStackNode(272, 1, "layouts_Layouts", null, null)}, false, null, null);
      tmp[1] = new NonTerminalStackNode(266, 1, "layouts_Layouts", null, null);
      tmp[0] = new LiteralStackNode(264, 0, prod__lit_TYPE__char_class___range__84_84_char_class___range__89_89_char_class___range__80_80_char_class___range__69_69_, new int[] {84,89,80,69}, null, null);
      builder.addAlternative(Parser.prod__TypeSect__lit_TYPE_layouts_Layouts_types_iter_star_seps__TypeDecl__layouts_Layouts_, tmp);
	}
    public static void init(ExpectBuilder builder){
      
      
        _init_prod__TypeSect__lit_TYPE_layouts_Layouts_types_iter_star_seps__TypeDecl__layouts_Layouts_(builder);
      
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
      
      tmp[4] = new NonTerminalStackNode(448, 4, "Expression", null, null);
      tmp[3] = new NonTerminalStackNode(446, 3, "layouts_Layouts", null, null);
      tmp[2] = new LiteralStackNode(444, 2, prod__lit___35__char_class___range__35_35_, new int[] {35}, null, null);
      tmp[1] = new NonTerminalStackNode(442, 1, "layouts_Layouts", null, null);
      tmp[0] = new NonTerminalStackNode(440, 0, "Expression", null, null);
      builder.addAlternative(Parser.prod__neq_Expression__lhs_Expression_layouts_Layouts_lit___35_layouts_Layouts_rhs_Expression__assoc__non_assoc, tmp);
	}
    protected static final void _init_prod__lookup_Expression__var_Ident_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new NonTerminalStackNode(324, 0, "Ident", null, null);
      builder.addAlternative(Parser.prod__lookup_Expression__var_Ident_, tmp);
	}
    protected static final void _init_prod__or_Expression__lhs_Expression_layouts_Layouts_lit_OR_layouts_Layouts_rhs_Expression__assoc__left(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[5];
      
      tmp[0] = new NonTerminalStackNode(394, 0, "Expression", null, null);
      tmp[1] = new NonTerminalStackNode(396, 1, "layouts_Layouts", null, null);
      tmp[2] = new LiteralStackNode(398, 2, prod__lit_OR__char_class___range__79_79_char_class___range__82_82_, new int[] {79,82}, null, null);
      tmp[3] = new NonTerminalStackNode(400, 3, "layouts_Layouts", null, null);
      tmp[4] = new NonTerminalStackNode(402, 4, "Expression", null, null);
      builder.addAlternative(Parser.prod__or_Expression__lhs_Expression_layouts_Layouts_lit_OR_layouts_Layouts_rhs_Expression__assoc__left, tmp);
	}
    protected static final void _init_prod__div_Expression__lhs_Expression_layouts_Layouts_lit_DIV_layouts_Layouts_rhs_Expression__assoc__left(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[5];
      
      tmp[4] = new NonTerminalStackNode(356, 4, "Expression", null, null);
      tmp[3] = new NonTerminalStackNode(354, 3, "layouts_Layouts", null, null);
      tmp[2] = new LiteralStackNode(352, 2, prod__lit_DIV__char_class___range__68_68_char_class___range__73_73_char_class___range__86_86_, new int[] {68,73,86}, null, null);
      tmp[1] = new NonTerminalStackNode(350, 1, "layouts_Layouts", null, null);
      tmp[0] = new NonTerminalStackNode(348, 0, "Expression", null, null);
      builder.addAlternative(Parser.prod__div_Expression__lhs_Expression_layouts_Layouts_lit_DIV_layouts_Layouts_rhs_Expression__assoc__left, tmp);
	}
    protected static final void _init_prod__neg_Expression__lit___layouts_Layouts_exp_Expression__assoc__right(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[3];
      
      tmp[2] = new NonTerminalStackNode(392, 2, "Expression", null, null);
      tmp[1] = new NonTerminalStackNode(390, 1, "layouts_Layouts", null, null);
      tmp[0] = new LiteralStackNode(388, 0, prod__lit____char_class___range__45_45_, new int[] {45}, null, null);
      builder.addAlternative(Parser.prod__neg_Expression__lit___layouts_Layouts_exp_Expression__assoc__right, tmp);
	}
    protected static final void _init_prod__mod_Expression__lhs_Expression_layouts_Layouts_lit_MOD_layouts_Layouts_rhs_Expression__assoc__left(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[5];
      
      tmp[4] = new NonTerminalStackNode(366, 4, "Expression", null, null);
      tmp[3] = new NonTerminalStackNode(364, 3, "layouts_Layouts", null, null);
      tmp[2] = new LiteralStackNode(362, 2, prod__lit_MOD__char_class___range__77_77_char_class___range__79_79_char_class___range__68_68_, new int[] {77,79,68}, null, null);
      tmp[1] = new NonTerminalStackNode(360, 1, "layouts_Layouts", null, null);
      tmp[0] = new NonTerminalStackNode(358, 0, "Expression", null, null);
      builder.addAlternative(Parser.prod__mod_Expression__lhs_Expression_layouts_Layouts_lit_MOD_layouts_Layouts_rhs_Expression__assoc__left, tmp);
	}
    protected static final void _init_prod__pos_Expression__lit___43_layouts_Layouts_exp_Expression__assoc__right(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[3];
      
      tmp[2] = new NonTerminalStackNode(408, 2, "Expression", null, null);
      tmp[1] = new NonTerminalStackNode(406, 1, "layouts_Layouts", null, null);
      tmp[0] = new LiteralStackNode(404, 0, prod__lit___43__char_class___range__43_43_, new int[] {43}, null, null);
      builder.addAlternative(Parser.prod__pos_Expression__lit___43_layouts_Layouts_exp_Expression__assoc__right, tmp);
	}
    protected static final void _init_prod__nat_Expression__value_Natural_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new NonTerminalStackNode(326, 0, "Natural", null, null);
      builder.addAlternative(Parser.prod__nat_Expression__value_Natural_, tmp);
	}
    protected static final void _init_prod__not_Expression__lit___126_layouts_Layouts_exp_Expression_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[3];
      
      tmp[2] = new NonTerminalStackNode(312, 2, "Expression", null, null);
      tmp[1] = new NonTerminalStackNode(310, 1, "layouts_Layouts", null, null);
      tmp[0] = new LiteralStackNode(308, 0, prod__lit___126__char_class___range__126_126_, new int[] {126}, null, null);
      builder.addAlternative(Parser.prod__not_Expression__lit___126_layouts_Layouts_exp_Expression_, tmp);
	}
    protected static final void _init_prod__leq_Expression__lhs_Expression_layouts_Layouts_lit___60_61_layouts_Layouts_rhs_Expression__assoc__non_assoc(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[5];
      
      tmp[4] = new NonTerminalStackNode(418, 4, "Expression", null, null);
      tmp[3] = new NonTerminalStackNode(416, 3, "layouts_Layouts", null, null);
      tmp[2] = new LiteralStackNode(414, 2, prod__lit___60_61__char_class___range__60_60_char_class___range__61_61_, new int[] {60,61}, null, null);
      tmp[1] = new NonTerminalStackNode(412, 1, "layouts_Layouts", null, null);
      tmp[0] = new NonTerminalStackNode(410, 0, "Expression", null, null);
      builder.addAlternative(Parser.prod__leq_Expression__lhs_Expression_layouts_Layouts_lit___60_61_layouts_Layouts_rhs_Expression__assoc__non_assoc, tmp);
	}
    protected static final void _init_prod__sub_Expression__lhs_Expression_layouts_Layouts_lit___layouts_Layouts_rhs_Expression__assoc__left(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[5];
      
      tmp[4] = new NonTerminalStackNode(376, 4, "Expression", null, null);
      tmp[3] = new NonTerminalStackNode(374, 3, "layouts_Layouts", null, null);
      tmp[2] = new LiteralStackNode(372, 2, prod__lit____char_class___range__45_45_, new int[] {45}, null, null);
      tmp[1] = new NonTerminalStackNode(370, 1, "layouts_Layouts", null, null);
      tmp[0] = new NonTerminalStackNode(368, 0, "Expression", null, null);
      builder.addAlternative(Parser.prod__sub_Expression__lhs_Expression_layouts_Layouts_lit___layouts_Layouts_rhs_Expression__assoc__left, tmp);
	}
    protected static final void _init_prod__gt_Expression__lhs_Expression_layouts_Layouts_lit___62_layouts_Layouts_rhs_Expression__assoc__non_assoc(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[5];
      
      tmp[4] = new NonTerminalStackNode(428, 4, "Expression", null, null);
      tmp[3] = new NonTerminalStackNode(426, 3, "layouts_Layouts", null, null);
      tmp[2] = new LiteralStackNode(424, 2, prod__lit___62__char_class___range__62_62_, new int[] {62}, null, null);
      tmp[1] = new NonTerminalStackNode(422, 1, "layouts_Layouts", null, null);
      tmp[0] = new NonTerminalStackNode(420, 0, "Expression", null, null);
      builder.addAlternative(Parser.prod__gt_Expression__lhs_Expression_layouts_Layouts_lit___62_layouts_Layouts_rhs_Expression__assoc__non_assoc, tmp);
	}
    protected static final void _init_prod__eq_Expression__lhs_Expression_layouts_Layouts_lit___61_layouts_Layouts_rhs_Expression__assoc__non_assoc(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[5];
      
      tmp[4] = new NonTerminalStackNode(438, 4, "Expression", null, null);
      tmp[0] = new NonTerminalStackNode(430, 0, "Expression", null, null);
      tmp[1] = new NonTerminalStackNode(432, 1, "layouts_Layouts", null, null);
      tmp[2] = new LiteralStackNode(434, 2, prod__lit___61__char_class___range__61_61_, new int[] {61}, null, null);
      tmp[3] = new NonTerminalStackNode(436, 3, "layouts_Layouts", null, null);
      builder.addAlternative(Parser.prod__eq_Expression__lhs_Expression_layouts_Layouts_lit___61_layouts_Layouts_rhs_Expression__assoc__non_assoc, tmp);
	}
    protected static final void _init_prod__add_Expression__lhs_Expression_layouts_Layouts_lit___43_layouts_Layouts_rhs_Expression__assoc__left(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[5];
      
      tmp[4] = new NonTerminalStackNode(386, 4, "Expression", null, null);
      tmp[3] = new NonTerminalStackNode(384, 3, "layouts_Layouts", null, null);
      tmp[2] = new LiteralStackNode(382, 2, prod__lit___43__char_class___range__43_43_, new int[] {43}, null, null);
      tmp[1] = new NonTerminalStackNode(380, 1, "layouts_Layouts", null, null);
      tmp[0] = new NonTerminalStackNode(378, 0, "Expression", null, null);
      builder.addAlternative(Parser.prod__add_Expression__lhs_Expression_layouts_Layouts_lit___43_layouts_Layouts_rhs_Expression__assoc__left, tmp);
	}
    protected static final void _init_prod__Bracket_Expression__lit___40_layouts_Layouts_exp_Expression_layouts_Layouts_lit___41__bracket(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[5];
      
      tmp[4] = new LiteralStackNode(322, 4, prod__lit___41__char_class___range__41_41_, new int[] {41}, null, null);
      tmp[3] = new NonTerminalStackNode(320, 3, "layouts_Layouts", null, null);
      tmp[2] = new NonTerminalStackNode(318, 2, "Expression", null, null);
      tmp[1] = new NonTerminalStackNode(316, 1, "layouts_Layouts", null, null);
      tmp[0] = new LiteralStackNode(314, 0, prod__lit___40__char_class___range__40_40_, new int[] {40}, null, null);
      builder.addAlternative(Parser.prod__Bracket_Expression__lit___40_layouts_Layouts_exp_Expression_layouts_Layouts_lit___41__bracket, tmp);
	}
    protected static final void _init_prod__mul_Expression__lhs_Expression_layouts_Layouts_lit___42_layouts_Layouts_rhs_Expression__assoc__left(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[5];
      
      tmp[4] = new NonTerminalStackNode(336, 4, "Expression", null, null);
      tmp[3] = new NonTerminalStackNode(334, 3, "layouts_Layouts", null, null);
      tmp[2] = new LiteralStackNode(332, 2, prod__lit___42__char_class___range__42_42_, new int[] {42}, null, null);
      tmp[1] = new NonTerminalStackNode(330, 1, "layouts_Layouts", null, null);
      tmp[0] = new NonTerminalStackNode(328, 0, "Expression", null, null);
      builder.addAlternative(Parser.prod__mul_Expression__lhs_Expression_layouts_Layouts_lit___42_layouts_Layouts_rhs_Expression__assoc__left, tmp);
	}
    protected static final void _init_prod__lt_Expression__lhs_Expression_layouts_Layouts_lit___60_layouts_Layouts_rhs_Expression__assoc__non_assoc(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[5];
      
      tmp[4] = new NonTerminalStackNode(458, 4, "Expression", null, null);
      tmp[3] = new NonTerminalStackNode(456, 3, "layouts_Layouts", null, null);
      tmp[2] = new LiteralStackNode(454, 2, prod__lit___60__char_class___range__60_60_, new int[] {60}, null, null);
      tmp[1] = new NonTerminalStackNode(452, 1, "layouts_Layouts", null, null);
      tmp[0] = new NonTerminalStackNode(450, 0, "Expression", null, null);
      builder.addAlternative(Parser.prod__lt_Expression__lhs_Expression_layouts_Layouts_lit___60_layouts_Layouts_rhs_Expression__assoc__non_assoc, tmp);
	}
    protected static final void _init_prod__amp_Expression__lhs_Expression_layouts_Layouts_lit___38_layouts_Layouts_rhs_Expression__assoc__left(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[5];
      
      tmp[4] = new NonTerminalStackNode(346, 4, "Expression", null, null);
      tmp[3] = new NonTerminalStackNode(344, 3, "layouts_Layouts", null, null);
      tmp[2] = new LiteralStackNode(342, 2, prod__lit___38__char_class___range__38_38_, new int[] {38}, null, null);
      tmp[0] = new NonTerminalStackNode(338, 0, "Expression", null, null);
      tmp[1] = new NonTerminalStackNode(340, 1, "layouts_Layouts", null, null);
      builder.addAlternative(Parser.prod__amp_Expression__lhs_Expression_layouts_Layouts_lit___38_layouts_Layouts_rhs_Expression__assoc__left, tmp);
	}
    protected static final void _init_prod__geq_Expression__lhs_Expression_layouts_Layouts_lit___62_61_layouts_Layouts_rhs_Expression__assoc__non_assoc(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[5];
      
      tmp[4] = new NonTerminalStackNode(468, 4, "Expression", null, null);
      tmp[3] = new NonTerminalStackNode(466, 3, "layouts_Layouts", null, null);
      tmp[2] = new LiteralStackNode(464, 2, prod__lit___62_61__char_class___range__62_62_char_class___range__61_61_, new int[] {62,61}, null, null);
      tmp[1] = new NonTerminalStackNode(462, 1, "layouts_Layouts", null, null);
      tmp[0] = new NonTerminalStackNode(460, 0, "Expression", null, null);
      builder.addAlternative(Parser.prod__geq_Expression__lhs_Expression_layouts_Layouts_lit___62_61_layouts_Layouts_rhs_Expression__assoc__non_assoc, tmp);
	}
    protected static final void _init_prod__lookup_Expression__var_Ident_layouts_Layouts_selectors_iter_seps__Selector__layouts_Layouts_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[3];
      
      tmp[2] = new SeparatedListStackNode(474, 2, regular__iter_seps__Selector__layouts_Layouts, new NonTerminalStackNode(476, 0, "Selector", null, null), new AbstractStackNode[]{new NonTerminalStackNode(478, 1, "layouts_Layouts", null, null)}, true, null, null);
      tmp[1] = new NonTerminalStackNode(472, 1, "layouts_Layouts", null, null);
      tmp[0] = new NonTerminalStackNode(470, 0, "Ident", null, null);
      builder.addAlternative(Parser.prod__lookup_Expression__var_Ident_layouts_Layouts_selectors_iter_seps__Selector__layouts_Layouts_, tmp);
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
      
        _init_prod__lookup_Expression__var_Ident_layouts_Layouts_selectors_iter_seps__Selector__layouts_Layouts_(builder);
      
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
      
      tmp[0] = new SequenceStackNode(300, 0, regular__seq___conditional__char_class___range__65_90_range__97_122__not_precede__char_class___range__65_90_range__97_122_conditional__iter_star__char_class___range__48_57_range__65_90_range__97_122__not_follow__char_class___range__48_57_range__65_90_range__97_122, new AbstractStackNode[]{new CharStackNode(302, 0, new int[][]{{65,90},{97,122}}, new IEnterFilter[] {new CharPrecedeRestriction(new int[][]{{65,90},{97,122}})}, null), new ListStackNode(304, 1, regular__iter_star__char_class___range__48_57_range__65_90_range__97_122, new CharStackNode(306, 0, new int[][]{{48,57},{65,90},{97,122}}, null, null), false, null, new ICompletionFilter[] {new CharFollowRestriction(new int[][]{{48,57},{65,90},{97,122}})})}, null, new ICompletionFilter[] {new StringMatchRestriction(new int[] {86,65,82}), new StringMatchRestriction(new int[] {77,79,68}), new StringMatchRestriction(new int[] {79,82}), new StringMatchRestriction(new int[] {67,79,78,83,84}), new StringMatchRestriction(new int[] {77,79,68,85,76,69}), new StringMatchRestriction(new int[] {66,69,71,73,78}), new StringMatchRestriction(new int[] {70,79,82}), new StringMatchRestriction(new int[] {69,76,83,73,70}), new StringMatchRestriction(new int[] {68,79}), new StringMatchRestriction(new int[] {79,70}), new StringMatchRestriction(new int[] {66,89}), new StringMatchRestriction(new int[] {67,65,83,69}), new StringMatchRestriction(new int[] {82,69,67,79,82,68}), new StringMatchRestriction(new int[] {68,73,86}), new StringMatchRestriction(new int[] {87,72,73,76,69}), new StringMatchRestriction(new int[] {80,82,79,67,69,68,85,82,69}), new StringMatchRestriction(new int[] {73,70}), new StringMatchRestriction(new int[] {84,72,69,78}), new StringMatchRestriction(new int[] {85,78,84,73,76}), new StringMatchRestriction(new int[] {65,82,82,65,89}), new StringMatchRestriction(new int[] {69,76,83,69}), new StringMatchRestriction(new int[] {84,89,80,69}), new StringMatchRestriction(new int[] {84,79}), new StringMatchRestriction(new int[] {82,69,80,69,65,84}), new StringMatchRestriction(new int[] {69,78,68})});
      builder.addAlternative(Parser.prod__id_Ident__conditional__seq___conditional__char_class___range__65_90_range__97_122__not_precede__char_class___range__65_90_range__97_122_conditional__iter_star__char_class___range__48_57_range__65_90_range__97_122__not_follow__char_class___range__48_57_range__65_90_range__97_122__delete__Keywords_, tmp);
	}
    public static void init(ExpectBuilder builder){
      
      
        _init_prod__id_Ident__conditional__seq___conditional__char_class___range__65_90_range__97_122__not_precede__char_class___range__65_90_range__97_122_conditional__iter_star__char_class___range__48_57_range__65_90_range__97_122__not_follow__char_class___range__48_57_range__65_90_range__97_122__delete__Keywords_(builder);
      
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
      
      tmp[4] = new LiteralStackNode(500, 4, prod__lit___41__char_class___range__41_41_, new int[] {41}, null, null);
      tmp[3] = new NonTerminalStackNode(498, 3, "layouts_Layouts", null, null);
      tmp[2] = new SeparatedListStackNode(488, 2, regular__iter_star_seps__Formal__layouts_Layouts_lit___59_layouts_Layouts, new NonTerminalStackNode(490, 0, "Formal", null, null), new AbstractStackNode[]{new NonTerminalStackNode(492, 1, "layouts_Layouts", null, null), new LiteralStackNode(494, 2, prod__lit___59__char_class___range__59_59_, new int[] {59}, null, null), new NonTerminalStackNode(496, 3, "layouts_Layouts", null, null)}, false, null, null);
      tmp[1] = new NonTerminalStackNode(486, 1, "layouts_Layouts", null, null);
      tmp[0] = new LiteralStackNode(484, 0, prod__lit___40__char_class___range__40_40_, new int[] {40}, null, null);
      builder.addAlternative(Parser.prod__Formals__lit___40_layouts_Layouts_formals_iter_star_seps__Formal__layouts_Layouts_lit___59_layouts_Layouts_layouts_Layouts_lit___41_, tmp);
	}
    public static void init(ExpectBuilder builder){
      
      
        _init_prod__Formals__lit___40_layouts_Layouts_formals_iter_star_seps__Formal__layouts_Layouts_lit___59_layouts_Layouts_layouts_Layouts_lit___41_(builder);
      
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
      
      tmp[0] = new ListStackNode(480, 0, regular__iter_star__char_class___range__9_10_range__13_13_range__32_32, new CharStackNode(482, 0, new int[][]{{9,10},{13,13},{32,32}}, null, null), false, null, new ICompletionFilter[] {new CharFollowRestriction(new int[][]{{9,10},{13,13},{32,32}})});
      builder.addAlternative(Parser.prod__layouts_$QUOTES__conditional__iter_star__char_class___range__9_10_range__13_13_range__32_32__not_follow__char_class___range__9_10_range__13_13_range__32_32_, tmp);
	}
    public static void init(ExpectBuilder builder){
      
      
        _init_prod__layouts_$QUOTES__conditional__iter_star__char_class___range__9_10_range__13_13_range__32_32__not_follow__char_class___range__9_10_range__13_13_range__32_32_(builder);
      
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
      
      tmp[2] = new SeparatedListStackNode(524, 2, regular__iter_seps__Statement__layouts_Layouts_lit___59_layouts_Layouts, new NonTerminalStackNode(526, 0, "Statement", null, null), new AbstractStackNode[]{new NonTerminalStackNode(528, 1, "layouts_Layouts", null, null), new LiteralStackNode(530, 2, prod__lit___59__char_class___range__59_59_, new int[] {59}, null, null), new NonTerminalStackNode(532, 3, "layouts_Layouts", null, null)}, true, null, null);
      tmp[1] = new NonTerminalStackNode(522, 1, "layouts_Layouts", null, null);
      tmp[0] = new LiteralStackNode(520, 0, prod__lit_BEGIN__char_class___range__66_66_char_class___range__69_69_char_class___range__71_71_char_class___range__73_73_char_class___range__78_78_, new int[] {66,69,71,73,78}, null, null);
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
      
      tmp[4] = new NonTerminalStackNode(556, 4, "Expression", null, null);
      tmp[3] = new NonTerminalStackNode(554, 3, "layouts_Layouts", null, null);
      tmp[2] = new LiteralStackNode(552, 2, prod__lit___58_61__char_class___range__58_58_char_class___range__61_61_, new int[] {58,61}, null, null);
      tmp[1] = new NonTerminalStackNode(550, 1, "layouts_Layouts", null, null);
      tmp[0] = new NonTerminalStackNode(548, 0, "Ident", null, null);
      builder.addAlternative(Parser.prod__assign_Statement__var_Ident_layouts_Layouts_lit___58_61_layouts_Layouts_exp_Expression_, tmp);
	}
    protected static final void _init_prod__skip_Statement__(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new EpsilonStackNode(590, 0);
      builder.addAlternative(Parser.prod__skip_Statement__, tmp);
	}
    protected static final void _init_prod__caseOf_Statement__lit_CASE_layouts_Layouts_exp_Expression_layouts_Layouts_lit_OF_layouts_Layouts_cases_iter_seps__Case__layouts_Layouts_lit___124_layouts_Layouts_layouts_Layouts_elsePart_opt__ElsePart_layouts_Layouts_lit_END_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[11];
      
      tmp[10] = new LiteralStackNode(588, 10, prod__lit_END__char_class___range__69_69_char_class___range__78_78_char_class___range__68_68_, new int[] {69,78,68}, null, null);
      tmp[9] = new NonTerminalStackNode(586, 9, "layouts_Layouts", null, null);
      tmp[8] = new OptionalStackNode(582, 8, regular__opt__ElsePart, new NonTerminalStackNode(584, 0, "ElsePart", null, null), null, null);
      tmp[7] = new NonTerminalStackNode(580, 7, "layouts_Layouts", null, null);
      tmp[6] = new SeparatedListStackNode(570, 6, regular__iter_seps__Case__layouts_Layouts_lit___124_layouts_Layouts, new NonTerminalStackNode(572, 0, "Case", null, null), new AbstractStackNode[]{new NonTerminalStackNode(574, 1, "layouts_Layouts", null, null), new LiteralStackNode(576, 2, prod__lit___124__char_class___range__124_124_, new int[] {124}, null, null), new NonTerminalStackNode(578, 3, "layouts_Layouts", null, null)}, true, null, null);
      tmp[5] = new NonTerminalStackNode(568, 5, "layouts_Layouts", null, null);
      tmp[4] = new LiteralStackNode(566, 4, prod__lit_OF__char_class___range__79_79_char_class___range__70_70_, new int[] {79,70}, null, null);
      tmp[3] = new NonTerminalStackNode(564, 3, "layouts_Layouts", null, null);
      tmp[2] = new NonTerminalStackNode(562, 2, "Expression", null, null);
      tmp[1] = new NonTerminalStackNode(560, 1, "layouts_Layouts", null, null);
      tmp[0] = new LiteralStackNode(558, 0, prod__lit_CASE__char_class___range__67_67_char_class___range__65_65_char_class___range__83_83_char_class___range__69_69_, new int[] {67,65,83,69}, null, null);
      builder.addAlternative(Parser.prod__caseOf_Statement__lit_CASE_layouts_Layouts_exp_Expression_layouts_Layouts_lit_OF_layouts_Layouts_cases_iter_seps__Case__layouts_Layouts_lit___124_layouts_Layouts_layouts_Layouts_elsePart_opt__ElsePart_layouts_Layouts_lit_END_, tmp);
	}
    protected static final void _init_prod__assign_Statement__var_Ident_layouts_Layouts_selectors_iter_seps__Selector__layouts_Layouts_layouts_Layouts_lit___58_61_layouts_Layouts_exp_Expression_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[7];
      
      tmp[0] = new NonTerminalStackNode(592, 0, "Ident", null, null);
      tmp[1] = new NonTerminalStackNode(594, 1, "layouts_Layouts", null, null);
      tmp[2] = new SeparatedListStackNode(596, 2, regular__iter_seps__Selector__layouts_Layouts, new NonTerminalStackNode(598, 0, "Selector", null, null), new AbstractStackNode[]{new NonTerminalStackNode(600, 1, "layouts_Layouts", null, null)}, true, null, null);
      tmp[3] = new NonTerminalStackNode(602, 3, "layouts_Layouts", null, null);
      tmp[4] = new LiteralStackNode(604, 4, prod__lit___58_61__char_class___range__58_58_char_class___range__61_61_, new int[] {58,61}, null, null);
      tmp[5] = new NonTerminalStackNode(606, 5, "layouts_Layouts", null, null);
      tmp[6] = new NonTerminalStackNode(608, 6, "Expression", null, null);
      builder.addAlternative(Parser.prod__assign_Statement__var_Ident_layouts_Layouts_selectors_iter_seps__Selector__layouts_Layouts_layouts_Layouts_lit___58_61_layouts_Layouts_exp_Expression_, tmp);
	}
    protected static final void _init_prod__forDo_Statement__lit_FOR_layouts_Layouts_name_Ident_layouts_Layouts_lit___58_61_layouts_Layouts_from_Expression_layouts_Layouts_lit_TO_layouts_Layouts_to_Expression_layouts_Layouts_opt__seq___lit_BY_layouts_Layouts_Expression_layouts_Layouts_lit_DO_layouts_Layouts_body_iter_seps__Statement__layouts_Layouts_lit___59_layouts_Layouts_layouts_Layouts_lit_END_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[19];
      
      tmp[18] = new LiteralStackNode(662, 18, prod__lit_END__char_class___range__69_69_char_class___range__78_78_char_class___range__68_68_, new int[] {69,78,68}, null, null);
      tmp[17] = new NonTerminalStackNode(660, 17, "layouts_Layouts", null, null);
      tmp[16] = new SeparatedListStackNode(650, 16, regular__iter_seps__Statement__layouts_Layouts_lit___59_layouts_Layouts, new NonTerminalStackNode(652, 0, "Statement", null, null), new AbstractStackNode[]{new NonTerminalStackNode(654, 1, "layouts_Layouts", null, null), new LiteralStackNode(656, 2, prod__lit___59__char_class___range__59_59_, new int[] {59}, null, null), new NonTerminalStackNode(658, 3, "layouts_Layouts", null, null)}, true, null, null);
      tmp[15] = new NonTerminalStackNode(648, 15, "layouts_Layouts", null, null);
      tmp[14] = new LiteralStackNode(646, 14, prod__lit_DO__char_class___range__68_68_char_class___range__79_79_, new int[] {68,79}, null, null);
      tmp[13] = new NonTerminalStackNode(644, 13, "layouts_Layouts", null, null);
      tmp[12] = new OptionalStackNode(634, 12, regular__opt__seq___lit_BY_layouts_Layouts_Expression, new SequenceStackNode(636, 0, regular__seq___lit_BY_layouts_Layouts_Expression, new AbstractStackNode[]{new LiteralStackNode(638, 0, prod__lit_BY__char_class___range__66_66_char_class___range__89_89_, new int[] {66,89}, null, null), new NonTerminalStackNode(640, 1, "layouts_Layouts", null, null), new NonTerminalStackNode(642, 2, "Expression", null, null)}, null, null), null, null);
      tmp[11] = new NonTerminalStackNode(632, 11, "layouts_Layouts", null, null);
      tmp[10] = new NonTerminalStackNode(630, 10, "Expression", null, null);
      tmp[9] = new NonTerminalStackNode(628, 9, "layouts_Layouts", null, null);
      tmp[8] = new LiteralStackNode(626, 8, prod__lit_TO__char_class___range__84_84_char_class___range__79_79_, new int[] {84,79}, null, null);
      tmp[7] = new NonTerminalStackNode(624, 7, "layouts_Layouts", null, null);
      tmp[6] = new NonTerminalStackNode(622, 6, "Expression", null, null);
      tmp[5] = new NonTerminalStackNode(620, 5, "layouts_Layouts", null, null);
      tmp[4] = new LiteralStackNode(618, 4, prod__lit___58_61__char_class___range__58_58_char_class___range__61_61_, new int[] {58,61}, null, null);
      tmp[3] = new NonTerminalStackNode(616, 3, "layouts_Layouts", null, null);
      tmp[2] = new NonTerminalStackNode(614, 2, "Ident", null, null);
      tmp[1] = new NonTerminalStackNode(612, 1, "layouts_Layouts", null, null);
      tmp[0] = new LiteralStackNode(610, 0, prod__lit_FOR__char_class___range__70_70_char_class___range__79_79_char_class___range__82_82_, new int[] {70,79,82}, null, null);
      builder.addAlternative(Parser.prod__forDo_Statement__lit_FOR_layouts_Layouts_name_Ident_layouts_Layouts_lit___58_61_layouts_Layouts_from_Expression_layouts_Layouts_lit_TO_layouts_Layouts_to_Expression_layouts_Layouts_opt__seq___lit_BY_layouts_Layouts_Expression_layouts_Layouts_lit_DO_layouts_Layouts_body_iter_seps__Statement__layouts_Layouts_lit___59_layouts_Layouts_layouts_Layouts_lit_END_, tmp);
	}
    protected static final void _init_prod__call_Statement__name_Ident_layouts_Layouts_actuals_opt__Actuals_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[3];
      
      tmp[2] = new OptionalStackNode(668, 2, regular__opt__Actuals, new NonTerminalStackNode(670, 0, "Actuals", null, null), null, null);
      tmp[1] = new NonTerminalStackNode(666, 1, "layouts_Layouts", null, null);
      tmp[0] = new NonTerminalStackNode(664, 0, "Ident", null, null);
      builder.addAlternative(Parser.prod__call_Statement__name_Ident_layouts_Layouts_actuals_opt__Actuals_, tmp);
	}
    protected static final void _init_prod__whileDo_Statement__lit_WHILE_layouts_Layouts_condition_Expression_layouts_Layouts_lit_DO_layouts_Layouts_body_iter_seps__Statement__layouts_Layouts_lit___59_layouts_Layouts_layouts_Layouts_lit_END_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[9];
      
      tmp[8] = new LiteralStackNode(696, 8, prod__lit_END__char_class___range__69_69_char_class___range__78_78_char_class___range__68_68_, new int[] {69,78,68}, null, null);
      tmp[7] = new NonTerminalStackNode(694, 7, "layouts_Layouts", null, null);
      tmp[6] = new SeparatedListStackNode(684, 6, regular__iter_seps__Statement__layouts_Layouts_lit___59_layouts_Layouts, new NonTerminalStackNode(686, 0, "Statement", null, null), new AbstractStackNode[]{new NonTerminalStackNode(688, 1, "layouts_Layouts", null, null), new LiteralStackNode(690, 2, prod__lit___59__char_class___range__59_59_, new int[] {59}, null, null), new NonTerminalStackNode(692, 3, "layouts_Layouts", null, null)}, true, null, null);
      tmp[5] = new NonTerminalStackNode(682, 5, "layouts_Layouts", null, null);
      tmp[4] = new LiteralStackNode(680, 4, prod__lit_DO__char_class___range__68_68_char_class___range__79_79_, new int[] {68,79}, null, null);
      tmp[3] = new NonTerminalStackNode(678, 3, "layouts_Layouts", null, null);
      tmp[2] = new NonTerminalStackNode(676, 2, "Expression", null, null);
      tmp[1] = new NonTerminalStackNode(674, 1, "layouts_Layouts", null, null);
      tmp[0] = new LiteralStackNode(672, 0, prod__lit_WHILE__char_class___range__87_87_char_class___range__72_72_char_class___range__73_73_char_class___range__76_76_char_class___range__69_69_, new int[] {87,72,73,76,69}, null, null);
      builder.addAlternative(Parser.prod__whileDo_Statement__lit_WHILE_layouts_Layouts_condition_Expression_layouts_Layouts_lit_DO_layouts_Layouts_body_iter_seps__Statement__layouts_Layouts_lit___59_layouts_Layouts_layouts_Layouts_lit_END_, tmp);
	}
    protected static final void _init_prod__ifThen_Statement__lit_IF_layouts_Layouts_condition_Expression_layouts_Layouts_lit_THEN_layouts_Layouts_body_iter_seps__Statement__layouts_Layouts_lit___59_layouts_Layouts_layouts_Layouts_iter_star_seps__ElsIfPart__layouts_Layouts_layouts_Layouts_opt__ElsePart_layouts_Layouts_lit_END_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[13];
      
      tmp[12] = new LiteralStackNode(736, 12, prod__lit_END__char_class___range__69_69_char_class___range__78_78_char_class___range__68_68_, new int[] {69,78,68}, null, null);
      tmp[11] = new NonTerminalStackNode(734, 11, "layouts_Layouts", null, null);
      tmp[10] = new OptionalStackNode(730, 10, regular__opt__ElsePart, new NonTerminalStackNode(732, 0, "ElsePart", null, null), null, null);
      tmp[9] = new NonTerminalStackNode(728, 9, "layouts_Layouts", null, null);
      tmp[8] = new SeparatedListStackNode(722, 8, regular__iter_star_seps__ElsIfPart__layouts_Layouts, new NonTerminalStackNode(724, 0, "ElsIfPart", null, null), new AbstractStackNode[]{new NonTerminalStackNode(726, 1, "layouts_Layouts", null, null)}, false, null, null);
      tmp[7] = new NonTerminalStackNode(720, 7, "layouts_Layouts", null, null);
      tmp[6] = new SeparatedListStackNode(710, 6, regular__iter_seps__Statement__layouts_Layouts_lit___59_layouts_Layouts, new NonTerminalStackNode(712, 0, "Statement", null, null), new AbstractStackNode[]{new NonTerminalStackNode(714, 1, "layouts_Layouts", null, null), new LiteralStackNode(716, 2, prod__lit___59__char_class___range__59_59_, new int[] {59}, null, null), new NonTerminalStackNode(718, 3, "layouts_Layouts", null, null)}, true, null, null);
      tmp[5] = new NonTerminalStackNode(708, 5, "layouts_Layouts", null, null);
      tmp[4] = new LiteralStackNode(706, 4, prod__lit_THEN__char_class___range__84_84_char_class___range__72_72_char_class___range__69_69_char_class___range__78_78_, new int[] {84,72,69,78}, null, null);
      tmp[3] = new NonTerminalStackNode(704, 3, "layouts_Layouts", null, null);
      tmp[2] = new NonTerminalStackNode(702, 2, "Expression", null, null);
      tmp[1] = new NonTerminalStackNode(700, 1, "layouts_Layouts", null, null);
      tmp[0] = new LiteralStackNode(698, 0, prod__lit_IF__char_class___range__73_73_char_class___range__70_70_, new int[] {73,70}, null, null);
      builder.addAlternative(Parser.prod__ifThen_Statement__lit_IF_layouts_Layouts_condition_Expression_layouts_Layouts_lit_THEN_layouts_Layouts_body_iter_seps__Statement__layouts_Layouts_lit___59_layouts_Layouts_layouts_Layouts_iter_star_seps__ElsIfPart__layouts_Layouts_layouts_Layouts_opt__ElsePart_layouts_Layouts_lit_END_, tmp);
	}
    public static void init(ExpectBuilder builder){
      
      
        _init_prod__assign_Statement__var_Ident_layouts_Layouts_lit___58_61_layouts_Layouts_exp_Expression_(builder);
      
        _init_prod__skip_Statement__(builder);
      
        _init_prod__caseOf_Statement__lit_CASE_layouts_Layouts_exp_Expression_layouts_Layouts_lit_OF_layouts_Layouts_cases_iter_seps__Case__layouts_Layouts_lit___124_layouts_Layouts_layouts_Layouts_elsePart_opt__ElsePart_layouts_Layouts_lit_END_(builder);
      
        _init_prod__assign_Statement__var_Ident_layouts_Layouts_selectors_iter_seps__Selector__layouts_Layouts_layouts_Layouts_lit___58_61_layouts_Layouts_exp_Expression_(builder);
      
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
    
    protected static final void _init_prod__Keywords__lit_RECORD_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new LiteralStackNode(738, 0, prod__lit_RECORD__char_class___range__82_82_char_class___range__69_69_char_class___range__67_67_char_class___range__79_79_char_class___range__82_82_char_class___range__68_68_, new int[] {82,69,67,79,82,68}, null, null);
      builder.addAlternative(Parser.prod__Keywords__lit_RECORD_, tmp);
	}
    protected static final void _init_prod__Keywords__lit_BY_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new LiteralStackNode(740, 0, prod__lit_BY__char_class___range__66_66_char_class___range__89_89_, new int[] {66,89}, null, null);
      builder.addAlternative(Parser.prod__Keywords__lit_BY_, tmp);
	}
    protected static final void _init_prod__Keywords__lit_DIV_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new LiteralStackNode(742, 0, prod__lit_DIV__char_class___range__68_68_char_class___range__73_73_char_class___range__86_86_, new int[] {68,73,86}, null, null);
      builder.addAlternative(Parser.prod__Keywords__lit_DIV_, tmp);
	}
    protected static final void _init_prod__Keywords__lit_DO_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new LiteralStackNode(744, 0, prod__lit_DO__char_class___range__68_68_char_class___range__79_79_, new int[] {68,79}, null, null);
      builder.addAlternative(Parser.prod__Keywords__lit_DO_, tmp);
	}
    protected static final void _init_prod__Keywords__lit_BEGIN_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new LiteralStackNode(746, 0, prod__lit_BEGIN__char_class___range__66_66_char_class___range__69_69_char_class___range__71_71_char_class___range__73_73_char_class___range__78_78_, new int[] {66,69,71,73,78}, null, null);
      builder.addAlternative(Parser.prod__Keywords__lit_BEGIN_, tmp);
	}
    protected static final void _init_prod__Keywords__lit_END_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new LiteralStackNode(748, 0, prod__lit_END__char_class___range__69_69_char_class___range__78_78_char_class___range__68_68_, new int[] {69,78,68}, null, null);
      builder.addAlternative(Parser.prod__Keywords__lit_END_, tmp);
	}
    protected static final void _init_prod__Keywords__lit_FOR_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new LiteralStackNode(750, 0, prod__lit_FOR__char_class___range__70_70_char_class___range__79_79_char_class___range__82_82_, new int[] {70,79,82}, null, null);
      builder.addAlternative(Parser.prod__Keywords__lit_FOR_, tmp);
	}
    protected static final void _init_prod__Keywords__lit_IF_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new LiteralStackNode(752, 0, prod__lit_IF__char_class___range__73_73_char_class___range__70_70_, new int[] {73,70}, null, null);
      builder.addAlternative(Parser.prod__Keywords__lit_IF_, tmp);
	}
    protected static final void _init_prod__Keywords__lit_ELSE_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new LiteralStackNode(754, 0, prod__lit_ELSE__char_class___range__69_69_char_class___range__76_76_char_class___range__83_83_char_class___range__69_69_, new int[] {69,76,83,69}, null, null);
      builder.addAlternative(Parser.prod__Keywords__lit_ELSE_, tmp);
	}
    protected static final void _init_prod__Keywords__lit_REPEAT_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new LiteralStackNode(756, 0, prod__lit_REPEAT__char_class___range__82_82_char_class___range__69_69_char_class___range__80_80_char_class___range__69_69_char_class___range__65_65_char_class___range__84_84_, new int[] {82,69,80,69,65,84}, null, null);
      builder.addAlternative(Parser.prod__Keywords__lit_REPEAT_, tmp);
	}
    protected static final void _init_prod__Keywords__lit_OF_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new LiteralStackNode(758, 0, prod__lit_OF__char_class___range__79_79_char_class___range__70_70_, new int[] {79,70}, null, null);
      builder.addAlternative(Parser.prod__Keywords__lit_OF_, tmp);
	}
    protected static final void _init_prod__Keywords__lit_OR_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new LiteralStackNode(760, 0, prod__lit_OR__char_class___range__79_79_char_class___range__82_82_, new int[] {79,82}, null, null);
      builder.addAlternative(Parser.prod__Keywords__lit_OR_, tmp);
	}
    protected static final void _init_prod__Keywords__lit_THEN_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new LiteralStackNode(762, 0, prod__lit_THEN__char_class___range__84_84_char_class___range__72_72_char_class___range__69_69_char_class___range__78_78_, new int[] {84,72,69,78}, null, null);
      builder.addAlternative(Parser.prod__Keywords__lit_THEN_, tmp);
	}
    protected static final void _init_prod__Keywords__lit_ARRAY_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new LiteralStackNode(764, 0, prod__lit_ARRAY__char_class___range__65_65_char_class___range__82_82_char_class___range__82_82_char_class___range__65_65_char_class___range__89_89_, new int[] {65,82,82,65,89}, null, null);
      builder.addAlternative(Parser.prod__Keywords__lit_ARRAY_, tmp);
	}
    protected static final void _init_prod__Keywords__lit_MODULE_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new LiteralStackNode(766, 0, prod__lit_MODULE__char_class___range__77_77_char_class___range__79_79_char_class___range__68_68_char_class___range__85_85_char_class___range__76_76_char_class___range__69_69_, new int[] {77,79,68,85,76,69}, null, null);
      builder.addAlternative(Parser.prod__Keywords__lit_MODULE_, tmp);
	}
    protected static final void _init_prod__Keywords__lit_TO_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new LiteralStackNode(768, 0, prod__lit_TO__char_class___range__84_84_char_class___range__79_79_, new int[] {84,79}, null, null);
      builder.addAlternative(Parser.prod__Keywords__lit_TO_, tmp);
	}
    protected static final void _init_prod__Keywords__lit_ELSIF_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new LiteralStackNode(770, 0, prod__lit_ELSIF__char_class___range__69_69_char_class___range__76_76_char_class___range__83_83_char_class___range__73_73_char_class___range__70_70_, new int[] {69,76,83,73,70}, null, null);
      builder.addAlternative(Parser.prod__Keywords__lit_ELSIF_, tmp);
	}
    protected static final void _init_prod__Keywords__lit_PROCEDURE_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new LiteralStackNode(772, 0, prod__lit_PROCEDURE__char_class___range__80_80_char_class___range__82_82_char_class___range__79_79_char_class___range__67_67_char_class___range__69_69_char_class___range__68_68_char_class___range__85_85_char_class___range__82_82_char_class___range__69_69_, new int[] {80,82,79,67,69,68,85,82,69}, null, null);
      builder.addAlternative(Parser.prod__Keywords__lit_PROCEDURE_, tmp);
	}
    protected static final void _init_prod__Keywords__lit_MOD_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new LiteralStackNode(774, 0, prod__lit_MOD__char_class___range__77_77_char_class___range__79_79_char_class___range__68_68_, new int[] {77,79,68}, null, null);
      builder.addAlternative(Parser.prod__Keywords__lit_MOD_, tmp);
	}
    protected static final void _init_prod__Keywords__lit_WHILE_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new LiteralStackNode(776, 0, prod__lit_WHILE__char_class___range__87_87_char_class___range__72_72_char_class___range__73_73_char_class___range__76_76_char_class___range__69_69_, new int[] {87,72,73,76,69}, null, null);
      builder.addAlternative(Parser.prod__Keywords__lit_WHILE_, tmp);
	}
    protected static final void _init_prod__Keywords__lit_VAR_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new LiteralStackNode(778, 0, prod__lit_VAR__char_class___range__86_86_char_class___range__65_65_char_class___range__82_82_, new int[] {86,65,82}, null, null);
      builder.addAlternative(Parser.prod__Keywords__lit_VAR_, tmp);
	}
    protected static final void _init_prod__Keywords__lit_TYPE_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new LiteralStackNode(780, 0, prod__lit_TYPE__char_class___range__84_84_char_class___range__89_89_char_class___range__80_80_char_class___range__69_69_, new int[] {84,89,80,69}, null, null);
      builder.addAlternative(Parser.prod__Keywords__lit_TYPE_, tmp);
	}
    protected static final void _init_prod__Keywords__lit_CASE_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new LiteralStackNode(782, 0, prod__lit_CASE__char_class___range__67_67_char_class___range__65_65_char_class___range__83_83_char_class___range__69_69_, new int[] {67,65,83,69}, null, null);
      builder.addAlternative(Parser.prod__Keywords__lit_CASE_, tmp);
	}
    protected static final void _init_prod__Keywords__lit_UNTIL_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new LiteralStackNode(784, 0, prod__lit_UNTIL__char_class___range__85_85_char_class___range__78_78_char_class___range__84_84_char_class___range__73_73_char_class___range__76_76_, new int[] {85,78,84,73,76}, null, null);
      builder.addAlternative(Parser.prod__Keywords__lit_UNTIL_, tmp);
	}
    protected static final void _init_prod__Keywords__lit_CONST_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new LiteralStackNode(786, 0, prod__lit_CONST__char_class___range__67_67_char_class___range__79_79_char_class___range__78_78_char_class___range__83_83_char_class___range__84_84_, new int[] {67,79,78,83,84}, null, null);
      builder.addAlternative(Parser.prod__Keywords__lit_CONST_, tmp);
	}
    public static void init(ExpectBuilder builder){
      
      
        _init_prod__Keywords__lit_RECORD_(builder);
      
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
      
        _init_prod__Keywords__lit_ARRAY_(builder);
      
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
      
      tmp[2] = new LiteralStackNode(814, 2, prod__lit___42_41__char_class___range__42_42_char_class___range__41_41_, new int[] {42,41}, null, null);
      tmp[1] = new ListStackNode(810, 1, regular__iter_star__CommentElt, new NonTerminalStackNode(812, 0, "CommentElt", null, null), false, null, null);
      tmp[0] = new LiteralStackNode(808, 0, prod__lit___40_42__char_class___range__40_40_char_class___range__42_42_, new int[] {40,42}, null, null);
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
      
      tmp[4] = new NonTerminalStackNode(824, 4, "Expression", null, null);
      tmp[3] = new NonTerminalStackNode(822, 3, "layouts_Layouts", null, null);
      tmp[2] = new LiteralStackNode(820, 2, prod__lit___46_46__char_class___range__46_46_char_class___range__46_46_, new int[] {46,46}, null, null);
      tmp[1] = new NonTerminalStackNode(818, 1, "layouts_Layouts", null, null);
      tmp[0] = new NonTerminalStackNode(816, 0, "Expression", null, null);
      builder.addAlternative(Parser.prod__range_Label__from_Expression_layouts_Layouts_lit___46_46_layouts_Layouts_to_Expression_, tmp);
	}
    protected static final void _init_prod__expression_Label__exp_Expression_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new NonTerminalStackNode(826, 0, "Expression", null, null);
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
      
      tmp[4] = new SeparatedListStackNode(856, 4, regular__iter_seps__Statement__layouts_Layouts_lit___59_layouts_Layouts, new NonTerminalStackNode(858, 0, "Statement", null, null), new AbstractStackNode[]{new NonTerminalStackNode(860, 1, "layouts_Layouts", null, null), new LiteralStackNode(862, 2, prod__lit___59__char_class___range__59_59_, new int[] {59}, null, null), new NonTerminalStackNode(864, 3, "layouts_Layouts", null, null)}, true, null, null);
      tmp[3] = new NonTerminalStackNode(854, 3, "layouts_Layouts", null, null);
      tmp[2] = new LiteralStackNode(852, 2, prod__lit___58__char_class___range__58_58_, new int[] {58}, null, null);
      tmp[1] = new NonTerminalStackNode(850, 1, "layouts_Layouts", null, null);
      tmp[0] = new SeparatedListStackNode(840, 0, regular__iter_seps__Label__layouts_Layouts_lit___44_layouts_Layouts, new NonTerminalStackNode(842, 0, "Label", null, null), new AbstractStackNode[]{new NonTerminalStackNode(844, 1, "layouts_Layouts", null, null), new LiteralStackNode(846, 2, prod__lit___44__char_class___range__44_44_, new int[] {44}, null, null), new NonTerminalStackNode(848, 3, "layouts_Layouts", null, null)}, true, null, null);
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
      
      tmp[6] = new LiteralStackNode(886, 6, prod__lit___59__char_class___range__59_59_, new int[] {59}, null, null);
      tmp[5] = new NonTerminalStackNode(884, 5, "layouts_Layouts", null, null);
      tmp[4] = new NonTerminalStackNode(882, 4, "Type", null, null);
      tmp[3] = new NonTerminalStackNode(880, 3, "layouts_Layouts", null, null);
      tmp[2] = new LiteralStackNode(878, 2, prod__lit___58__char_class___range__58_58_, new int[] {58}, null, null);
      tmp[1] = new NonTerminalStackNode(876, 1, "layouts_Layouts", null, null);
      tmp[0] = new SeparatedListStackNode(866, 0, regular__iter_star_seps__Ident__layouts_Layouts_lit___44_layouts_Layouts, new NonTerminalStackNode(868, 0, "Ident", null, null), new AbstractStackNode[]{new NonTerminalStackNode(870, 1, "layouts_Layouts", null, null), new LiteralStackNode(872, 2, prod__lit___44__char_class___range__44_44_, new int[] {44}, null, null), new NonTerminalStackNode(874, 3, "layouts_Layouts", null, null)}, false, null, null);
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
      
      tmp[6] = new SeparatedListStackNode(920, 6, regular__iter_seps__Statement__layouts_Layouts_lit___59_layouts_Layouts, new NonTerminalStackNode(922, 0, "Statement", null, null), new AbstractStackNode[]{new NonTerminalStackNode(924, 1, "layouts_Layouts", null, null), new LiteralStackNode(926, 2, prod__lit___59__char_class___range__59_59_, new int[] {59}, null, null), new NonTerminalStackNode(928, 3, "layouts_Layouts", null, null)}, true, null, null);
      tmp[5] = new NonTerminalStackNode(918, 5, "layouts_Layouts", null, null);
      tmp[4] = new LiteralStackNode(916, 4, prod__lit_THEN__char_class___range__84_84_char_class___range__72_72_char_class___range__69_69_char_class___range__78_78_, new int[] {84,72,69,78}, null, null);
      tmp[3] = new NonTerminalStackNode(914, 3, "layouts_Layouts", null, null);
      tmp[2] = new NonTerminalStackNode(912, 2, "Expression", null, null);
      tmp[1] = new NonTerminalStackNode(910, 1, "layouts_Layouts", null, null);
      tmp[0] = new LiteralStackNode(908, 0, prod__lit_ELSIF__char_class___range__69_69_char_class___range__76_76_char_class___range__83_83_char_class___range__73_73_char_class___range__70_70_, new int[] {69,76,83,73,70}, null, null);
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
      
      tmp[0] = new CharStackNode(940, 0, new int[][]{{40,40}}, null, new ICompletionFilter[] {new CharFollowRestriction(new int[][]{{42,42}})});
      builder.addAlternative(Parser.prod__CommentChar__conditional__char_class___range__40_40__not_follow__char_class___range__42_42_, tmp);
	}
    protected static final void _init_prod__CommentChar__conditional__char_class___range__42_42__not_follow__char_class___range__41_41_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new CharStackNode(942, 0, new int[][]{{42,42}}, null, new ICompletionFilter[] {new CharFollowRestriction(new int[][]{{41,41}})});
      builder.addAlternative(Parser.prod__CommentChar__conditional__char_class___range__42_42__not_follow__char_class___range__41_41_, tmp);
	}
    protected static final void _init_prod__CommentChar__char_class___range__0_39_range__41_41_range__43_16777215_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new CharStackNode(944, 0, new int[][]{{0,39},{41,41},{43,16777215}}, null, null);
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
    
    protected static final void _init_prod__record_Type__lit_RECORD_layouts_Layouts_fields_iter_seps__Field__layouts_Layouts_lit___59_layouts_Layouts_layouts_Layouts_lit_END_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[5];
      
      tmp[4] = new LiteralStackNode(982, 4, prod__lit_END__char_class___range__69_69_char_class___range__78_78_char_class___range__68_68_, new int[] {69,78,68}, null, null);
      tmp[3] = new NonTerminalStackNode(980, 3, "layouts_Layouts", null, null);
      tmp[2] = new SeparatedListStackNode(970, 2, regular__iter_seps__Field__layouts_Layouts_lit___59_layouts_Layouts, new NonTerminalStackNode(972, 0, "Field", null, null), new AbstractStackNode[]{new NonTerminalStackNode(974, 1, "layouts_Layouts", null, null), new LiteralStackNode(976, 2, prod__lit___59__char_class___range__59_59_, new int[] {59}, null, null), new NonTerminalStackNode(978, 3, "layouts_Layouts", null, null)}, true, null, null);
      tmp[1] = new NonTerminalStackNode(968, 1, "layouts_Layouts", null, null);
      tmp[0] = new LiteralStackNode(966, 0, prod__lit_RECORD__char_class___range__82_82_char_class___range__69_69_char_class___range__67_67_char_class___range__79_79_char_class___range__82_82_char_class___range__68_68_, new int[] {82,69,67,79,82,68}, null, null);
      builder.addAlternative(Parser.prod__record_Type__lit_RECORD_layouts_Layouts_fields_iter_seps__Field__layouts_Layouts_lit___59_layouts_Layouts_layouts_Layouts_lit_END_, tmp);
	}
    protected static final void _init_prod__user_Type__name_Ident_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new NonTerminalStackNode(984, 0, "Ident", null, null);
      builder.addAlternative(Parser.prod__user_Type__name_Ident_, tmp);
	}
    protected static final void _init_prod__array_Type__lit_ARRAY_layouts_Layouts_exp_Expression_layouts_Layouts_lit_OF_layouts_Layouts_type_Type_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[7];
      
      tmp[6] = new NonTerminalStackNode(998, 6, "Type", null, null);
      tmp[5] = new NonTerminalStackNode(996, 5, "layouts_Layouts", null, null);
      tmp[4] = new LiteralStackNode(994, 4, prod__lit_OF__char_class___range__79_79_char_class___range__70_70_, new int[] {79,70}, null, null);
      tmp[3] = new NonTerminalStackNode(992, 3, "layouts_Layouts", null, null);
      tmp[2] = new NonTerminalStackNode(990, 2, "Expression", null, null);
      tmp[1] = new NonTerminalStackNode(988, 1, "layouts_Layouts", null, null);
      tmp[0] = new LiteralStackNode(986, 0, prod__lit_ARRAY__char_class___range__65_65_char_class___range__82_82_char_class___range__82_82_char_class___range__65_65_char_class___range__89_89_, new int[] {65,82,82,65,89}, null, null);
      builder.addAlternative(Parser.prod__array_Type__lit_ARRAY_layouts_Layouts_exp_Expression_layouts_Layouts_lit_OF_layouts_Layouts_type_Type_, tmp);
	}
    public static void init(ExpectBuilder builder){
      
      
        _init_prod__record_Type__lit_RECORD_layouts_Layouts_fields_iter_seps__Field__layouts_Layouts_lit___59_layouts_Layouts_layouts_Layouts_lit_END_(builder);
      
        _init_prod__user_Type__name_Ident_(builder);
      
        _init_prod__array_Type__lit_ARRAY_layouts_Layouts_exp_Expression_layouts_Layouts_lit_OF_layouts_Layouts_type_Type_(builder);
      
    }
  }
	
  protected static class Field {
    public final static AbstractStackNode[] EXPECTS;
    static{
      ExpectBuilder builder = new ExpectBuilder(_resultStoreIdMappings);
      init(builder);
      EXPECTS = builder.buildExpectArray();
    }
    
    protected static final void _init_prod__empty_Field__(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new EpsilonStackNode(946, 0);
      builder.addAlternative(Parser.prod__empty_Field__, tmp);
	}
    protected static final void _init_prod__field_Field__names_iter_seps__Ident__layouts_Layouts_lit___44_layouts_Layouts_layouts_Layouts_lit___58_layouts_Layouts_type_Type_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[5];
      
      tmp[4] = new NonTerminalStackNode(964, 4, "Type", null, null);
      tmp[3] = new NonTerminalStackNode(962, 3, "layouts_Layouts", null, null);
      tmp[2] = new LiteralStackNode(960, 2, prod__lit___58__char_class___range__58_58_, new int[] {58}, null, null);
      tmp[1] = new NonTerminalStackNode(958, 1, "layouts_Layouts", null, null);
      tmp[0] = new SeparatedListStackNode(948, 0, regular__iter_seps__Ident__layouts_Layouts_lit___44_layouts_Layouts, new NonTerminalStackNode(950, 0, "Ident", null, null), new AbstractStackNode[]{new NonTerminalStackNode(952, 1, "layouts_Layouts", null, null), new LiteralStackNode(954, 2, prod__lit___44__char_class___range__44_44_, new int[] {44}, null, null), new NonTerminalStackNode(956, 3, "layouts_Layouts", null, null)}, true, null, null);
      builder.addAlternative(Parser.prod__field_Field__names_iter_seps__Ident__layouts_Layouts_lit___44_layouts_Layouts_layouts_Layouts_lit___58_layouts_Layouts_type_Type_, tmp);
	}
    public static void init(ExpectBuilder builder){
      
      
        _init_prod__empty_Field__(builder);
      
        _init_prod__field_Field__names_iter_seps__Ident__layouts_Layouts_lit___44_layouts_Layouts_layouts_Layouts_lit___58_layouts_Layouts_type_Type_(builder);
      
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
      
      tmp[4] = new OptionalStackNode(1014, 4, regular__opt__VarSect, new NonTerminalStackNode(1016, 0, "VarSect", null, null), null, null);
      tmp[3] = new NonTerminalStackNode(1012, 3, "layouts_Layouts", null, null);
      tmp[2] = new OptionalStackNode(1008, 2, regular__opt__TypeSect, new NonTerminalStackNode(1010, 0, "TypeSect", null, null), null, null);
      tmp[1] = new NonTerminalStackNode(1006, 1, "layouts_Layouts", null, null);
      tmp[0] = new OptionalStackNode(1002, 0, regular__opt__ConstSect, new NonTerminalStackNode(1004, 0, "ConstSect", null, null), null, null);
      builder.addAlternative(Parser.prod__decls_Declarations__consts_opt__ConstSect_layouts_Layouts_types_opt__TypeSect_layouts_Layouts_vars_opt__VarSect_, tmp);
	}
    protected static final void _init_prod__decls_Declarations__consts_opt__ConstSect_layouts_Layouts_types_opt__TypeSect_layouts_Layouts_vars_opt__VarSect_layouts_Layouts_procs_iter_seps__ProcedureDecl__layouts_Layouts_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[7];
      
      tmp[6] = new SeparatedListStackNode(1036, 6, regular__iter_seps__ProcedureDecl__layouts_Layouts, new NonTerminalStackNode(1038, 0, "ProcedureDecl", null, null), new AbstractStackNode[]{new NonTerminalStackNode(1040, 1, "layouts_Layouts", null, null)}, true, null, null);
      tmp[5] = new NonTerminalStackNode(1034, 5, "layouts_Layouts", null, null);
      tmp[4] = new OptionalStackNode(1030, 4, regular__opt__VarSect, new NonTerminalStackNode(1032, 0, "VarSect", null, null), null, null);
      tmp[3] = new NonTerminalStackNode(1028, 3, "layouts_Layouts", null, null);
      tmp[2] = new OptionalStackNode(1024, 2, regular__opt__TypeSect, new NonTerminalStackNode(1026, 0, "TypeSect", null, null), null, null);
      tmp[1] = new NonTerminalStackNode(1022, 1, "layouts_Layouts", null, null);
      tmp[0] = new OptionalStackNode(1018, 0, regular__opt__ConstSect, new NonTerminalStackNode(1020, 0, "ConstSect", null, null), null, null);
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
      
      tmp[8] = new CharStackNode(1098, 8, new int[][]{{48,57}}, null, new ICompletionFilter[] {new CharFollowRestriction(new int[][]{{48,57}})});
      tmp[7] = new CharStackNode(1096, 7, new int[][]{{48,57}}, null, null);
      tmp[6] = new CharStackNode(1094, 6, new int[][]{{48,57}}, null, null);
      tmp[5] = new CharStackNode(1092, 5, new int[][]{{48,57}}, null, null);
      tmp[4] = new CharStackNode(1090, 4, new int[][]{{48,57}}, null, null);
      tmp[3] = new CharStackNode(1088, 3, new int[][]{{48,57}}, null, null);
      tmp[2] = new CharStackNode(1086, 2, new int[][]{{48,57}}, null, null);
      tmp[1] = new CharStackNode(1084, 1, new int[][]{{48,57}}, null, null);
      tmp[0] = new CharStackNode(1082, 0, new int[][]{{49,57}}, null, null);
      builder.addAlternative(Parser.prod__Natural__char_class___range__49_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_conditional__char_class___range__48_57__not_follow__char_class___range__48_57_, tmp);
	}
    protected static final void _init_prod__Natural__char_class___range__49_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_conditional__char_class___range__48_57__not_follow__char_class___range__48_57_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[5];
      
      tmp[0] = new CharStackNode(1100, 0, new int[][]{{49,57}}, null, null);
      tmp[1] = new CharStackNode(1102, 1, new int[][]{{48,57}}, null, null);
      tmp[2] = new CharStackNode(1104, 2, new int[][]{{48,57}}, null, null);
      tmp[3] = new CharStackNode(1106, 3, new int[][]{{48,57}}, null, null);
      tmp[4] = new CharStackNode(1108, 4, new int[][]{{48,57}}, null, new ICompletionFilter[] {new CharFollowRestriction(new int[][]{{48,57}})});
      builder.addAlternative(Parser.prod__Natural__char_class___range__49_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_conditional__char_class___range__48_57__not_follow__char_class___range__48_57_, tmp);
	}
    protected static final void _init_prod__Natural__char_class___range__49_57_char_class___range__48_57_char_class___range__48_57_conditional__char_class___range__48_57__not_follow__char_class___range__48_57_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[4];
      
      tmp[3] = new CharStackNode(1116, 3, new int[][]{{48,57}}, null, new ICompletionFilter[] {new CharFollowRestriction(new int[][]{{48,57}})});
      tmp[2] = new CharStackNode(1114, 2, new int[][]{{48,57}}, null, null);
      tmp[1] = new CharStackNode(1112, 1, new int[][]{{48,57}}, null, null);
      tmp[0] = new CharStackNode(1110, 0, new int[][]{{49,57}}, null, null);
      builder.addAlternative(Parser.prod__Natural__char_class___range__49_57_char_class___range__48_57_char_class___range__48_57_conditional__char_class___range__48_57__not_follow__char_class___range__48_57_, tmp);
	}
    protected static final void _init_prod__Natural__char_class___range__49_57_char_class___range__48_57_conditional__char_class___range__48_57__not_follow__char_class___range__48_57_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[3];
      
      tmp[2] = new CharStackNode(1122, 2, new int[][]{{48,57}}, null, new ICompletionFilter[] {new CharFollowRestriction(new int[][]{{48,57}})});
      tmp[1] = new CharStackNode(1120, 1, new int[][]{{48,57}}, null, null);
      tmp[0] = new CharStackNode(1118, 0, new int[][]{{49,57}}, null, null);
      builder.addAlternative(Parser.prod__Natural__char_class___range__49_57_char_class___range__48_57_conditional__char_class___range__48_57__not_follow__char_class___range__48_57_, tmp);
	}
    protected static final void _init_prod__Natural__char_class___range__49_50_char_class___range__48_49_char_class___range__48_52_char_class___range__48_55_char_class___range__48_52_char_class___range__48_56_char_class___range__48_51_char_class___range__48_54_char_class___range__48_52_conditional__char_class___range__48_55__not_follow__char_class___range__48_57_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[10];
      
      tmp[9] = new CharStackNode(1142, 9, new int[][]{{48,55}}, null, new ICompletionFilter[] {new CharFollowRestriction(new int[][]{{48,57}})});
      tmp[8] = new CharStackNode(1140, 8, new int[][]{{48,52}}, null, null);
      tmp[7] = new CharStackNode(1138, 7, new int[][]{{48,54}}, null, null);
      tmp[6] = new CharStackNode(1136, 6, new int[][]{{48,51}}, null, null);
      tmp[5] = new CharStackNode(1134, 5, new int[][]{{48,56}}, null, null);
      tmp[4] = new CharStackNode(1132, 4, new int[][]{{48,52}}, null, null);
      tmp[3] = new CharStackNode(1130, 3, new int[][]{{48,55}}, null, null);
      tmp[2] = new CharStackNode(1128, 2, new int[][]{{48,52}}, null, null);
      tmp[1] = new CharStackNode(1126, 1, new int[][]{{48,49}}, null, null);
      tmp[0] = new CharStackNode(1124, 0, new int[][]{{49,50}}, null, null);
      builder.addAlternative(Parser.prod__Natural__char_class___range__49_50_char_class___range__48_49_char_class___range__48_52_char_class___range__48_55_char_class___range__48_52_char_class___range__48_56_char_class___range__48_51_char_class___range__48_54_char_class___range__48_52_conditional__char_class___range__48_55__not_follow__char_class___range__48_57_, tmp);
	}
    protected static final void _init_prod__Natural__char_class___range__49_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_conditional__char_class___range__48_57__not_follow__char_class___range__48_57_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[6];
      
      tmp[5] = new CharStackNode(1154, 5, new int[][]{{48,57}}, null, new ICompletionFilter[] {new CharFollowRestriction(new int[][]{{48,57}})});
      tmp[4] = new CharStackNode(1152, 4, new int[][]{{48,57}}, null, null);
      tmp[3] = new CharStackNode(1150, 3, new int[][]{{48,57}}, null, null);
      tmp[2] = new CharStackNode(1148, 2, new int[][]{{48,57}}, null, null);
      tmp[1] = new CharStackNode(1146, 1, new int[][]{{48,57}}, null, null);
      tmp[0] = new CharStackNode(1144, 0, new int[][]{{49,57}}, null, null);
      builder.addAlternative(Parser.prod__Natural__char_class___range__49_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_conditional__char_class___range__48_57__not_follow__char_class___range__48_57_, tmp);
	}
    protected static final void _init_prod__Natural__char_class___range__49_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_conditional__char_class___range__48_57__not_follow__char_class___range__48_57_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[7];
      
      tmp[6] = new CharStackNode(1168, 6, new int[][]{{48,57}}, null, new ICompletionFilter[] {new CharFollowRestriction(new int[][]{{48,57}})});
      tmp[5] = new CharStackNode(1166, 5, new int[][]{{48,57}}, null, null);
      tmp[4] = new CharStackNode(1164, 4, new int[][]{{48,57}}, null, null);
      tmp[3] = new CharStackNode(1162, 3, new int[][]{{48,57}}, null, null);
      tmp[2] = new CharStackNode(1160, 2, new int[][]{{48,57}}, null, null);
      tmp[1] = new CharStackNode(1158, 1, new int[][]{{48,57}}, null, null);
      tmp[0] = new CharStackNode(1156, 0, new int[][]{{49,57}}, null, null);
      builder.addAlternative(Parser.prod__Natural__char_class___range__49_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_conditional__char_class___range__48_57__not_follow__char_class___range__48_57_, tmp);
	}
    protected static final void _init_prod__Natural__conditional__char_class___range__48_57__not_follow__char_class___range__48_57_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new CharStackNode(1170, 0, new int[][]{{48,57}}, null, new ICompletionFilter[] {new CharFollowRestriction(new int[][]{{48,57}})});
      builder.addAlternative(Parser.prod__Natural__conditional__char_class___range__48_57__not_follow__char_class___range__48_57_, tmp);
	}
    protected static final void _init_prod__Natural__char_class___range__49_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_conditional__char_class___range__48_57__not_follow__char_class___range__48_57_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[8];
      
      tmp[7] = new CharStackNode(1186, 7, new int[][]{{48,57}}, null, new ICompletionFilter[] {new CharFollowRestriction(new int[][]{{48,57}})});
      tmp[6] = new CharStackNode(1184, 6, new int[][]{{48,57}}, null, null);
      tmp[5] = new CharStackNode(1182, 5, new int[][]{{48,57}}, null, null);
      tmp[4] = new CharStackNode(1180, 4, new int[][]{{48,57}}, null, null);
      tmp[3] = new CharStackNode(1178, 3, new int[][]{{48,57}}, null, null);
      tmp[2] = new CharStackNode(1176, 2, new int[][]{{48,57}}, null, null);
      tmp[1] = new CharStackNode(1174, 1, new int[][]{{48,57}}, null, null);
      tmp[0] = new CharStackNode(1172, 0, new int[][]{{49,57}}, null, null);
      builder.addAlternative(Parser.prod__Natural__char_class___range__49_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_conditional__char_class___range__48_57__not_follow__char_class___range__48_57_, tmp);
	}
    protected static final void _init_prod__Natural__char_class___range__49_57_conditional__char_class___range__48_57__not_follow__char_class___range__48_57_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[2];
      
      tmp[1] = new CharStackNode(1190, 1, new int[][]{{48,57}}, null, new ICompletionFilter[] {new CharFollowRestriction(new int[][]{{48,57}})});
      tmp[0] = new CharStackNode(1188, 0, new int[][]{{49,57}}, null, null);
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
      
      tmp[2] = new SeparatedListStackNode(1214, 2, regular__iter_seps__Statement__layouts_Layouts_lit___59_layouts_Layouts, new NonTerminalStackNode(1216, 0, "Statement", null, null), new AbstractStackNode[]{new NonTerminalStackNode(1218, 1, "layouts_Layouts", null, null), new LiteralStackNode(1220, 2, prod__lit___59__char_class___range__59_59_, new int[] {59}, null, null), new NonTerminalStackNode(1222, 3, "layouts_Layouts", null, null)}, true, null, null);
      tmp[1] = new NonTerminalStackNode(1212, 1, "layouts_Layouts", null, null);
      tmp[0] = new LiteralStackNode(1210, 0, prod__lit_ELSE__char_class___range__69_69_char_class___range__76_76_char_class___range__83_83_char_class___range__69_69_, new int[] {69,76,83,69}, null, null);
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
      
      tmp[2] = new SeparatedListStackNode(1266, 2, regular__iter_star_seps__VarDecl__layouts_Layouts, new NonTerminalStackNode(1268, 0, "VarDecl", null, null), new AbstractStackNode[]{new NonTerminalStackNode(1270, 1, "layouts_Layouts", null, null)}, false, null, null);
      tmp[1] = new NonTerminalStackNode(1264, 1, "layouts_Layouts", null, null);
      tmp[0] = new LiteralStackNode(1262, 0, prod__lit_VAR__char_class___range__86_86_char_class___range__65_65_char_class___range__82_82_, new int[] {86,65,82}, null, null);
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
      
      tmp[0] = new EpsilonStackNode(1286, 0);
      builder.addAlternative(Parser.prod__layouts_$BACKTICKS__, tmp);
	}
    public static void init(ExpectBuilder builder){
      
      
        _init_prod__layouts_$BACKTICKS__(builder);
      
    }
  }
	
  protected static class Selector {
    public final static AbstractStackNode[] EXPECTS;
    static{
      ExpectBuilder builder = new ExpectBuilder(_resultStoreIdMappings);
      init(builder);
      EXPECTS = builder.buildExpectArray();
    }
    
    protected static final void _init_prod__subscript_Selector__lit___91_layouts_Layouts_exp_Expression_layouts_Layouts_lit___93_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[5];
      
      tmp[4] = new LiteralStackNode(1302, 4, prod__lit___93__char_class___range__93_93_, new int[] {93}, null, null);
      tmp[3] = new NonTerminalStackNode(1300, 3, "layouts_Layouts", null, null);
      tmp[2] = new NonTerminalStackNode(1298, 2, "Expression", null, null);
      tmp[1] = new NonTerminalStackNode(1296, 1, "layouts_Layouts", null, null);
      tmp[0] = new LiteralStackNode(1294, 0, prod__lit___91__char_class___range__91_91_, new int[] {91}, null, null);
      builder.addAlternative(Parser.prod__subscript_Selector__lit___91_layouts_Layouts_exp_Expression_layouts_Layouts_lit___93_, tmp);
	}
    protected static final void _init_prod__field_Selector__lit___46_layouts_Layouts_field_Ident_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[3];
      
      tmp[2] = new NonTerminalStackNode(1308, 2, "Ident", null, null);
      tmp[1] = new NonTerminalStackNode(1306, 1, "layouts_Layouts", null, null);
      tmp[0] = new LiteralStackNode(1304, 0, prod__lit___46__char_class___range__46_46_, new int[] {46}, null, null);
      builder.addAlternative(Parser.prod__field_Selector__lit___46_layouts_Layouts_field_Ident_, tmp);
	}
    public static void init(ExpectBuilder builder){
      
      
        _init_prod__subscript_Selector__lit___91_layouts_Layouts_exp_Expression_layouts_Layouts_lit___93_(builder);
      
        _init_prod__field_Selector__lit___46_layouts_Layouts_field_Ident_(builder);
      
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
      
      tmp[16] = new LiteralStackNode(1366, 16, prod__lit___59__char_class___range__59_59_, new int[] {59}, null, null);
      tmp[15] = new NonTerminalStackNode(1364, 15, "layouts_Layouts", null, null);
      tmp[14] = new NonTerminalStackNode(1362, 14, "Ident", null, null);
      tmp[13] = new NonTerminalStackNode(1360, 13, "layouts_Layouts", null, null);
      tmp[12] = new LiteralStackNode(1358, 12, prod__lit_END__char_class___range__69_69_char_class___range__78_78_char_class___range__68_68_, new int[] {69,78,68}, null, null);
      tmp[11] = new NonTerminalStackNode(1356, 11, "layouts_Layouts", null, null);
      tmp[10] = new OptionalStackNode(1352, 10, regular__opt__Body, new NonTerminalStackNode(1354, 0, "Body", null, null), null, null);
      tmp[9] = new NonTerminalStackNode(1350, 9, "layouts_Layouts", null, null);
      tmp[8] = new NonTerminalStackNode(1348, 8, "Declarations", null, null);
      tmp[7] = new NonTerminalStackNode(1346, 7, "layouts_Layouts", null, null);
      tmp[6] = new LiteralStackNode(1344, 6, prod__lit___59__char_class___range__59_59_, new int[] {59}, null, null);
      tmp[5] = new NonTerminalStackNode(1342, 5, "layouts_Layouts", null, null);
      tmp[4] = new OptionalStackNode(1338, 4, regular__opt__Formals, new NonTerminalStackNode(1340, 0, "Formals", null, null), null, null);
      tmp[3] = new NonTerminalStackNode(1336, 3, "layouts_Layouts", null, null);
      tmp[2] = new NonTerminalStackNode(1334, 2, "Ident", null, null);
      tmp[1] = new NonTerminalStackNode(1332, 1, "layouts_Layouts", null, null);
      tmp[0] = new LiteralStackNode(1330, 0, prod__lit_PROCEDURE__char_class___range__80_80_char_class___range__82_82_char_class___range__79_79_char_class___range__67_67_char_class___range__69_69_char_class___range__68_68_char_class___range__85_85_char_class___range__82_82_char_class___range__69_69_, new int[] {80,82,79,67,69,68,85,82,69}, null, null);
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
      
      tmp[0] = new EpsilonStackNode(1376, 0);
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
  public AbstractStackNode[] Ident() {
    return Ident.EXPECTS;
  }
  public AbstractStackNode[] Expression() {
    return Expression.EXPECTS;
  }
  public AbstractStackNode[] layouts_$QUOTES() {
    return layouts_$QUOTES.EXPECTS;
  }
  public AbstractStackNode[] Formals() {
    return Formals.EXPECTS;
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
  public AbstractStackNode[] Field() {
    return Field.EXPECTS;
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
  public AbstractStackNode[] Selector() {
    return Selector.EXPECTS;
  }
  public AbstractStackNode[] ProcedureDecl() {
    return ProcedureDecl.EXPECTS;
  }
  public AbstractStackNode[] layouts_$default$() {
    return layouts_$default$.EXPECTS;
  }
}