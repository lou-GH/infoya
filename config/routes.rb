Rails.application.routes.draw do

  # 管理者用
  # URL /admin/sign_in
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
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

  root 'home#top'
  get 'home/about'
  get 'home/sign_in'
  get 'home/sign_up'

  namespace :shop do
    get 'manufacturers/unsubscribe'
    get 'manufacturers/withdraw'
    get 'manufacturers/my_page', to: 'manufacturers#show'
    get 'manufacturers/information/edit', to: 'manufacturers#edit'
    get 'manufacturers/information', to: 'manufacturers#update'

    resources :locations, only: [:edit, :create, :update, :destroy]
    resources :posts, only: [:index, :new, :show, :create, :destroy] do
      resources :comments, only: [:create, :destroy]
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
    get 'users/withdraw'
    get 'users/my_page', to: 'users#show'
    get 'users/information/edit', to: 'users#edit'
    get 'users/information', to: 'users#update'

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
      resources :comments, only: [:create, :destroy]
    end

  end

  namespace :admin do
    resources :posts, only: [:index, :show] do
      resources :comments, only: [:destroy]
    end
    resources :genres, only: [:index, :destroy]
  end

end
