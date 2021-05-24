Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_for :admins, controllers: {
    sessions:      'admins/sessions',
    passwords:     'admins/passwords',
    registrations: 'admins/registrations'
  }
  # resources :admins
  namespace :admin do
    resources :posts,only: [:index, :show, :edit, :update, :destroy]
    resources :users, only: [:index, :create, :new, :edit, :show, :update, :destroy]
  end

  namespace :admin do
    resources :posts,only: [:index, :show, :edit, :update, :destroy]
    resources :users, only: [:index, :create, :new, :edit, :show, :update]
  end

  devise_for :users, controllers: {
    sessions:      'users/sessions',
    passwords:     'users/passwords',
    registrations: 'users/registrations'
  }
  resources :contacts, only: [:new, :create]

  resources :relationships, only: [:create, :destroy]
  resources :users do
    get :favorites, on: :collection
    get "favorites" => "users#favorites"  # マイページのルーティングにネスト
  end

  # 退会確認画面
  get '/users/:id/unsubscribe' => 'users#unsubscribe', as: 'unsubscribe'
  # 論理削除用のルーティング
  patch '/users/:id/withdrawal' => 'users#withdrawal', as: 'withdrawal'

  get 'search' => 'searches#search'
  root to: 'homes#top'
  get 'followed_posts' => 'posts#followed_posts'
  resources :posts, only: [:new, :create, :index, :show, :destroy] do
    resource :favorites, only: [:create, :destroy] # 記事詳細表示のルーティングにネスト
    resources :post_comments, only: [:create, :destroy]
    member do
      get :users_posts
    end
  end
end
