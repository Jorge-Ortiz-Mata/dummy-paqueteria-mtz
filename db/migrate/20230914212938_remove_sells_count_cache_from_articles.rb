class RemoveSellsCountCacheFromArticles < ActiveRecord::Migration[7.0]
  def change
    remove_column :articles, :sells_count
  end
end
