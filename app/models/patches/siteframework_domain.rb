# Extend SiteFramework::Domain class to add extra functionality
SiteFramework::Domain.class_eval do
  if Faalis::ORM.active_record?
    belongs_to :namespace
    validates_associated :namespace
  end
end
