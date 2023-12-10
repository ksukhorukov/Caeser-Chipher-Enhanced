#!/usr/bin/env ruby

require_relative 'helper'
require_relative 'caeser_chipher'

module App
  include CommandLineParams

  def self.perform
    #binding.pry
    CommandLineParams.display_usage
    #binding.pry
    CaeserChipher.new(CommandLineParams.params)
  end
end

App::perform
