Rails.application.routes.draw do
  resources :owned_books, :books, :users
  
  get "/books/search/q=:searchTerm", to: "books#search"
  post "/login", to: "auth#login"
  get '/autologin', to: 'auth#autologin'
end
