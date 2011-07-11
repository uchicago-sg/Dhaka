Dhaka::Application.routes.draw do
  root :to => 'listings#index'

  devise_for :users
  resources :users
  resources :listings
  resources :categories

  # Catch pages at root, forward to High Voltage
  %w( terms privacy safety issues about faqs status ).each do |page|
    match page => 'high_voltage/pages#show', :id => page
  end

  devise_scope :user do
    get "register", :to => "devise/registrations#new"
    get "login",    :to => "devise/sessions#new"
    get "logout",   :to => "devise/sessions#destroy"
  end
end