CoffeeBook::Application.routes.draw do
  get 'search' => 'search#search', :as => :search
  get 'admin_login' => 'home#admin_login'
  get 'guide' => 'home#guide'
  get 'application' => 'user/accounts#application', :as => :application
  get 'advance_search' => 'search#advance_search', :as => :advance_search
  

  
  root :to => "home#show"
  devise_for :users, :controllers => { :omniauth_callbacks => "user/omniauth_callbacks", :registrations => "user/registrations", :sessions => "user/sessions" }
  devise_scope :user do
    get "sign_in", :to => "user/sessions#new", :as => :new_user_session
    get "sign_out", :to => "user/sessions#destroy", :as => :destroy_user_session
    get "/users/auth/:provider" => "user/omniauth_callbacks#passthru"
  end
  resources :home
  resources :companies
  resources :reviews, :only => :create
  resources :jobs do
    resource :job_applications
  end
  #resources :jobs, :only => [:index, :show] do
  #  get :apply, :on => :member
  #  get :apply_a, :on => :collection
  #end
  resources :users, :only => :index
  # Overwrite account route /user/accounts to /:username
  get "/:username" => "user/accounts#index", :as => :user_accounts, :constraints  => { :username => /[0-z\.]+/ }
  get "/:username/edit" => 'user/accounts#edit', :as => :edit_user_account, :constraints  => { :username => /[0-z\.]+/ }
  put "/:username" => 'user/accounts#update', :as => :user_account, :constraints  => { :username => /[0-z\.]+/ }
  get "/:username/experience" => "user/accounts#experience", :as => :user_experience, :constraints  => { :username => /[0-z\.]+/ }
  get "/:username/map" => "user/accounts#map", :as => :user_map, :constraints  => { :username => /[0-z\.]+/ }
  # Overwrite company nested routes /user/:user_id/companies to /:username/companies
  get "/:username/companies" => "user/companies#index", :as => :user_account_companies, :constraints  => { :username => /[0-z\.]+/ }
  post "/:username/companies" => "user/companies#create", :as => :user_account_companies, :constraints  => { :username => /[0-z\.]+/ }
  get "/:username/companies/new" => "user/companies#new", :as => :new_user_account_company, :constraints  => { :username => /[0-z\.]+/ }
  get "/:username/companies/:id/edit" => "user/companies#edit", :as => :edit_user_account_company, :constraints  => { :username => /[0-z\.]+/ }
  get "/:username/companies/:id" => "user/companies#show", :as => :user_account_company, :constraints  => { :username => /[0-z\.]+/ }
  put "/:username/companies/:id" => "user/companies#update", :as => :user_account_company, :constraints  => { :username => /[0-z\.]+/ }
  delete "/:username/companies/:id" => "user/companies#destroy", :as => :user_account_company, :constraints  => { :username => /[0-z\.]+/ }
  get "/:username/companies/:id/new_member" => "user/companies#new_member", :as => :new_member_user_account_company, :constraints  => { :username => /[0-z\.]+/ }
  put "/:username/companies/:id/create_member" => "user/companies#create_member", :as => :create_member_user_account_company, :constraints  => { :username => /[0-z\.]+/ }
  get "/:username/companies/:id/create_member" => "user/companies#create_member", :as => :create_member_user_account_company, :constraints  => { :username => /[0-z\.]+/ }
  delete "/:username/companies/:id/delete_member" => "user/companies#delete_member", :as => :delete_member_user_account_company, :constraints  => { :username => /[0-z\.]+/ }
  # Overwrite reviews nested routes /user/:user_id/reviews to /:username/reviews
  get "/:username/reviews" => "user/reviews#index", :as => :user_account_reviews, :constraints  => { :username => /[0-z\.]+/ }
  post "/:username/reviews" => "user/reviews#create", :as => :user_account_reviews, :constraints  => { :username => /[0-z\.]+/ }
  get "/:username/reviews/new" => "user/reviews#new", :as => :new_user_account_review, :constraints  => { :username => /[0-z\.]+/ }
  # Overwrite jobs nested routes /user/:user_id/companies/:company_id/jobs to /:username/companies/:company_id/jobs
  get "/:username/companies/:company_id/jobs/:id/approve" => 'user/jobs#approve', :as => :approve_user_account_company_job, :constraints  => { :username => /[0-z\.]+/ }
  get "/:username/companies/:company_id/jobs" => "user/jobs#index", :as => :user_account_company_jobs, :constraints  => { :username => /[0-z\.]+/ }
  post "/:username/companies/:company_id/jobs" => "user/jobs#create", :as => :user_account_company_jobs, :constraints  => { :username => /[0-z\.]+/ }
  get "/:username/ompanies/:company_id/jobs/new" => "user/jobs#new", :as => :new_user_account_company_job, :constraints  => { :username => /[0-z\.]+/ }
  get "/:username/companies/:company_id/jobs/:id/edit" => "user/jobs#edit", :as => :edit_user_account_company_job, :constraints  => { :username => /[0-z\.]+/ }
  get "/:username/companies/:company_id/jobs/:id" => "user/jobs#show", :as => :user_account_company_job, :constraints  => { :username => /[0-z\.]+/ }
  put "/:username/companies/:company_id/jobs/:id" => "user/jobs#update", :as => :user_account_company_job, :constraints  => { :username => /[0-z\.]+/ }
  delete "/:username/companies/:company_id/jobs/:id" => "user/jobs#destroy", :as => :user_account_company_job, :constraints  => { :username => /[0-z\.]+/ }
end
