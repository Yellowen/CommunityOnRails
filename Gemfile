source 'http://rubygems.org'
# We need rails-assets to use Faalis
source 'http://rails-assets.org'

gem 'rails', '~>4.2.0'

gem 'mongoid', '~>4.0.0'

# Native assets
gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'jquery-rails'
gem 'jbuilder', '~> 1.2'
gem 'coffee-rails'

# Slim template engine
gem 'slim-rails'

# Background job processing
gem 'sidekiq'

# Dashstrap
gem 'jquery-ui-rails'

gem 'omniauth-google-oauth2'
gem 'omniauth-twitter'
gem 'omniauth-facebook'
gem 'fast_gettext'
gem 'gettext_i18n_rails'

group :doc do
  gem 'sdoc', require: false
end

group :development, :test do
  gem 'rspec-rails', '~> 3.0'
  gem 'capybara'
  gem 'factory_girl_rails', '~> 4.0', :require => false
  gem 'database_cleaner'
  gem 'email_spec'
  gem 'puma'
  gem 'pry'
  gem 'pry-byebug'
  gem 'capistrano'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'meta_request'
  gem 'ruby_parser'
  gem 'quiet_assets'  # unclutters the server log from assets
  gem 'spring'
end

# Address of directory containing faalis.gemspec
# ONLY FOR DEVELOPMENT
params = {:github => 'Yellowen/Faalis' , :ref => '243957f8d86a966095d91625392064a7a45bfe7d'}
dashstrap = {:github => 'Yellowen/dashstrap'}

contacts_params = {:github => 'Yellowen/Faalis-Contacts'}
site_framework = {:github => 'Yellowen/site_framework'}
page = {:github => 'Yellowen/faalis_page'}

development_file = [File.expand_path(File.dirname(__FILE__)),
                    '.development'].join("/")

if File.exist?(development_file)
  Faalis = [File.expand_path(File.dirname(__FILE__)),
              '../Faalis/'].join("/")
  puts 'Using Faalis source.'
  params = {:path => Faalis}
  dashstrap = {:path => File.expand_path('../../dashstrap/', __FILE__)}
  contacts_params = {:path => File.expand_path('../../faalis_contacts/', __FILE__)}
  site_framework = {:path => File.expand_path('../../site_framework/', __FILE__)}
  page = {:path => File.expand_path('../../faalis_page/', __FILE__)}

end

gem 'faalis', **params
#gem 'faalis', '1.0.0.alpha0'
gem 'dashstrap', **dashstrap

gem 'site_framework', **site_framework
#gem 'compass-rails'
gem 'model_discovery'
gem 'faalis_page', **page

# CloudMe
gem 'foundation-rails', '~>5.3.0'
gem 'rails-assets-Morphext'
gem 'rails-assets-slicknav'

# style
gem 'normalize-rails'

# JS
gem 'rails-assets-WOW'
gem 'rails-assets-jquery-hoverIntent'
gem 'rails-assets-superfish'
gem 'rails-assets-jquery-waypoints'
gem 'rails-assets-retinajs'
gem 'modernizr-rails'

gem 'rest-client'
