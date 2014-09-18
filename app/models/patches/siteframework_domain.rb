# Extend SiteFramework::Domain class to add extra functionality
SiteFramework::Domain.class_eval do

  include Faalis::Concerns::Authorizable

  if Faalis::ORM.active_record?
    belongs_to :namespace
    validates_associated :namespace
  end
end
