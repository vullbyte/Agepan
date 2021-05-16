Rails.application.routes.draw do
  devise_for :admins, controllers: {
    sessions:      'admins/sessions',
    passwords:     'admins/passwords',
    registrations: 'admins/registrations'
  }
  resources :admins
  resources :relationships, only: [:create, :destroy]


  devise_for :users, controllers: {
    sessions:      'users/sessions',
    passwords:     'users/passwords',
    registrations: 'users/registrations'
  }

  # マイページのルーティングにネスト
  resources :users do
    get :favorites, on: :collection
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'search' => 'searches#search'
  root to: 'homes#top'
  resources :posts, only: [:new, :create, :index, :show, :destroy] do
    resource :favorites, only: [:create, :destroy] # 記事詳細表示のルーティングにネスト
    resources :post_comments, only: [:create, :destroy]
  end
end
