Rails.application.routes.draw do
  devise_for :users
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  resources :products do
    resources :images
  end

  resources :categories
  resources :users

  resources :order_items

  resource :carts, only: [:show]

  root 'homes#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
