#!/usr/bin/env ruby

require_relative 'helper'
require_relative 'caeser_chipher'

include CommandLineParams
include App

display_usage

::App::CaeserChipher.new(
    input: @input_file_path, 
    output: @output_file_pathh, 
    shift_n: @shift_n, 
    encode: @encode
  )

