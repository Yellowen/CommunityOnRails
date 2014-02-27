module Settings
  module Loader

    def load_or_create_user_settings
      if user_signed_in?
        settings = Setting.find_by_user_id(current_user.id)
        puts ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> ", settings, current_user
      end
    end
  end
end
