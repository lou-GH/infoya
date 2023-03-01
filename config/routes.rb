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
    resources :posts, only: [:index, :new, :show, :create, :destroy]

  end

end
