Rails.application.routes.draw do

devise_for :member,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

root to: "public/posts#index"

scope module: :public do
  resources :members, except: [:new] do
    resource :relationships, only: [:create, :destroy]
    get :followings, on: :member
    get :followers, on: :member
    get :withdraw_confirm, on: :member
    patch :withdraw, on: :member
  end
  resources :posts, except:[:index] do
    resource :favorites, only: [:create, :destroy]
    resources :post_comments, only: [:create, :destroy]
  end
end

namespace :admin do
  root to: "members#index"
  resources :members, only:[:show]
end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
