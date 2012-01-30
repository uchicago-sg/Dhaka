Dhaka::Application.routes.draw do
  root :to => 'listings#index', :via => :get
  post 'versions/:id/revert' => 'versions#revert', :as => :revert_version
  get 'index'     => 'listings#index'
  get 'feeds'     => 'categories#index', :as => :feeds

  STATIC_PAGES.each do |page|
    match page => 'high_voltage/pages#show', :id => page, :as => "#{page}_page"
  end

  devise_for :users do
    get 'register' => 'devise/registrations#new', :as => :register
    get 'login'    => 'devise/sessions#new',      :as => :login
    get 'logout'   => 'devise/sessions#destroy',  :as => :logout
  end

  resources :users, :only => %w( show edit update ) do
    member do
      get :change_password
    end
  end

  resources :categories, :path => 'browse'
  resources :listings,   :path => '' do
    member do
      match 'renew'     => 'listings#renew',     :as => :renew
      get   'publish'   => 'listings#publish',   :as => :publish
      get   'unpublish' => 'listings#unpublish', :as => :unpublish
      get   'star'      => 'listings#star',      :as => :star
      get   'unstar'    => 'listings#unstar',    :as => :unstar
    end

    collection do
      match 'search' => 'listings#search', :via => [:get, :post], :as => :search
      get  'starred' => 'listings#starred', :as => :starred
    end
  end
end