Dhaka::Application.routes.draw do
  root :to => 'listings#index', :via => :get

  # Catch static pages at root, forward to High Voltage
  STATIC_PAGES.each do |page|
    match page => 'high_voltage/pages#show', :id => page
  end

  devise_for :users
  resources :users
  resources :listings, :path => '/'
  resources :categories

  devise_scope :user do
    get "register" => "devise/registrations#new"
    get "login"    => "devise/sessions#new"
    get "logout"   => "devise/sessions#destroy"
  end
end