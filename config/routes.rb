Rails.application.routes.draw do

  devise_for :users, controllers: { :registrations => "users/registrations" }
  root to: "home#index"
  resources :users, only: [:show] do
    resources :reviews, only: [:index, :new, :create]
  end
  resources :post_c
  resources :post_sitter
end