Rails.application.routes.draw do
  get 'login', to: 'sessions#new'
  get '/auth/:provider/callback', to: 'sessions#oauth'

  root 'matches#index'

  resources :users
  resources :matches
  resources :teams
end
