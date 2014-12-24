Factorien::Application.routes.draw do

  langs = ::I18n.available_locales.join('|')
  scope '(:locale)', locale: Regexp.new(langs) do
    root 'welcome#index'
    get 'coming_soon', to: 'welcome#coming_soon'
  end

  mount Faalis::Engine => '/'
  Faalis::Routes.define_api_routes do
    resources :settings
    resources :namespaces, :except => [:new]
    resources :sites, :except => [:new]
    resources :site_categories, :except => [:new]
  end
end
