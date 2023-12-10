#!/usr/bin/env ruby

require_relative 'helper'
require_relative 'caeser_chipher'

module App
  include CommandLineParams

  def self.perform
    ##
    CommandLineParams.display_usage
    #
    CaeserChipher.new(CommandLineParams.params)
  end
end

App::perform
