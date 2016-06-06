Rails.application.routes.draw do
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'

  get 'register', to: 'users#new'
  post 'register', to: 'users#create'

  get '/auth/:provider/callback', to: 'sessions#oauth'

  root 'matches#index'

  resources :users, except: [:new, :create]
  resources :matches
  resources :teams
end
