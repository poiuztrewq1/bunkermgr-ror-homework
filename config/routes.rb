Rails.application.routes.draw do
  get 'login', to: 'sessions#new', as: 'login'
  post 'login', to: 'sessions#create', as: 'login_post'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  get 'register', to: 'users#new', as: 'register'

  get 'assign/bunkers/:bunker_id', to: 'assignments#assign_user', as: 'assign_user'
  get 'assign/users/:user_id', to: 'assignments#assign_bunker', as: 'assign_bunker'
  post 'assign', to: 'assignments#assign', as: 'assign'
  delete 'assign/:bunker_id/:user_id', to: 'assignments#destroy', as: 'unassign'

  resources :inventory_items
  resources :users
  resources :bunkers

  root 'bunkers#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
