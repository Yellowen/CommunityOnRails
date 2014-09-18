class Permissions::Theme
  include Faalis::Concerns::Authorizable

  def self.humanize_class_name
    'Themes'
  end

end
