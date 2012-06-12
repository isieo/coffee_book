CoffeeBook::Application.routes.draw do
  resources :jobs
  get 'search' => 'search#search', :as => :search
  root :to => "home#show"
  devise_for :users, :controllers => { :omniauth_callbacks => "user/omniauth_callbacks", :registrations => "user/registrations", :sessions => "user/sessions" }
  devise_scope :user do
    get 'sign_in', :to => 'user/sessions#new', :as => :new_user_session
    get 'sign_out', :to => 'user/sessions#destroy', :as => :destroy_user_session
    get '/users/auth/:provider' => 'user/omniauth_callbacks#passthru'
    get '/:username' => 'user/accounts#index', :as => :user_accounts
    match '/:username/edit' => 'user/accounts#edit', :as => :edit_user_account
    match '/:username' => 'user/accounts#update', :as => :user_account
  end
  resources :reviews
  resources :companies
  namespace(:user) do
    resources :accounts, :only => [:index, :edit, :update]
  end
  
  
end
