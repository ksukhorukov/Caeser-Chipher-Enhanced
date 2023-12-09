#!/usr/bin/env ruby

INPUT_FILE_PATH = './INPUT.TXT'
OUTPUT_FILE_PATH = './OUTPUT.TXT'
DEFAULT_SHIFT_N = 27

require 'pp'
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
    @result = ""

    puts "\ninput: #{input}, output: #{output}, shift_n #{shift_n}\n\n".colorize(:green)

    perform
  end 

  private 

  def perform
    check_params 
    chipher if encode  
    decode if decode  

    output_result
  end 

  def chipher
  end

  def decode 
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
      fp_output.write(result)
      puts "\n#{result}".colorize(:green)
    ensure 
      fp_output.close 
    end
  end

  def dictionary
    @dictionary ||= numbers + letters + russian_letters + symbols
  end

  def numbers
    @numbers ||= (0..9).to_a
  end

  def letters
    @letters ||= ('A'..'z').to_a
  end

  def russian_letters
    @letters ||= ('А'..'я').to_a
  end

  def symbols
    @symbols ||= ('!'..'?').to_a
  end
end

@input_file_path = ARGV[0] || INPUT_FILE_PATH 
@output_file_pathh = ARGV[1] || OUTPUT_FILE_PATH
@shift_n = ARGV[2]&.to_i || DEFAULT_SHIFT_N 

CaesarChipher.new(input: @input_file_path, output: @output_file_pathh, shift_n: @shift_n)