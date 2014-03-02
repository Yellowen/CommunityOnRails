module Settings
  module Loader

    def self.included(base)
      base.before_action :load_or_create_user_settings, :after_settings_loaded
    end

    def load_or_create_user_settings
      logger.debug "Executing user settings filter"
      if user_signed_in?
        logger.debug "User signed in."

        # If current_user object respond to settings method
        # which we will set when we read users settings for
        # the first time, then we did not to check it again
        unless current_user.respond_to? :settings
          logger.info "Fetching or creating user settings"
          settings = Setting.find_or_create_by(:user_id => current_user.id)

          current_user.define_singleton_method(:settings) { settings }
        else
          logger.info "User settings already attached"
        end
      end
    end
  end
end
