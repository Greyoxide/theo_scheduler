Rails.application.routes.draw do

  get 'assemblies/new'
  root to: 'users#index'

  resources :users
  resources :congregations do
    resources :speakers
  end
  resources :speakers, except: [:new, :create] do
    resources :outlines
    resources :transfers, only: [:new, :create]
  end
  resources :outlines

  resources :talks, only: [:index, :destroy]
  resources :incoming_talks, only: [:new, :create]
  resources :outgoing_talks, only: [:new, :create]
  resources :assemblies, only: [:new, :create]

  resources :groups

  resources :password_resets

  get 'login', to: 'sessions#new', as: :login
  post  '/login', to: 'sessions#create'

  get 'logout', to: 'sessions#destroy', as: :logout
end
