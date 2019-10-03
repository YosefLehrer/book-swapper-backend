Rails.application.routes.draw do
  resources :owned_books, :books, :users
  
  get "/books/search/q=:searchTerm", to: "books#search"
  get "/user_library", to: "users#user_library"
  get '/autologin', to: 'auth#autologin'

  post "/login", to: "auth#login"
  post "/offer_trade", to: "trades#find_or_create"
  post "accept_trade", to: "trades#accept_trade"
end
