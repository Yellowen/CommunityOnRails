# Extend SiteFramework::Domain class to add extra functionality
SiteFramework::Domain.class_eval do

  belongs_to :namespace if Faalis::ORM.active_record?

  validates_associated :namespace
end
