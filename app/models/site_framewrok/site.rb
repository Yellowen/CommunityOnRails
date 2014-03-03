# Require Site Framework domain class first
# if we don't do this, Domain class will define here for the first time
# which will break our application
require SiteFramework::Engine.root.join('app', 'models', 'site_framework', 'site')

# Re-opened class of `Faalis::User` to extend it based on our needs
class SiteFramework::Site
  belongs_to :site_category
  has_many :users, :class_name => "Faalis::User"

  validates_associated :site_category
end
