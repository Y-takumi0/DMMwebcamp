Rails.application.routes.draw do
  root to: 'homes#top'
  get '/about' => 'homes#about'
  resources :items, only: [:index, :show]

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

 namespace :admin do
   root to: 'homes#top'
   resources :items, only: [:index, :new, :create, :show, :edit, :update]
   resources :genres, only: [:index, :create, :edit, :update]
   resources :customers, only: [:index, :show, :edit, :update]
   resources :orders, only: [:show, :update]
   resources :order_details, only: [:update]
 end
  scope module: :public do
    get "customers/mypage" => "customers#show"
    get "customers/information/edit" => "customers#edit"
    patch "customers/information" => "customers#update"
    resources :cart_items, only: [:index, :update, :destroy, :create]
    delete "cart_items/destroy" => "cart_items#destroy_all"
    resources :orders, only: [:index, :new, :create, :show]
    get "orders/complete" => "orders#complete"
    post "orders/confirmation" => "orders#confirmation"
    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
  end

end
