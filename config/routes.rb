Rails.application.routes.draw do

  root 'secrets#index'

  resources :secrets
  resources :users
  resource :session, :only => [:new, :create, :destroy]
  get 'logout', :to => 'sessions#destroy'
  get 'sign_out', :to => 'sessions#destroy'
  get 'sign_in', :to => 'sessions#new'
  get 'login', :to => 'sessions#new'

end
