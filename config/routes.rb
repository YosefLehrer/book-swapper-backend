Rails.application.routes.draw do
  resources :owned_books, :books, :users, except: [:index]
  
  post "/login", to: "auth#login"
  post "/autologin", to: "auth#autologin"
end
