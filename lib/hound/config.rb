require 'singleton'

module Hound
  class Config
    include Singleton

    # An Array of actions Hound should track.
    attr_accessor :actions

    # Limit actions on a global basis.
    attr_accessor :limit

    def initialize
      @actions = %w'create update destroy'
      @limit = nil
    end

  end
end