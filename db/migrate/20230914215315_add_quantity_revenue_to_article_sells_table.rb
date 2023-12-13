class AddQuantityRevenueToArticleSellsTable < ActiveRecord::Migration[7.0]
  def change
    add_column :article_sells, :quantity, :integer
    add_column :article_sells, :revenue, :decimal, default: 0.0
  end
end
