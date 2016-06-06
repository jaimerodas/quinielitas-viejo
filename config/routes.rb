Rails.application.routes.draw do
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'

  get 'register', to: 'users#new'
  post 'register', to: 'users#create'

  get '/auth/:provider/callback', to: 'sessions#oauth'

  root 'bets#index'

  resources :users, except: [:new, :create] do
    resource :bets, only: [:show]
  end
  resources :matches
  resources :teams
  resource :bets, except: [:destroy, :new]
end
