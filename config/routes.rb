Rails.application.routes.draw do

  # 管理者用
  # URL /admin/sign_in
  devise_for :admin, skip: [:passwords] ,controllers: {
  sessions: "admin/sessions"
  }
  #生産者用
  # URL /manufacturers/sign_in ...
  devise_for :manufacturers, skip: [:passwords], controllers: {
    registrations: "shop/registrations",
    sessions: 'shop/sessions',
  }
  #ユーザー用
  # URL /users/sign_in ...
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions',
  }
    devise_scope :user do
      post 'public/guest_sign_in', to: 'public/sessions#new_guest'
    end

  root 'home#top'
  # get 'home/about'
  get 'home/sign_up'
  get 'home/sign_in'

  namespace :shop do
    get 'manufacturers/unsubscribe'
    patch 'manufacturers/withdraw'
    get 'manufacturers/my_page', to: 'manufacturers#show'
    get 'manufacturers/information/edit', to: 'manufacturers#edit'
    patch 'manufacturers/information/edit', to: 'manufacturers#update'

    resources :locations, only: [:edit, :create, :update, :destroy]
    resources :posts, only: [:index, :new, :show, :create, :destroy, :update] do
      resources :comments, only: [:create, :destroy, :update]
    end
    resources :genres do
      get 'posts', to: 'posts#search'
    end
    resource :favorites, only: [:create, :destroy]
    get 'users' => 'registrations#followers', as: 'followers'

    resources :notifications, only: %i[index destroy]

  end

  namespace :public do
    get 'users/unsubscribe'
    patch 'users/withdraw'
    get 'users/my_page', to: 'users#show'
    get 'users/information/edit', to: 'users#edit'
    patch 'users/information/edit', to: 'users#update'

    resource :relationships, only: [:create, :destroy]
    get 'users/:id/followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'

    get 'manufacturers/:manufacturer_id' , to: 'manufacturers#show', as: 'manufacturer'
    get 'manufacturers' , to: 'manufacturers#index', as: 'manufacturers'

    resources :genres do
      get 'posts', to: 'posts#search'
    end

    resources :notifications, only: %i[index destroy]

    resources :posts, only: [:index, :show] do
      resources :comments, only: [:create, :destroy, :update]
    end

  end

  namespace :admin do
    resources :posts, only: [:index, :show, :destroy] do
      resources :comments, only: [:destroy]
    end
    resources :genres, only: [:index, :destroy]
    resources :manufacturers, only: [:index, :show, :update]
    resources :users, only: [:index, :show, :update]
  end

end
