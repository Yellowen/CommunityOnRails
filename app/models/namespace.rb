# Each [Faalis::User] has couple of namespaces which allow him/her
# to categorize his/her websites as he/she like.
class Namespace < Faalis::ORM.proper_base_class

  if Faalis::ORM.mongoid?
    include Mongoid::Document
    include Mongoid::Timestamps
    include Faalis::Permissions

    embeds_many :sites, :class_name => 'SiteFramework::Site'

    field :name, :type => String
  end

  belongs_to :user, :class_name => 'Faalis::User'
  has_many :sites, :class_name => 'SiteFramework::Site' \
  if Faalis::ORM.active_record?
end
