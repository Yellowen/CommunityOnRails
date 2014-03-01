require 'settings/loader'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Including `Setting::Loader` cause a before_filter method
  # executed on each request with will load the user settings data.
  include Settings::Loader

end
