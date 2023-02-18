Rails.application.routes.draw do

  namespace :shop do
    get 'manufacturers/unsubscribe'
    get 'manufacturers/withdraw'
    get 'manufacturers/show'
    get 'manufacturers/edit'
    get 'manufacturers/update'
  end
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
end
