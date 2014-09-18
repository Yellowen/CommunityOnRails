class Permissions::Settings
  include Faalis::Concerns::Authorizable

  def self.humanize_class_name
    "Settings Module"
  end

end
