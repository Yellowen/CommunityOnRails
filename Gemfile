source 'http://rubygems.org'
gem 'rails', '4.0.4'
gem 'sqlite3'
gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'jquery-rails'
gem 'jbuilder', '~> 1.2'
gem 'model_discovery'

gem 'omniauth-google-oauth2'
gem 'omniauth-twitter'
gem 'omniauth-facebook'
gem 'fast_gettext'
gem 'gettext_i18n_rails'

group :doc do
  gem 'sdoc', require: false
end

group :development, :test do
  gem 'rspec-rails', '~> 3.0.0.beta'
  gem 'capybara'
  gem 'factory_girl_rails', "~> 4.0", :require => false
  gem 'database_cleaner'
  gem 'email_spec'
  gem 'cucumber-rails', :require => false
  gem 'puma'
end

group :development do
  gem 'pry'
  gem 'capistrano'
  gem 'capistrano-bundler'
  gem 'capistrano-rbenv', github: "capistrano/rbenv"
  gem 'capistrano-rails'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'meta_request'
  gem 'ruby_parser'
end

# Address of directory containing faalis.gemspec
# ONLY FOR DEVELOPMENT
params = {:github => 'Yellowen/Faalis'}
contacts_params = {:github => 'Yellowen/Faalis-Contacts'}
site_framework = {:github => 'Yellowen/site_framework'}

development_file = [File.expand_path(File.dirname(__FILE__)),
                    '.development'].join("/")

if File.exists?(development_file)
  Faalis = [File.expand_path(File.dirname(__FILE__)),
              '../Faalis/'].join("/")
  puts 'Using Faalis source.'
  params = {:path => Faalis}

  contacts_params = {:path => File.expand_path('../../faalis_contacts/', __FILE__)}
  site_framework = {:path => File.expand_path('../../site_framework/', __FILE__)}

end

gem 'faalis', **params
gem 'site_framework', **site_framework
