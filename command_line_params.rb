INPUT_FILE_PATH = './input.txt'
OUTPUT_FILE_PATH = './output.txt'
DEFAULT_SHIFT_N = 1

module CommandLineParams
  def self.included(base)
    self.extend(base)
  end

  def usage
    puts "\n#{$0} encode|decpde ./input.txt ./output.txt 5\n\nThe last param is shifting number, e.g. 33 or 5\n".colorize(:green)
    exit
  end 

  def correct_params?
    ARGV[0] == 'encode' || ARGV[0] == 'decode'
  end

  def help_required?
    ARGV[0] == 'help' || ARGV[0] == 'usage'
  end

  def self.display_usage
    usage if help_required?
    usage if ARGV.size < 1 
    usage unless correct_params?
    parse_params
  end 

  def parse_params 
    @@encode = ARGV[0] == 'encode' ? true : false
    @@input_file_path = ARGV[1] || INPUT_FILE_PATH 
    @@output_file_pathh = ARGV[2] || OUTPUT_FILE_PATH
    @@shift_n = ARGV[3].to_i.positive? ? ARGV[3].to_i : DEFAULT_SHIFT_N 
    #binding.pry
  end 

  def self.encode 
    @@encode 
  end 

  def self.input_file_path 
    @@input_file_path
  end 

  def self.output_file_pathh
    @@output_file_pathh
  end 

  def self.shift_n
    @@shift_n
  end 

  def self.params 
    {
      input: input_file_path, 
      output: output_file_pathh, 
      shift_n: shift_n, 
      encode: encode
    }
  end 
end


