Rails.application.routes.draw do
  root to: "homes#top"
  get '/home/about' => 'homes#about'
  devise_for :users
  resources :books, only: [:edit,  :create, :index, :show, :update, :destroy]
  resources :users, only: [:show, :edit, :index, :update]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
