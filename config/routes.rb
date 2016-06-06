Rails.application.routes.draw do
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'

  get 'register', to: 'users#new'
  post 'register', to: 'users#create'

  get '/auth/:provider/callback', to: 'sessions#oauth'

  root 'match_pools#index'

  resources :users, except: [:new, :create]

  resources :match_pools do
    resources :matches
    resource :bets, except: [:destroy, :new]
    resources :users, controller: 'bets', only: [:index, :show]
  end

  resources :teams

end
