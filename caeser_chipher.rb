require 'base64'
require 'pry'

class CaeserChipher
  attr_reader :input, :output, :shift_n, 
              :input_text, :encode, :substituted_data

  attr_accessor :result
              
  def initialize(params)
    @input = params[:input]
    @output = params[:output]
    @shift_n = params[:shift_n]
    @encode = params[:encode]
    @result = ''

    # #
    # puts "encode: #{encode}, decode: #{decode}"

    perform
    output_result
  end 

  private 

  def base64_encoded_result 
    @base64_encoded_result ||= Base64.encode64(@result)
  end

  def base64_decoded_result 
    binding.pry
    @base64_decoded_result ||= Base64.decode64(@result)
  end

  def substitution_idx(chr)
    # puts " substitution_idx. encode: #{encode}, decode: #{decode}"
    current_idx = dictionary.index(chr)

    if current_idx.nil? and !chr.nil?
      @dictionary << chr
      return substitution_idx(chr)
    end

    return (current_idx + shift_n) % dictionary.size if encode == true

    return ((current_idx - shift_n) % dictionary.size).abs
  end

  def perform
    check_params 
    transform 
  end 

  def transform
    @result = ''
    
    unless encode
      buffer = []
      
      read_input.map { |line| buffer << line }
      
      @result = buffer.reduce(:+)

      begin 
        fp_input_for_write.puts("#{@result}")
      ensure 
        fp_input_for_write.close
        @fp_input_for_write = nil
      end 

      @result
    end 

    
    @result = ''
    read_input.each do |line| 
      line = line.force_encoding('utf-8')
      line.chomp!
      
      @chars = line.split('')
      reject_nils_in_chars
      binding.pry
      perform_substitution
      @result += substituted_data.reject { |chr| chr == nil }.reduce(:+) unless substituted_data.nil?
    end 
    
    @result += "\n"
  end

  def perform
    reject_nils_in_chars
    perform_substitution
    substituted_data
  end

  def reject_nils_in_chars
    return '' if substituted_data.nil?

    @substituted_data = substituted_data.reject { |chr| chr == nil }
  end

  def perform_substitution
    return '' if @chars.nil?
    
    @substituted_data = @chars.map { |chr| ((dictionary[substitution_idx(chr)].to_s unless chr.nil? or chr.empty?) or '' ) }
  end

  def check_params
    raise 'shifting argument must be positive' if shift_n < 0 

    read_input
  end

  def read_input
   File.readlines(input) 
  end 

  def fp_input_for_write
    @fp_input_for_write ||= File.open(input, 'w')
  end 

  def fp_output
    @fp_output ||= File.open(output, 'w')
  end 

  def output_result
    begin 
      base64_encoded_result if encode
      transform_spaces unless encode
      fp_output.write(@result)
      puts "\n#{@result}\n".colorize(:green)
    ensure 
      fp_output.close 
    end
  end

  def transform_spaces 
    @result.gsub!('.', ' ')
    @result.gsub!('/', ' ')
    @result
  end

  def dictionary
    @dictionary ||= (numbers + letters +  letters_capitalized + 
                     russian_letters +  russian_letters_capitalized + 
                     symbols + ['’', ' ', '\n']).flatten
  end

  def numbers
    @numbers ||= (0..9).to_a
  end

  def letters
    @letters ||= ('a'..'z').to_a
  end

  def letters_capitalized
    @letters_capitalized ||= ('A'..'Z').to_a
  end

  def russian_letters
    @russian_letters ||= ('а'..'я').to_a
  end

  def russian_letters_capitalized
    @russian_letters_capitalized ||= ('А'..'Я').to_a
  end

  def symbols
    @symbols ||= ('!'..'?').to_a
  end
end