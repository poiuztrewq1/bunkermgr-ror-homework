Rails.application.routes.draw do
  get 'login', to: 'sessions#new', as: 'login'
  post 'login', to: 'sessions#create', as: 'login_post'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  get 'register', to: 'users#new', as: 'register'

  resources :inventory_items
  resources :users
  resources :bunkers

  root 'bunkers#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
