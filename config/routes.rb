Rails.application.routes.draw do
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#email'
  get 'logout', to: 'sessions#destroy'
  get 'success', to: 'sessions#success'
  get 'token/:token', to: 'sessions#create', as: 'token'

  get 'register', to: 'users#new'
  post 'register', to: 'users#create'


  get '/auth/:provider/callback', to: 'sessions#oauth'

  root 'match_pools#index'

  resources :users, except: [:new, :create]

  resources :match_pools do
    get 'advance', on: :member
    get 'score', on: :member
    resources :matches, except: [:index, :show]
    resource :bets, except: [:destroy, :new, :show, :index]
    resources :users, controller: 'bets', only: [:show]
  end

  resources :teams

end
