Factorien::Application.routes.draw do

  namespace :api, :defaults => {:format => :json} do
    namespace :v1 do
      resources :settings
    end
  end

  mount Faalis::Engine => "/"
  # root 'welcome#index'
end
