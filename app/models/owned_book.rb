class OwnedBook < ApplicationRecord
  belongs_to :book
  belongs_to :user
  has_many :trades, dependent: :destroy  
  has_many :requestees, through: :trades
end
