Rails.application.routes.draw do
  get 'chats/index'
  get 'chats/show'
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  devise_scope :user do
    get 'guest', to: 'users/sessions#new'
  end
  
  root "tweets#index"
  resources :users, only: [:index, :show, :edit, :update]
  resources :chats
  namespace :api do
    resources :chats, only: :show, defaults: { format: 'json' }
  end
  resources :tweets do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: :create
    collection do
      get 'search'
    end
  end
end
