class RemoveQuantityTotalRevenueAndCommentFromSells < ActiveRecord::Migration[7.0]
  def change
    remove_column :sells, :quantity
    remove_column :sells, :comment
    remove_column :sells, :total_revenue
  end
end
