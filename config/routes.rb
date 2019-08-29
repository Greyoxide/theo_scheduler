Rails.application.routes.draw do

  root to: 'users#index'

  resources :users
  resources :congregations do
    resources :speakers
  end
  resources :speakers, except: [:new, :create] do
    resources :outlines
  end
  resources :outlines

  resources :talks, only: [:index]
  resources :incoming_talks, only: [:new, :create]
  resources :outgoing_talks, only: [:new, :create]

  resources :groups

  get 'login', to: 'sessions#new', as: :login
  post  '/login', to: 'sessions#create'

  get 'logout', to: 'sessions#destroy', as: :logout
end
