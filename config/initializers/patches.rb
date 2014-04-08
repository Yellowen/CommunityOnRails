Rails.configuration.after_initialize do
  require "#{Rails.root}/app/models/patches/faalis_user"
end
