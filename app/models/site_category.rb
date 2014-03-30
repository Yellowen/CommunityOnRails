# This model categorize [Site]s objects by subject
class SiteCategory < ActiveRecord::Base
  has_many :sites, :class_name => "SiteFramework::Site"
end
