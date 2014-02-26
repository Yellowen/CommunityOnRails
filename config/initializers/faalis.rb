Faalis::Engine.setup do |config|
  # Logger settings for Faalis.
  # Default value is the rails logger
  # config.logger = Logger.new(STDOUT)

  # Add your models which want to manage their permissions
  config.models_with_permission = ["Permissions::Settings",
                                   "Permissions::Theme"]

  # Url prefix for dashboard section. default is '/dashboard'
  # config.dashboard_namespace = :dashboard

  config.site_title = _("Factorien")

  # If you want to use red base layout in rtl mode
  # config.layout_direction = :rtl
  config.dashboard_modules = {
    :settings => {
      :icon => "fa fa-cog",
      :sidemenu => true,
      :title => _("Settings"),
      :model => "Permissions::Settings"
    },
  }

end
