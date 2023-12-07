Rails.application.routes.draw do

  devise_for :users
  root to:"homes#top"

  resources :users,only: [:index,:show,:edit,:update,:create]
  resources :books,only: [:index,:show,:edit,:update,:destroy,:create] do
    resource :favorite,only: [:create,:destroy]
    resources :book_comments,only: [:create,:update]
  end

  get '/home/about' => 'homes#about',as: 'about'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
