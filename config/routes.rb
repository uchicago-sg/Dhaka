Dhaka::Application.routes.draw do
  devise_for :users

  match 'signup' => redirect( '/users/new' )
  match 'login'  => redirect( '/users/login')
  match 'logout' => redirect( '/users/logout')

  root :to => 'listings#index'

  # match 'signup' => redirect('/profiles/new')
  # match 'login'  => redirect('/profiles/login')
  # match 'logout' => redirect('/profiles/logout')

  resources :users
  resources :listings
end