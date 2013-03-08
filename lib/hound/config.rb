require 'singleton'

module Hound
  class Config
    include Singleton

    # An Array of actions Hound should track.
    attr_accessor :actions

    # The String used to represent a User class (defaults to 'User').
    attr_reader :user_class

    # Limit actions on a global basis.
    attr_accessor :limit

    def initialize
      @actions = %w'create update destroy'
      @user_class = 'User'
      @limit = nil
    end

    def user_class=(klassname)
      @user_class = klassname.to_s
    end

  end
end