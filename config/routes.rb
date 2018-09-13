Rails.application.routes.draw do

  root to: 'tasks#index'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  
  post 'login', to: 'sessions#create'
  post 'signin', to: 'sessions#new'
  
  
  resources :tasks
  
  resources :users, only: [:new, :create]
end
