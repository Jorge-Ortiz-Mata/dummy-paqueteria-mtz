class CreateDefaultPrices < ActiveRecord::Migration[7.0]
  def change
    create_table :default_prices do |t|
      t.integer :category
      t.integer :width
      t.integer :length
      t.integer :height
      t.decimal :price

      t.timestamps
    end
  end
end
