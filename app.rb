#!/usr/bin/env ruby

INPUT_FILE_PATH = './INPUT.TXT'
OUTPUT_FILE_PATH = './OUTPUT.TXT'
DEFAULT_SHIFT_N = 27

require 'pp'

class CaesarChipher
  attr_reader :input, :output, :shift_n

  def initialize(input:, output:, shift_n:)
    @input = input
    @output = output
    @shift_n = shift_n
  end 

  private 

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