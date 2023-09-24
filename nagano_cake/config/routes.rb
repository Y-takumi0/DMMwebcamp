Rails.application.routes.draw do
  root to: 'homes#top'
  get '/about' => 'homes#about'

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

 namespace :admin do
   resources :items, only: [:index, :new, :create, :show, :edit, :update]
   resources :genres, only: [:index, :create, :edit, :update]
   resources :customers, only: [:index, :show, :edit, :update]
   resources :orders, only: [:show, :update]
   resources :order_details, only: [:update]
 end

  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  scope module: :public do
    resources :items, only: [:index, :show]
    resources :customers, only: [:show, :edit, :update] do
      collection do
        get 'unsubscribe'
        patch 'withdraw'
      end
    end
     resources :cart_items, only: [:index, :update, :destroy] do
      collection do
        delete 'all_destroy'
      end
    end
     resources :orders, only: [:new, :create, :index, :show] do
      collection do
        get 'confirmation'
        get 'complete'
      end
    end
     resources :addresses, only: [:create, :index, :edit, :update, :destroy]
  end

end
