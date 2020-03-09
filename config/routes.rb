Rails.application.routes.draw do
  root to: 'static_pages#home'
  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'

  # セッション系
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  post 'guest_login', to: 'sessions#guest_login'
  
  # リソース系
  resources :books, shallow: true do
    collection do
      get :search
    end
    resources :outputs
  end
  resources :likes, only: %i[create destroy]
  resources :choices, only: %i[] do
    member do
      post :check, to: 'choices#check'
    end
  end
end
