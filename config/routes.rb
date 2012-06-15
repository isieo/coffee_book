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
  resources :jobs, :only => [:index, :show] do
    get :apply, :on => :member
    get :apply_a, :on => :collection
  end
  resources :users, :only => :index
  # Overwrite account route /user/accounts to /:username
  get "/:username" => "user/accounts#index", :as => :user_accounts
  get "/:username/edit" => 'user/accounts#edit', :as => :edit_user_account
  put "/:username" => 'user/accounts#update', :as => :user_account
  get "/:username/companies" => "user/companies#index", :as => :user_account_companies
  post "/:username/companies" => "user/companies#create", :as => :user_account_companies
  get "/:username/companies/new" => "user/companies#new", :as => :new_user_account_company
  get "/:username/companies/:id/edit" => "user/companies#edit", :as => :edit_user_account_company
  get "/:username/companies/:id" => "user/companies#show", :as => :user_account_company
  put "/:username/companies/:id" => "user/companies#update", :as => :user_account_company
  delete "/:username/companies/:id" => "user/companies#destroy", :as => :user_account_company
  # Overwrite reviews route /user/reviews to /:username/reviews
  get "/:username/reviews" => "user/reviews#index", :as => :user_account_reviews
  post "/:username/reviews" => "user/reviews#create", :as => :user_account_reviews
  get "/:username/reviews/new" => "user/reviews#new", :as => :new_user_account_review
  # Jobs route
  get "/:username/companies/:company_id/jobs/:id/approve" => 'user/jobs#approve', :as => :approve_user_account_company_job
  get "/:username/companies/:company_id/jobs" => "user/jobs#index", :as => :user_account_company_jobs
  post "/:username/companies/:company_id/jobs" => "user/jobs#create", :as => :user_account_company_jobs
  get "/:username/ompanies/:company_id/jobs/new" => "user/jobs#new", :as => :new_user_account_company_job
  get "/:username/companies/:company_id/jobs/:id/edit" => "user/jobs#edit", :as => :edit_user_account_company_job
  get "/:username/companies/:company_id/jobs/:id" => "user/jobs#show", :as => :user_account_company_job
  put "/:username/companies/:company_id/jobs/:id" => "user/jobs#update", :as => :user_account_company_job
  delete "/:username/companies/:company_id/jobs/:id" => "user/jobs#destroy", :as => :user_account_company_job
end
