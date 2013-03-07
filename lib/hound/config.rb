require 'singleton'

module Hound
  class Config
    include Singleton

    # An Array of actions Hound should track.
    attr_accessor :actions

    def initialize
      @actions = %w'create update destroy'
    end

  end
end