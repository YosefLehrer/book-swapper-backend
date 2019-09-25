class Book < ApplicationRecord
    has_many :owned_books, :dependent => :delete_all
    has_many :users, through: :owned_books
end
