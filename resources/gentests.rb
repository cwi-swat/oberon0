

class TestGen

  TESTS = '*/**/*.ob'

  def initialize(root)
    @root = root
    @negatives = {}
    @positives = {}
  end

  def prologue
    puts "module ldta::oberon0::Tests\n\n"
    puts "import ldta::oberon0::Testers;"
    puts "import ldta::oberon0::A1;"
    puts "import ldta::oberon0::A2a;"
    puts "import ldta::oberon0::A2b;"
    puts "import ldta::oberon0::A3;"
    puts "import ldta::oberon0::A4;\n\n"
  end

  def record(tbl, klass, level, tool, obfile, path)
    tbl[klass] ||= {}
    tbl[klass][level] ||= []
    tbl[klass][level] << [tool, obfile, path]
  end  

  def generate
    prologue

    klasses = [:parse, :bind, :check]
    err2klass = {
      'parse_errors' => :parse,
      'name_errors' => :bind,
      'type_errors' => :check
    }

    Dir[TESTS].each do |f|
      if File.file?(f) then
        elts = f.split('/')
        if elts.length == 4 then # a positive test
          tool, _, level, obfile = elts
          klasses.each do |klass|
            record(@positives, klass, level, tool, obfile, f)
          end
        elsif elts.length == 5 then # negative
          tool, _, err, level, obfile = elts
          record(@negatives, err2klass[err], level, tool, obfile, f)
        else
          $stderr.write("Warning: stray test file #{elts.join('/')}\n")
        end
      end
    end
    gen_tests(:gen_negative, @negatives)
    gen_tests(:gen_positive, @positives)
    #gen_tests(:gen_format_test, @positives)
  end

  def neg_pred(klass, obfile)
    return '!= -1' if klass == :parse
    return "== #{get_lineno(obfile)}"
  end

  def pos_pred(klass, obfile)
    '== -1'
  end

  def gen_negative(tool, klass, level, obfile, path)
    gen_test(:NEG, klass, neg_pred(klass, obfile), tool, level, obfile, path)
  end

  def gen_positive(tool, klass, level, obfile, path)
    gen_test(:POS, klass, pos_pred(klass, obfile), tool, level, obfile, path)
  end

  def gen_format_test(tool, klass, level, obfile, path)
    #return if tool != 'rascal'
    puts <<ENDCAT
public test bool POS_format_#{level}_#{tool}_#{tag(obfile)}() =
   implode#{level}(#{loc(path)}) == 
     implode#{level}(parse#{level}(format#{level}(#{loc(path)})));

ENDCAT
  end


  def get_lineno(obfile)
    if obfile =~ /^([0-9]+)_/ then
      return $1
    end
    raise "Could not get lineno from #{obfile}"
  end

  def gen_tests(gen, tbl)
    tbl.each_key do |klass|
      tbl[klass].keys.sort.each do |level|
        tbl[klass][level].each do |tool, obfile, path|
          send(gen, tool, klass, level, obfile, path)
        end
      end
    end
  end

  def gen_test(kind, klass, pred, tool, level, obfile, path) 
    #return if tool != 'rascal'
    puts <<ENDCAT
public test bool #{kind}_#{klass}_#{level}_#{tool}_#{tag(obfile)}() = 
  try#{klass.capitalize}(#{klass}#{level}, #{loc(path)}) #{pred}; 

ENDCAT
  end

  def loc(path)
    "|project://oberon0/tests/#{path}|"
  end

  def tag(obfile)
    obfile.gsub(/[.-]/, '_')
  end


end


if __FILE__ == $0 then
  TestGen.new(Dir.pwd).generate
end
