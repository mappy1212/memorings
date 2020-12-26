Rails.application.routes.draw do
  devise_for :users
  
  root "tweets#index"
  resources :users, only: [:index, :edit, :update]
  resources :tweets, only: [:index, :edit, :update]
end
