Rails.application.routes.draw do
  root to: 'users#new'
  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  resources :users
  resources :books, shallow: true do
    collection do
      get :search
    end
  end
end
