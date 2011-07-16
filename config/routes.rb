Dhaka::Application.routes.draw do
  root :to => 'listings#index', :via => :get
  
  post "versions/:id/revert" => "versions#revert", :as => "revert_version"
  
  STATIC_PAGES.each do |page|
    match page => 'high_voltage/pages#show', :id => page
  end

  devise_for :users
  devise_scope :user do
    get "register" => "devise/registrations#new"
    get "login"    => "devise/sessions#new"
    get "logout"   => "devise/sessions#destroy"
  end
  
  resources :users,      :only => %w( show edit update )
  resources :categories, :path => 'browse'
  resources :listings,   :path => ''
end