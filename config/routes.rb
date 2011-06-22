Dhaka::Application.routes.draw do
  devise_for :profiles
  resources :prfiles
  resources :listings

  root :to => 'listings#index'
end
