class RemoveDayFromTheSellsTable < ActiveRecord::Migration[7.0]
  def change
    remove_column :sells, :day
  end
end
