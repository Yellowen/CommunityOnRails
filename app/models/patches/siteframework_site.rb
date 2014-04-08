# Extend SiteFramework::Site class to add extra functionality
SiteFramework::Site.class_eval do
  belongs_to :site_category
  has_many :users, :class_name => 'Faalis::User'

  validates_associated :site_category
end
