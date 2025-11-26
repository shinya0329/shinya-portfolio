Rails.application.routes.draw do
  devise_for :users
  root 'homes#top'

    resources :posts, only: [:new, :create, :index, :show, :destroy] do
      resources :post_comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
    end
end
