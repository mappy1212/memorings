Rails.application.routes.draw do
  get 'chats/index'
  get 'chats/show'
  devise_for :users
  
  root "tweets#index"
  resources :users, only: [:index, :show, :edit, :update]
  resources :chats
  resources :tweets do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: :create
    collection do
      get 'search'
    end
  end
end
