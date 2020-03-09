Rails.application.routes.draw do
  root to: 'books#index'
  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  post 'guest', to: 'sessions#guest'
  resources :users
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
