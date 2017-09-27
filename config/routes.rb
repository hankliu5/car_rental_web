Rails.application.routes.draw do
  match '/users', to: 'users#index', via: 'get'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :cars

  resources :reservations

  resource :reservation, only: :show do
    collection do
      get 'checkout', to: 'reservations#check_out'
      get 'return_car', to: 'reservations#return_car'
    end
  end

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
