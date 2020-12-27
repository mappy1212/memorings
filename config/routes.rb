Rails.application.routes.draw do
  devise_for :users
  
  root "tweets#index"
  resources :users, only: [:index, :show, :edit, :update]
  resources :tweets, only: [:index, :show, :new, :create, :edit, :update, :destroy]
end
