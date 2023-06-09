Rails.application.routes.draw do
  root to: "homes#top"
  get '/about' => 'homes#about'
  devise_for :users
  resources :books, only: [:edit, :index, :show]
  resources :users, only: [:show, :edit, :index]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
