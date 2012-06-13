CoffeeBook::Application.routes.draw do
  get 'search' => 'search#search', :as => :search
  root :to => "home#show"
  devise_for :users, :controllers => { :omniauth_callbacks => "user/omniauth_callbacks", :registrations => "user/registrations", :sessions => "user/sessions" }
  devise_scope :user do
    get "sign_in", :to => "user/sessions#new", :as => :new_user_session
    get "sign_out", :to => "user/sessions#destroy", :as => :destroy_user_session
    get "/users/auth/:provider" => "user/omniauth_callbacks#passthru"
  end
  resources :companies
  resources :jobs
  # Overwrite /user/accounts to /:username
  match "/:username" => "user/accounts#index", :as => :user_accounts, :via => :get
  match "/:username/edit" => 'user/accounts#edit', :as => :edit_user_account, :via => :get
  match "/:username" => 'user/accounts#update', :as => :user_account, :via => :put
  # Overwrite /user/achievements to /:username/achievements
  get "/:username/achievements" => "user/achievements#index", :as => :user_account_achievements
  get "/:username/achievements/new" => "user/achievements#new", :as => :new_user_account_achievement
  get "/:username/achievements/:id/edit" => "user/achievements#edit", :as => :edit_user_account_achievement
  post "/:username/achievements" => "user/achievements#create", :as => :user_account_achievements
  put "/:username/achievements/:id" => "user/achievements#update", :as => :user_account_achievement
  delete "/:username/achievements/:id" => "user/achievements#destroy", :as => :user_account_achievement
  # Overwrite /user/companies to /:username/companies
  get "/:username/companies" => "user/companies#index", :as => :user_account_companies
  post "/:username/companies" => "user/companies#create", :as => :user_account_companies
  get "/:username/companies/new" => "user/companies#new", :as => :new_user_account_company
  get "/:username/companies/:id/edit" => "user/companies#edit", :as => :edit_user_account_company
  put "/:username/companies/:id" => "user/companies#update", :as => :user_account_company
  delete "/:username/companies/:id" => "user/companies#destroy", :as => :user_account_company
  # Overwrite /user/reviews to /:username/reviews
  get "/:username/reviews" => "user/reviews#index", :as => :user_account_reviews
  post "/:username/reviews" => "user/reviews#create", :as => :user_account_reviews
  get "/:username/reviews/new" => "user/reviews#new", :as => :new_user_account_review
end
