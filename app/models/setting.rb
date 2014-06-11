class Setting < Faalis::ORM.proper_base_class

  if Faalis::ORM.mongoid?
    include Mongoid::Document
    include Mongoid::Timestamps

    embedded_in :site, class_name => 'SiteFramework::Site'

    field :theme, :type => String, :default => 'default'
  end

  belongs_to :user, :class_name => 'Faalis::User'
end
