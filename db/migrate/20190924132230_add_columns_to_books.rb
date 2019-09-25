class AddColumnsToBooks < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :description, :string
    add_column :books, :publisheddate, :string
    add_column :books, :pagecount, :integer
    add_column :books, :rating, :integer
    add_column :books, :infolink, :string
    add_column :books, :googleid, :string
  end
end
