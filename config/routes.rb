Rails.application.routes.draw do
  root 'application#main_page'
  get '/about', to: 'static_pages#about'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/signup', to: 'users#new'
  get '/home', to: 'books#index'
  get '/search', to: 'books#search'
  post '/books/new', to: 'books#new'
  resources :users
  resources :books
end
