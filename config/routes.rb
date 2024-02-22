Rails.application.routes.draw do


  devise_for :users
  root to:"homes#top"

  resources :users,only: [:index,:show,:edit,:update,:create] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end

  resources :books,only: [:index,:show,:edit,:update,:destroy,:create] do
    resource :favorites,only: [:create,:destroy]
    resources :book_comments,only: [:create,:destroy]
  end

  resources :messages, only: [:create]
  resources :rooms, only: [:create,:show]
  # 通知機能
  resources :notifications, only: [:index, :destroy]

  get '/home/about' => 'homes#about',as: 'about'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
