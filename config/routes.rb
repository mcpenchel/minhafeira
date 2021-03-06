Rails.application.routes.draw do
  devise_for :users
  resources :shops do
    resources :products, only: [:new, :create]
  end
  resources :carts, only: [:index, :show, :update]

  resources :products, only: [:edit, :update, :destroy] do
    resources :cart_products, only: [:create, :update, :destroy]
  end
  root to: 'shops#index'

  # devise_for :users, controllers: {registrations:'user/registrations'}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
