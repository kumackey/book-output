Rails.application.routes.draw do
  root to: 'users#new'
  get 'sign_up', to: 'users#new'
  post 'sign_up', to: 'users#create'
  get 'sign_in', to: 'sessions#new'
  post 'sign_in', to: 'sessions#create'
  resources :books, shallow: true do
    collection do
      get :search
    end
  end
end
