# This model categorize [Site]s objects by subject
class SiteCategory < Faalis::ORM.proper_base_class

  if Faalis::ORM.mongoid?
    include Mongoid::Document
    include Mongoid::Timestamps
    include Faalis::Permissions

    field :name, :type => String
    field :description, :type => String
  end

  has_many :sites, :class_name => "SiteFramework::Site" \
  if Faalis::ORM.active_record?
end
