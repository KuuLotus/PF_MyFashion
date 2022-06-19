Rails.application.routes.draw do

devise_for :member,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

devise_scope :member do
    post 'members/guest_sign_in', to: 'public/sessions#guest_sign_in'
end

devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

root to: "public/homes#top"
get "men" => "public/homes#men"
get "women" => "public/homes#women"
get "tags/:id/posts" => "public/tags#tag_posts", as: :tag

scope module: :public do
  resources :members, except: [:new] do
    resource :relationships, only: [:create, :destroy]
    get :followings, on: :member
    get :followers, on: :member
    get :withdraw_confirm, on: :member
    patch :withdraw, on: :member
    collection do
      get :search
      get :men
      get :women
    end
  end
  resources :posts do
    resource :favorites, only: [:create, :destroy]
    resources :post_comments, only: [:create, :destroy]
    collection do
      get :search
      get :men
      get :women
    end
  end
end

namespace :admin do
  root to: "members#index"
  resources :members, only:[:show] do
    patch :withdraw, on: :member
    get :followings, on: :member
    get :followers, on: :member
    collection do
      get :search
      get :men
      get :women
    end
  end
  resources :posts, only:[:show, :index, :destroy] do
    resources :post_comments, only:[:destroy]
    collection do
      get :search
      get :men
      get :women
    end
  end
  resources :tags, only:[:index, :create, :destroy]
end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
