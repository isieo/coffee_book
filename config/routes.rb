CoffeeBook::Application.routes.draw do
  root :to => "home#show"
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  resources :reviews
  resources :companies
end
