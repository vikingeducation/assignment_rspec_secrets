Rails.application.routes.draw do

  root 'secrets#index'

  resources :secrets
  resources :users
  resource :session, :only => [:new, :create, :destroy]
end
