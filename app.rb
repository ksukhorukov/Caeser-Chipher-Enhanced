#!/usr/bin/env ruby

INPUT_FILE_PATH = './input.txt'
OUTPUT_FILE_PATH = './output.txt'
DEFAULT_SHIFT_N = 1

require 'pp'
require 'pry'
require 'colorize'

class CaesarChipher
  attr_reader :input, :output, :shift_n, 
              :input_text, :encode, :decode

  attr_accessor :result
              
  def initialize(input:, output:, shift_n:, encode: true, decode: false)
    @input = input
    @output = output
    @shift_n = shift_n
    @encode = encode 
    @decode = decode
    @result = ''

    # puts "encode: #{encode}, decode: #{decode}"

    perform
    output_result
  end 

  private 

  def substitution_idx(chr)
    # puts " substitution_idx. encode: #{encode}, decode: #{decode}"
    current_idx = dictionary.index(chr)

    if current_idx.nil?
      puts "\ncannot find '#{chr}' inside dictionary\n\n"
      raise 'Error: Cannot chipher. wrong alphabet. Supported languages: EN, RU'
    end

    return (current_idx + shift_n) % dictionary.size if encode == true
    return ((current_idx - shift_n) % dictionary.size).abs if decode == true
  end

  def perform
    check_params 
    transform 
  end 

  def transform
    read_input.each do |line| 
      line.chomp.split('').map do |chr| 
        extracted_chr = dictionary[substitution_idx(chr)].to_s
        # puts "chr: '#{chr}', extracted_chr: '#{extracted_chr}'\n"
        @result += extracted_chr
      end
    end 

    @result
  end


  def check_params
    raise 'shifting argument must be positive' if shift_n < 0 
    raise 'you have to decode or encode, not encode and decode in parallel' if encode and decode == true 

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
      transform_spaces if decode 

      fp_output.puts(@result)
      puts result.colorize(:green)
    ensure 
      fp_output.close 
    end
  end

  def transform_spaces 
    @result = result.split('/').join(' ')
  end

  def dictionary
    @dictionary ||= (numbers + letters +  letters_capitalized + symbols + ["\ "]).flatten
  end

  def numbers
    @numbers ||= (0..9).to_a
  end

  def letters
    @letters ||= ('a'..'z').to_a
  end

  def letters_capitalized
    @letters ||= ('A'..'Z').to_a
  end

  def symbols
    @symbols ||= ('!'..'?').to_a
  end
end


@input_file_path = ARGV[0] || INPUT_FILE_PATH 
@output_file_pathh = ARGV[1] || OUTPUT_FILE_PATH
@shift_n = ARGV[2]&.to_i || DEFAULT_SHIFT_N 

CaesarChipher.new(
    input: @input_file_path, 
    output: @output_file_pathh, 
    shift_n: @shift_n, 
    decode: true, 
    encode: false
  )

