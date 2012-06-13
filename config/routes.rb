CoffeeBook::Application.routes.draw do
  resources :jobs
  get 'search' => 'search#search', :as => :search
  root :to => "home#show"
  devise_for :users, :controllers => { :omniauth_callbacks => "user/omniauth_callbacks", :registrations => "user/registrations", :sessions => "user/sessions" }
  devise_scope :user do
    get "sign_in", :to => "user/sessions#new", :as => :new_user_session
    get "sign_out", :to => "user/sessions#destroy", :as => :destroy_user_session
    get "/users/auth/:provider" => "user/omniauth_callbacks#passthru"
  end
  resources :reviews
  resources :companies
  
  namespace(:user) {
    resources :accounts do
      resources :achievements, :except => :show
      get "/:username/achievements" => "user/achievements#index", :as => :user_account_achievements
      get "/:username/achievements/new" => "user/achievements#new", :as => :new_user_account_achievement
      get "/:username/achievements/:id/edit" => "user/achievements#edit", :as => :edit_user_account_achievement
      post "/:username/achievements" => "user/achievements#create", :as => :user_account_achievements
      put "/:username/achievements/:id" => "user/achievements#update", :as => :user_account_achievement
      delete "/:username/achievements/:id" => "user/achievements#destroy", :as => :user_account_achievement
      resources :companies, :except => :show
      get "/:username/companies" => "user/companies#index", :as => :user_account_companies
      post "/:username/companies" => "user/companies#create", :as => :user_account_companies
      get "/:username/companies/new" => "user/companies#new", :as => :new_user_account_company
      get "/:username/companies/:id/edit" => "user/companies#edit", :as => :edit_user_account_company
      put "/:username/companies/:id" => "user/companies#update", :as => :user_account_company
      delete "/:username/companies/:id" => "user/companies#destroy", :as => :user_account_company
  #    resources :reviews
    end
  }
  get "/:username" => "user/accounts#index", :as => :user_accounts
  get "/:username/edit" => 'user/accounts#edit', :as => :edit_user_account
  put "/:username" => 'user/accounts#update', :as => :user_account
  
  
end
