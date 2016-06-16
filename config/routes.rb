Rails.application.routes.draw do
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#email'
  get 'logout', to: 'sessions#destroy'
  get 'success', to: 'sessions#success'
  get 'token/:token', to: 'sessions#create', as: 'token'

  get 'register', to: 'users#new'
  post 'register', to: 'users#create'

  get 'profile', to: 'users#edit'
  post 'profile', to: 'users#update'
  put 'profile', to: 'users#update'
  patch 'profile', to: 'users#update'

  get 'rules', to: 'static_pages#rules'

  get '/auth/:provider/callback', to: 'sessions#oauth'

  root 'match_pools#index'

  resources :users, except: [:new, :create, :show]
  resources :teams, except: [:show]

  resources :match_pools, except: [:edit, :destroy, :update] do
    get 'advance', on: :member
    get 'score', on: :member
    resources :matches, except: [:index]
    resource :bets, except: [:destroy, :new, :show, :index]
    resources :users, controller: 'bets', only: [:show]
    resources :participants, only: [] do
      get 'pay', on: :member
    end
  end

end
