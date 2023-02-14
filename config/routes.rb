Rails.application.routes.draw do

  #ユーザー用
  # URL /users/sign_in ...
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "users/registrations",
    sessions: 'users/sessions',
  }

  root 'home#top'
  get 'home/about'
end
