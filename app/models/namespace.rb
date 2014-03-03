class Namespace < ActiveRecord::Base
  belongs_to :user, :class_name => "Faalis::User"
end
