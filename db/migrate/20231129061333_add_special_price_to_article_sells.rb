class AddSpecialPriceToArticleSells < ActiveRecord::Migration[7.0]
  def change
    add_column :article_sells, :special_price, :decimal
  end
end
