Rails.application.routes.draw do

  root to: "homes#top"
  get "about" => "homes#about", as: "about"

  resources :products, only: [:index, :show] do
    collection do
      get "search" => "products#search"
    end
  end

  # 顧客用
  # URL /customers/sign_in ...
  devise_for :customers,skip: [:passwords,], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  scope module: :public do
    resource :customers, only: [:show, :edit, :update] do
      collection do
        get "unsubscribe" => "customers#unsubscribe"
        patch "out" => "customers#out"
      end
    end

    resources :cart_items, only: [:index, :create, :update, :destroy] do
      collection do
        delete "destroy_all" => "cart_items#destroy_all"
      end
    end

    resources :orders, only: [:new, :create, :index, :show] do
      collection do
        get "log" => "orders#log"
        get "thanx" => "orders#thanx"
      end
    end

    resource :order_products, only: [:create]

    resources :ship_addresses, only: [:index, :create, :edit, :update, :destroy]
  end




  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
  namespace :admin do
    resources :customers, only: [:index, :show, :edit, :update]

    resources :products, except: [:destroy]

    resources :genres, only: [:index, :create, :edit, :update]

    resources :orders, only: [:index, :show, :update] do
      collection do
        get "search"
      end
    end

    resources :order_products, only: [:update]
  end
end


