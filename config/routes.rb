# frozen_string_literal: true

Rails.application.routes.draw do
  get 'search', to: 'search#index'
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  resources :products, except: %i[new index] do
    resources :comments, except: %i[show new index]
  end
  resources :users do
    resources :products, only: %i[index new]
    resources :orders, only: :index
    resource :wishlist, only: :show do
      member do
        get :add_product
        get :delete_product
      end
    end
  end
  get 'products', to: 'products#all_products'
  resources :carts, only: [:show] do
    post :add_to_cart
    post :update_cart
    delete :remove_from_cart
  end
  namespace :paypal do
    resources :checkouts, only: [:create] do
      collection do
        get :complete
      end
    end
  end
  root 'home#index'
  # get '*path', to: 'application#routing_error'

  # api
  namespace :api do
    namespace :v1 do
      get 'products', to: 'products#all_products'
      resources :products, only: :show
      resources :users do
        resources :products, only: :index
      end
    end
  end
end
