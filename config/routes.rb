Rails.application.routes.draw do
  root to: 'static_pages#top'
  get 'home', to: 'static_pages#home'

  # ユーザリソース
  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'

  # セッションリソース
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  post 'guest_login', to: 'sessions#guest_login'

  # その他リソース
  get 'outputs', to: 'outputs#index'
  get 'outputs/random', to: 'outputs#random'
  resources :books, only: %i[index create new show], shallow: true do
    collection do
      get :search
    end
    resources :outputs, only: %i[create new show destroy]
  end
  resources :likes, only: %i[create destroy]
  resources :choices, only: %i[] do
    member do
      get :check, to: 'choices#check'
    end
  end
end
