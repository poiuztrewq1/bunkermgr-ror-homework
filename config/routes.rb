Rails.application.routes.draw do
  resources :inventory_items
  resources :users
  resources :bunkers

  root 'bunkers#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
