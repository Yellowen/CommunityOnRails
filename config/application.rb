require File.expand_path('../boot', __FILE__)

#require 'rails/all'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'sprockets/railtie'
require 'rails/test_unit/railtie'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

if File.exists?(File.expand_path('../application.yml', __FILE__))
  config = YAML.load(File.read(File.expand_path('../application.yml', __FILE__)))
  config.merge! config.fetch(Rails.env, {})
  config.each do |key, value|
    ENV[key] ||= value.to_s unless value.kind_of? Hash
  end
end

module Factorien
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :en
    config.i18n.fallbacks = true

    config.autoload_paths << Rails.root.join('lib')

    Mongoid.logger.level = Logger::DEBUG
    Moped.logger.level = Logger::DEBUG

    config.generators do |g|
      g.test_framework      :rspec,        fixture: false
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
      g.assets false
      g.helper false
      g.helper = false
      g.view_specs false
      g.helper_specs false
    end

    config.middleware.use 'Faalis::Middlewares::Locale'
    config.middleware.use 'SiteFramework::Middleware'

    def fetch_domain
      if Faalis::ORM.active_record?
        SiteFramework::Domain.find_by(nam: Rails.application.domain_name)
      elsif Faalis::ORM.mongoid?
        namespace = Namespace.where('sites.domains.name' => Rails.application.domain_name)
        if namespace.empty?
          nil
        else
          namespace.first.sites.first.domains.first
        end
      end
    end
  end
end
