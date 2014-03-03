# Require Site Framework domain class first
# if we don't do this, Domain class will define here for the first time
# which will break our application
require SiteFramework::Engine.root.join('app', 'models', 'site_framework', 'domain')

# Re-opened class of `Faalis::User` to extend it based on our needs
class SiteFramework::Domain
  belongs_to :namespace

  validates_associated :namespace
end
