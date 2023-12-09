INPUT_FILE_PATH = './input.txt'
OUTPUT_FILE_PATH = './output.txt'
DEFAULT_SHIFT_N = 1

module CommandLineParams
  def usage
  puts "\n#{$0} encode|decpde ./input.txt ./output.txt 5\n\nThe last param is shifting number, e.g. 25\n".colorize(:green)
  exit
end 

  def correct_params?
    ARGV[0] == 'encode' || ARGV[0] == 'decode'
  end

  def help_required?
    ARGV[0] == 'help' || ARGV[0] == 'usage'
  end

  def display_usage
    usage if help_required?
    usage if ARGV.size < 1 
    usage unless correct_params?
  end 
end

@encode = ARGV[0] == 'encode' ? true : false
@input_file_path = ARGV[1] || INPUT_FILE_PATH 
@output_file_pathh = ARGV[2] || OUTPUT_FILE_PATH
@shift_n = ARGV[3]&.to_i || DEFAULT_SHIFT_N 