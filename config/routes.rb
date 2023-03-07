Rails.application.routes.draw do

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

  end

  namespace :public do
    get 'users/unsubscribe'
    get 'users/withdraw'
    get 'users/my_page', to: 'users#show'
    get 'users/information/edit', to: 'users#edit'
    get 'users/information', to: 'users#update'

    resources :posts, only: [:index, :show] do
      resources :comments, only: [:create, :destroy]
    end
    resource :relationships, only: [:create, :destroy]
    get 'manufacturers' => 'registrations#followings', as: 'followings'

  end

end
