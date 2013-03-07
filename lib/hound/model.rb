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
        actions.create! action: 'create'
      end

      def hound_update
        actions.create! action: 'update'
      end

      def hound_destroy
        Hound::Action.create(
          actionable_id:   self.id,
          actionable_type: self.class.base_class.name,
          action: 'destroy'
        )
      end

    end

  end
end