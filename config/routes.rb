Rails.application.routes.draw do
  root 'application#main_page'
  get '/about', to: 'static_pages#about'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/signup', to: 'users#new'
  get '/home', to: 'books#index'
  get '/search_api', to: 'books#search_books_api'
  get '/search', to: 'books#search'
  post '/books/new', to: 'books#new'
  patch '/books/:id/sell', to: 'books#sell', as: 'sell_book'
  get '/generate_csv_report', to: 'books#generate_csv_report', as: 'csv_report'
  get '/generate_pdf_report', to: 'books#generate_pdf_report', as: 'pdf_report'
  resources :users
  resources :books
end
