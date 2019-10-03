class AddStatusToTrades < ActiveRecord::Migration[5.2]
  def change
    add_column :trades, :status, :boolean, :default => false
  end
end
