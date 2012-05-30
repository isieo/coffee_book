CoffeeBook::Application.routes.draw do
  resources :jobs

  root :to => "home#show"
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  devise_scope :user do
    get 'sign_in', :to => 'users/sessions#new', :as => :new_user_session
    get 'sign_out', :to => 'users/sessions#destroy', :as => :destroy_user_session
    get '/users/auth/:provider' => 'users/omniauth_callbacks#passthru'
  end
  resources :reviews
  resources :companies
  match "account" => "account#index"
end
