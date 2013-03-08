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

        # Add action hooks
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
        inforce_limit
      end

      def hound_update
        attributes = default_attributes.merge(action: 'update')
        actions.create! attributes
        inforce_limit
      end

      def hound_destroy
        attributes = default_attributes.merge(action: 'destroy')
        attributes.merge!(
          actionable_id: self.id,
          actionable_type: self.class.base_class.name)
        Hound::Action.create(attributes)
        inforce_limit
      end

      def default_attributes
        {
          user_id: Hound.store[:current_user_id]
        }
      end

      def inforce_limit
        limit = self.class.hound_options[:limit]
        limit ||= Hound.config.limit
        if limit and actions.size > limit
          good_actions = actions.order('created_at DESC').limit(limit)
          actions.where('id NOT IN (?)', good_actions.map(&:id)).delete_all
        end
      end

    end

  end
end