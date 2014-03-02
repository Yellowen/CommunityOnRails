require 'settings/loader'


class APIController < Faalis::APIController

  # Including `Setting::Loader` cause a before_filter method
  # executed on each request with will load the user settings data.
  include Settings::Loader

  private

  # This method will call by `Setting::Loader` automaticall
  # after loading user settings
  def after_settings_loaded
  end
end
