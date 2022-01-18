Rails.application.routes.draw do

  # 顧客用ルーティング
  devise_for :customers,skip: [:passwords,], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  scope module: :public do
    resource :customers, only: [:edit, :update] do
      collection do
        get 'my_page' => "customers#show"
        get "unsubscribe" => "customers#unsubscribe"
        patch "out" => "customers#out"
      end
    end

    root to: "homes#top"
    get "about" => "homes#about", as: "about"

    resources :products, only: [:index, :show] do
      collection do
        get "search" => "products#search"
      end
    end

    resources :cart_products, only: [:index, :create, :update, :destroy] do
      collection do
        delete "destroy_all" => "cart_products#destroy_all"
      end
    end

    resources :orders, only: [:new, :create, :index, :show] do
      collection do
        get "confirm" => "orders#confirm"
        get "thanx" => "orders#thanx"
      end
    end

    resources :ship_addresses, only: [:index, :create, :edit, :update, :destroy]
  end

  # 管理者用ルーティング
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


