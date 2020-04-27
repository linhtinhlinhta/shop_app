 Rails.application.routes.draw do
  devise_for :users

  resources :products do
    resources :images
  end

  resources :categories
  resources :users

  resources :order_items

  resource :carts, only: [:show]

  get 'admin/', to: 'admin#dashboard'
  namespace :admin do
    resources :categories
    resources :products do
      resources :images
    end
  end

  root 'homes#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
