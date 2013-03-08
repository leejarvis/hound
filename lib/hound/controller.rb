module Hound
  module Controller

    def self.included(base)
      base.before_filter :set_hound_user
    end

    protected

    # Attempt to fetch the current_user object. Return nil otherwise.
    # This method should be overridden for providing custom behavour.
    def hound_user
      @hound_user ||= current_user
    rescue NameError
      nil
    end

    def hound_user_id
      hound_user.try(:id)
    end

    private

    def hound_action(object, action = params[:action])
      object.actions.create(action: action, user_id: hound_user_id)
    end

    def set_hound_user
      Hound.store[:current_user_id] = hound_user_id
    end

  end
end