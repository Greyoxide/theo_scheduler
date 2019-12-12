Rails.application.routes.draw do
  root to: 'users#index'

  resources :users

  resources :people
  resources :assignments

  resources :special_events

  resources :congregations do
    resources :notes
    resources :speakers
  end

  resources :speakers, except: [:new, :create] do
    resources :outlines
    resources :notes
    resources :transfers, only: [:new, :create]
  end

  resources :outlines do
    resources :notes
  end

  resources :notes, only: [:show, :edit, :update, :destroy]

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
