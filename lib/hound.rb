require 'hound/model'
require 'hound/controller'
require 'hound/config'
require 'hound/version'

module Hound

  # The configuration storage for Hound.
  #
  # Returns the Hound::Config instance.
  def self.config
    @config ||= Hound::Config.instance
  end

  def self.configure
    yield config
  end

  # Returns the Hash for storing hound properties on the current thread.
  def self.store
    Thread.current[:hound] ||= {}
  end

  # Returns an ActionRecord::Relation for the Hound::Action model.
  def self.actions
    Action.scoped
  end

end

ActiveSupport.on_load :action_controller do
  include Hound::Controller
end

ActiveSupport.on_load :active_record do
  include Hound::Model
  require 'hound/action'

  if Hound.config.user_class.present?
    begin
      Hound.config.user_class.constantize.instance_eval do
        has_many :actions, class_name: 'Hound::Action', foreign_key: 'user_id'
      end
    rescue NameError
      # warn "Hound is configured with user class `#{Hound.config.user_class}' "\
        # "but this model does not exist"
    end
  end
end