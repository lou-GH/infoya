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
  get "posts/index"
  get "posts/show"

  namespace :shop do
    get 'manufacturers/unsubscribe'
    get 'manufacturers/withdraw'
    get 'manufacturers/my_page', to: 'manufacturers#show', as: :my_page
    get 'manufacturers/information/edit', to: 'manufacturers#edit'
    get 'manufacturers/information', to: 'manufacturers#update'

    resources :locations, only: [:edit, :create, :update, :destroy]
    resources :posts, only: [:new, :create, :destroy]

  end

end
