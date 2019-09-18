class Book < ApplicationRecord
    has_many :owned_books
    has_many :users, through: :owned_books
end
