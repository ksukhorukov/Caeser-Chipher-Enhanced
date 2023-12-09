#!/usr/bin/env ruby

INPUT_FILE_PATH = './input.txt'
OUTPUT_FILE_PATH = './output.txt'
DEFAULT_SHIFT_N = 1

require 'pp'
require 'pry'
require 'colorize'

class CaesarChipher
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

  def substitution_idx(chr)
    # puts " substitution_idx. encode: #{encode}, decode: #{decode}"
    current_idx = dictionary.index(chr)

    if current_idx.nil?
      puts "\ncannot find '#{chr}' inside dictionary\n\n"
      raise 'Error: Cannot chipher. wrong alphabet. Supported languages: EN, RU'
    end

    return (current_idx + shift_n) % dictionary.size if encode == true

    return ((current_idx - shift_n) % dictionary.size).abs
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
      transform_spaces if !encode

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
    @dictionary ||= (numbers + letters +  letters_capitalized + symbols + [' ', '\n']).flatten
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


@encode = ARGV[0] == 'encode' ? true : false
@input_file_path = ARGV[1] || INPUT_FILE_PATH 
@output_file_pathh = ARGV[2] || OUTPUT_FILE_PATH
@shift_n = ARGV[3]&.to_i || DEFAULT_SHIFT_N 

def usage
  puts "\n#{$0} encode|decpde ./input.txt ./output.txt 5\n\nThe last param is shifting number, e.g. 25\n".colorize(:green)
  exit
end 

def correct_params?
  ARGV[0] == 'encode' || ARGV[0] == 'decode'
end

usage if ARGV.size < 1 
usage unless correct_params?

CaesarChipher.new(
    input: @input_file_path, 
    output: @output_file_pathh, 
    shift_n: @shift_n, 
    encode: @encode
  )

