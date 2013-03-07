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
    rescue NoMethodError
      nil
    end

    def hound_user_type
      if hound_user
        hound_user.class.base_class.name
      end
    end

    def hound_user_id
      hound_user.try(:id)
    end

    private

    def set_hound_user
      Hound.store[:hound_user_type] = hound_user_type
      Hound.store[:hound_user_id] = hound_user_id
    end

  end
end