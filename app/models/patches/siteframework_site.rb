# Extend SiteFramework::Site class to add extra functionality
SiteFramework::Site.class_eval do

  if Faalis::ORM.active_record?
    belongs_to :site_category
    validates_associated :site_category
  end

  if Faalis::ORM.mongoid?
    embeds_one :site_category
    embedded_in :namespace
  end

  has_many :users, :class_name => 'Faalis::User'
end
