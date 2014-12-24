require 'settings/loader'

class ApplicationController < Faalis::ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Including `Setting::Loader` cause a before_filter method
  # executed on each request with will load the user settings data.
  include Settings::Loader

  private

  # This method will call by `Setting::Loader` automaticall
  # after loading user settings
  def after_settings_loaded
    # append_view_path
  end

end
