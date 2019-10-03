class Trade < ApplicationRecord
  belongs_to :owned_book
  belongs_to :requestee, class_name: "OwnedBook" 
end
