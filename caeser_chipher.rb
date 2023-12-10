require 'base64'

module App
  class CaeserChipher
    attr_reader :input, :output, :shift_n, 
                :input_text, :encode

    attr_accessor :result
                
    def initialize(input:, output:, shift_n:, encode: true, decode: false)
      @input = input
      @output = output
      @shift_n = shift_n
      @encode = encode 
      @result = ''

      # puts "encode: #{encode}, decode: #{decode}"

      perform
      output_result
    end 

    private 

    def base64_encoded_result 
      @base64_encoded_result ||= Base64.encode64(@result)
    end

    def base64_decoded_result 
      @base64_decoded_result ||= Base64.decode64(@result)
    end

    def substitution_idx(chr)
      # puts " substitution_idx. encode: #{encode}, decode: #{decode}"
      current_idx = dictionary.index(chr)

      if current_idx.nil?
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
      unless encode
        buffer = []
        read_input.map { |line| buffer << line }
        @result = buffer.reduce(:+)
        @result = base64_decoded_result
        fp_output.write(@result)
      end

      return @result unless encode

      read_input.each do |line| 
        line.chomp.split('').map do |chr| 
          extracted_chr = dictionary[substitution_idx(chr)].to_s
          @result += extracted_chr
        end
      end 

      @result
    end


    def check_params
      raise 'shifting argument must be positive' if shift_n < 0 

      read_input
    end

    def read_input
      @input_context ||= File.readlines(input) 
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
end