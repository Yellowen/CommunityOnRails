Factorien::Application.routes.draw do

  root 'welcome#index'

  namespace :api, :defaults => {:format => :json} do
    namespace :v1 do
      resources :settings
      resources :namespaces, :except => [:new]
      resources :sites, :except => [:new]
      resources :site_categories, :except => [:new]
    end
  end

  mount Faalis::Engine => '/'
  Faalis::Routes.define_api_routes
end
