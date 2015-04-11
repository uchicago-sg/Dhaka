Dhaka::Application.routes.draw do
  get "admin/index"

  root :to => 'listings#index', :via => :get
  post 'versions/:id/revert' => 'versions#revert', :as => :revert_version
  get 'index' => 'listings#index'
  get 'feeds' => 'categories#index', :as => :feeds

  STATIC_PAGES.each do |page|
    match page => 'high_voltage/pages#show', :id => page, :as => "#{page.gsub('-','_')}_page", :via => [:get, :post]
  end

  CATEGORIES.each do |c|
    category = c[0].downcase
    match category => 'listings#index', :category => category, :as => "#{category}_page", :via => [:get, :post]
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

  get 'admin' => 'admin#index', :as => :admin_console
  get 'admin/users' => 'admin#users', :as => :admin_users
  get 'admin/confirmations' => 'admin#confirmations', :as => :admin_confirmations
  get 'admin/users/:user/update_roles' => 'admin#update_roles', :as => :admin_update_roles
  get 'admin/users/:user/lock' => 'admin#lock', :as => :admin_lock_user
  get 'admin/users/:user/confirm' => 'admin#confirm', :as => :admin_confirm_user
  get 'admin/duplicates' => 'admin#duplicates', :as => :admin_duplicates

  resources :categories, :path => 'browse'
  resources :listings,   :path => '' do
    member do
      match 'renew'     => 'listings#renew',     :as => :renew, :via => [:get, :post]
      get   'publish'   => 'listings#publish',   :as => :publish
      get   'unpublish' => 'listings#unpublish', :as => :unpublish
      get   'star'      => 'listings#star',      :as => :star
      get   'unstar'    => 'listings#unstar',    :as => :unstar
    end

    collection do
      match 'search'  => 'listings#search', :via => [:get, :post], :as => :search
      match 'free'    => 'listings#free', :via => [:get]
      match 'starred' => 'listings#starred', :as => :starred, :via => [:get, :post]
    end
  end
end
