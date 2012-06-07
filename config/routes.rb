CoffeeBook::Application.routes.draw do
  resources :jobs

  root :to => "home#show"
  devise_for :users, :controllers => { :omniauth_callbacks => "user/omniauth_callbacks", :registrations => "user/registrations", :sessions => "user/sessions" }
  devise_scope :user do
    get 'sign_in', :to => 'user/sessions#new', :as => :new_user_session
    get 'sign_out', :to => 'user/sessions#destroy', :as => :destroy_user_session
    get '/users/auth/:provider' => 'user/omniauth_callbacks#passthru'
  end
  resources :reviews
  resources :companies
  namespace(:user) do
    resources :accounts
  end
  
  get 'search' => 'search#search', :as => :search
end
