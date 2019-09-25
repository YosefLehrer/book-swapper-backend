class ChangeBooksIsbnToLimitEight < ActiveRecord::Migration[5.2]
  def change
    change_column :books, :ISBN, :integer, limit: 8
  end
end
