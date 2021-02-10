Rails.application.routes.draw do

  mount ActionCable.server => '/cable'
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

  resources :rooms, only: [:create, :show]
  resources :messages, only: [:create]
  get "show_additionally", to: "rooms#show_additionally"
  
  resources :relationships, only: [:create, :destroy]
end