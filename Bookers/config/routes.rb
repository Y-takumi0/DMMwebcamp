Rails.application.routes.draw do
  resources :books, only: [:new, :index, :show, :edit]
  get '/' => 'homes#top'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
