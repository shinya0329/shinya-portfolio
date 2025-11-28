Rails.application.routes.draw do
  
  devise_for :users
 
  root "homes#top"
  get 'home/about', to: 'homes#about'
  
  get '/categorys', to: 'posts#categorys' #カテゴリー一覧ページへのルーティング
  get 'posts/category/:category', to: 'posts#category' #カテゴリー詳細ページへのルーティング
  
  resources :users, only: [:index, :show, :edit, :update]

  resources :posts, only: [:new, :create, :index, :show, :destroy] do
    resources :post_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end

end