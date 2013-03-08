module Hound
  module Model

    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods

      # Tell Hound to track this models actions.
      #
      # options - a Hash of configuration options.
      def hound(options = {})
        send :include, InstanceMethods

        has_many :actions,
          as: 'actionable',
          class_name: 'Hound::Action'

        options[:actions] ||= Hound.config.actions
        options[:actions] = Array(options[:actions]).map(&:to_s)

        class_attribute :hound_options
        self.hound_options = options.dup

        after_create :hound_create if options[:actions].include?('create')
        before_update :hound_update if options[:actions].include?('update')
        after_destroy :hound_destroy if options[:actions].include?('destroy')
      end
    end

    module InstanceMethods

      private

      def hound_create
        attributes = default_attributes.merge(action: 'create')
        actions.create! attributes
      end

      def hound_update
        attributes = default_attributes.merge(action: 'update')
        actions.create! attributes
      end

      def hound_destroy
        attributes = default_attributes.merge(action: 'destroy')
        attributes.merge!(
          actionable_id: self.id,
          actionable_type: self.class.base_class.name)
        Hound::Action.create(attributes)
      end

      def default_attributes
        {
          user_id: Hound.store[:current_user_id]
        }
      end

    end

  end
end