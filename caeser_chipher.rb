require 'base64'
require 'pry'
require 'pp'

class CaeserChipher
  DICTIONARY_ADDONS = [
    "﻿", "\n", "[", "]", "“", "—", 
    "‘", "”", "á", "é", "ë", "í", "À", "ó", 
    "ú", "è", "î", "ô", "à", "ç",  "â", "ê", 
    "ï", "ý", "ö", "ä", "ü", "Á", "œ", "É", "æ", "™", "•", 
    "…", "«", "»", "́", "ё", "_"
  ]
  
  attr_reader :input, :output, :shift_n, :addons,
              :input_text, :encode, :substituted_data

  attr_accessor :result
              
  def initialize(params)

    @input = params[:input]
    @output = params[:output]
    @shift_n = params[:shift_n]
    @encode = params[:encode]
    @addons = []
    @result = ''

    perform
    output_result
  end 

  private 

  def base64_encoded_result 
    Base64.encode64(@result)
  end

  def base64_decoded_result 
    Base64.decode64(@result)
  end

  def substitution_idx(chr)
    current_idx = dictionary.index(chr)

    if current_idx.nil? and !chr.nil?
      @dictionary << chr
      @addons << chr
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
    @result = "".force_encoding("utf-8")
    
    unless encode
      buffer = []

      read_input.map { |line| buffer << line.force_encoding("utf-8") }

      @result = buffer.reduce(:+)
 
      begin 
        fp_input_for_write.puts("#{@result}")
      ensure 
        fp_input_for_write.close
        @fp_input_for_write = nil
      end 

      @result
    end 

    @result = "".force_encoding('utf-8')

    @result = read_input.map { |line| line = line.force_encoding('utf-8'); line.chomp!; line }.join("\n")
    
    reject_nils_in_result

    @result = base64_decoded_result if encode == false
    
    @result.force_encoding("utf-8")
    
    @result = perform_substitution.join

    @result = base64_encoded_result if encode == true

    @result
  end

  def reject_nils_in_result
    return '' if result.nil?
    @result = result.split("\n").map { |line| line.split('').reject { |chr| chr == nil }.join }.join("\n")
    @result = "#{result}\n"
  end

  def perform_substitution
    return '' if @result.nil?
    @substituted_data = result.split('').map { |chr| ((dictionary[substitution_idx(chr)].to_s unless chr.nil? or chr.empty?) or '' ) }
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
      @result = transform_spaces if encode == false
      fp_output.puts(@result.strip)
      puts "\n#{@result}\n".colorize(:green)
    ensure 
      fp_output.close 
    end

    # dictionary_addons
  end

  def dictionary_addons
    puts "\n\nDICTIONARY ADDONS\n".colorize(color: :red, mode: :bold)
    pp addons
    puts "\n\n"
  end 

  def transform_spaces 
    @result.gsub!('.', ' ')
    @result.gsub!('/', ' ')
    @result
  end

  def dictionary
    @dictionary ||= (numbers + letters +  letters_capitalized + 
                     russian_letters +  russian_letters_capitalized + 
                     symbols + ['’', ' ', '\n'] + DICTIONARY_ADDONS).flatten
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