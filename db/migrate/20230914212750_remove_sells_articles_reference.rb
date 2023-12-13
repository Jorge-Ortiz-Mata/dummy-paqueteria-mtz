class RemoveSellsArticlesReference < ActiveRecord::Migration[7.0]
  def change
    remove_reference :sells, :article, index: true, foreign_key: true
  end
end
