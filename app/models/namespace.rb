# Each [Faalis::User] has couple of namespaces which allow him/her
# to categorize his/her websites as he/she like.
class Namespace < ActiveRecord::Base
  belongs_to :user, :class_name => "Faalis::User"

  has_many :sites, :class_name => "SiteFramework::Site"
end
