Rails.application.routes.draw do
  root to: 'users#new'
  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  post   '/search_by_isbn',   to: 'books#search_by_isbn'
  resources :books
end
