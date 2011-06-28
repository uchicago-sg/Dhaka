Dhaka::Application.routes.draw do
  root :to => 'listings#index'

  devise_for :users
  resources :users
  resources :listings
  resources :storefronts

  # Catch pages at root, forward to High Voltage
  %w( terms privacy safety issues about faqs status ).each do |page|
    match page => 'high_voltage/pages#show', :id => page
  end
end