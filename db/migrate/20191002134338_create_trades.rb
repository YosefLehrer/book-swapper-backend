class CreateTrades < ActiveRecord::Migration[5.2]
  def change
    create_table :trades do |t|
      t.belongs_to :owned_book, foreign_key: true
      t.belongs_to :requestee
      t.timestamps
    end
  end
end
