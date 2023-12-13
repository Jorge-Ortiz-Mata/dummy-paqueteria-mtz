class RemoveInStockFromArticles < ActiveRecord::Migration[7.0]
  def change
    remove_column :articles, :in_stock
  end
end
