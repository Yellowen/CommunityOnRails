Faalis::Engine.setup do |config|
  # Logger settings for Faalis.
  # Default value is the rails logger
  # config.logger = Logger.new(STDOUT)

  # Add your models which want to manage their permissions
  config.models_with_permission = ["Permissions::Settings",
                                   "Permissions::Theme",
                                   "Faalis::Permissions::Auth"]

  # Url prefix for dashboard section. default is '/dashboard'
  # config.dashboard_namespace = :dashboard

  config.site_title = _('Community On Rails')

  config.orm = 'mongoid'
  # If you want to use red base layout in rtl mode
  # config.layout_direction = :rtl
  config.dashboard_modules = {
    :auth => {
      :icon => "fa fa-group",
      :title => _("Authentication"),
      :sidemenu => true,
      :model => "Faalis::Permissions::Auth"
    },
    :sites => {
      :icon => "fa fa-group",
      :title => _("Websites"),
      :sidemenu => true,
      :resource => :site,
    },
    :page => {
      :icon => "fa fa-file-o",
      :sidemenu => true,
      :title => "Pages"
    },
    :settings => {
      :icon => "fa fa-cog",
      :sidemenu => true,
      :title => _("Settings"),
      :model => "Permissions::Settings"
    },
  }

end
