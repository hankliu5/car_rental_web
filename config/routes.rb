Rails.application.routes.draw do
  match '/users', to: 'users#index', via: 'get'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :cars
  resources :reservations

  root 'cars#index'
  devise_for :users, path_prefix: 'd', controllers: { registrations: 'users/registrations' }

  resources :users
  resource :user do
    collection do
      get 'edit_password'
    end
  end

  resource :user, only: [:edit_password] do
    collection do
      patch 'update_password'
    end
  end
end
