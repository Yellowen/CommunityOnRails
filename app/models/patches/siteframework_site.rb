# Extend SiteFramework::Site class to add extra functionality
SiteFramework::Site.class_eval do

  include Faalis::Concerns::Authorizable

  if Faalis::ORM.active_record?
    belongs_to :site_category
    has_one :setting
    validates_associated :site_category
  end

  if Faalis::ORM.mongoid?
    field :site_category, :type => Array

    embeds_one :setting
    embedded_in :namespace

    after_initialize :build_default_setting

    def build_default_setting
      build_setting if setting.nil?
    end
  end

  has_many :users, :class_name => 'Faalis::User'
end
