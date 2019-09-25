class User < ApplicationRecord
    has_many :owned_books, :dependent => :delete_all
    has_many :books, through: :owned_books
    has_secure_password

    validates :user_name, uniqueness: true
end
