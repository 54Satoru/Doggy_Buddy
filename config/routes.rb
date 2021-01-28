Rails.application.routes.draw do

  devise_for :users, controllers: { :registrations => "users/registrations" }
  root to: "home#index"
  
  resources :users, only: [:show] do
    resources :reviews, only: [:index, :new, :create]
    member do
      get :following, :followers
    end
    collection do
      get :favorite_cs
      get :favorite_sitters
    end
  end
  
  resources :post_c do
    resource :favorite_cs, only: [:create, :destroy]
  end

  resources :post_sitter do
    resource :favorite_sitters, only: [:create, :destroy]
  end
  
  resources :relationships, only: [:create, :destroy]
end