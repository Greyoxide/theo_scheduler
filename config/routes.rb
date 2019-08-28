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

  resources :talks
  resources :incoming_talks
  resources :outgoing_talks

  resources :groups

  get 'login', to: 'sessions#new', as: :login
  post  '/login', to: 'sessions#create'

  get 'logout', to: 'sessions#destroy', as: :logout
end
