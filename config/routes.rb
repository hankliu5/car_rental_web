Rails.application.routes.draw do
  match '/users',   to: 'users#index',   via: 'get'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :cars
  resources :reservations

  root 'cars#index'
  devise_for :users, :path_prefix => 'd'
  resources :users, :only =>[:show]
end
