Rails.application.routes.draw do
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'

  get '/auth/:provider/callback', to: 'sessions#oauth'

  root 'matches#index'

  resources :users
  resources :matches
  resources :teams
end
