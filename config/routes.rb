Dhaka::Application.routes.draw do
  devise_for :profiles
  resources :profiles
  resources :listings

  root :to => 'listings#index'
end