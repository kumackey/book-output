Rails.application.routes.draw do
  root to: 'static_pages#top'
  get 'home', to: 'static_pages#home'
  get 'contact', to: 'static_pages#contact'

  # ユーザリソース
  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'

  # セッションリソース
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  post 'guest_login', to: 'sessions#guest_login'

  # その他リソース
  resources :questions, only: %i[index] do
    collection do
      get :random
    end
  end
  resources :users, only: %i[show]
  resources :books, only: %i[index create new show], shallow: true do
    collection do
      get :search
    end
    resources :questions, only: %i[create new show destroy]
  end
  resources :likes, only: %i[create destroy]
  resources :choices, only: %i[show]

  namespace :mypage do
    resource :account, only: %i[edit update]
    resource :like_books, only: %i[show]
    resource :make_questions, only: %i[show]
  end
end
