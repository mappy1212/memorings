Rails.application.routes.draw do
  get 'tweets/index'
  root "tweets#index"
  resources :users, only: [:index, :edit, :update]
  resources :tweets, only: [:index, :edit, :update]
end
