Rails.application.routes.draw do

  devise_for :users, controllers: { :registrations => "users/registrations" }
  root to: "home#index"
  resources :users, only: [:show]
  resources :post_c
  resources :post_sitter
end