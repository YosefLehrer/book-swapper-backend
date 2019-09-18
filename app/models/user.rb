class User < ApplicationRecord
    has_many :owned_books, :dependent => :delete_all
    has_many :users, through: :owned_books
    has_secure_password
end
