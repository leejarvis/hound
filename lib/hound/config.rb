require 'singleton'

module Hound
  class Config
    include Singleton

    # An Array of actions Hound should track.
    attr_accessor :actions

    # The Class used to represent a User.
    attr_writer :user_class

    def initialize
      @actions = %w'create update destroy'
      @user_class = 'User'
    end

    def user_class
      @user_class.is_a?(String) ? @user_class.constantize : @user_class
    end

  end
end