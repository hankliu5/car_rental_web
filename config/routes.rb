Rails.application.routes.draw do
  devise_for :users
  resource :cars
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # root 'welcome#index'
  root 'cars#index'
end
