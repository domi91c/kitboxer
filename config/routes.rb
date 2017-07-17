Rails.application.routes.draw do
  resources :images
  resources :listings
  root to: 'visitors#index'
  devise_for :users
  resources :users
end
