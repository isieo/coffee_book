CoffeeBook::Application.routes.draw do
  resources :jobs

  root :to => "home#show"
  devise_for :users, :controllers => { :omniauth_callbacks => "user/omniauth_callbacks", :registrations => "user/registrations", :sessions => "user/sessions" }
  devise_scope :user do
    get "sign_in", :to => "user/sessions#new", :as => :new_user_session
    get "sign_out", :to => "user/sessions#destroy", :as => :destroy_user_session
    get "/users/auth/:provider" => "user/omniauth_callbacks#passthru"
    get "/:username" => "user/accounts#index", :as => :user_accounts
    match "/:username/edit" => 'user/accounts#edit', :as => :edit_user_account
    match "/:username" => 'user/accounts#update', :as => :user_account
    match "/:username/achievements" => "user/achievements#index", :as => :user_account_achievements, :via => "get"
    match "/:username/achievements" => "user/achievements#create", :as => :user_account_achievements, :via => "post"
    match "/:username/achievements/new" => "user/achievements#new", :as => :new_user_account_achievement, :via => "get"
    match "/:username/achievements/:id/edit" => "user/achievements#edit", :as => :edit_user_account_achievement, :via => "get"
    match "/:username/achievements/:id" => "user/achievements#update", :as => :user_account_achievement, :via => "put"
    match "/:username/achievements/:id" => "user/achievements#destroy", :as => :user_account_achievement, :via => "delete"
  end
  resources :reviews
  resources :companies
  
  get 'search' => 'search#search', :as => :search
end
