Dhaka::Application.routes.draw do
  root :to => 'listings#index'

  devise_for :users
  resources :users
  resources :listings
end