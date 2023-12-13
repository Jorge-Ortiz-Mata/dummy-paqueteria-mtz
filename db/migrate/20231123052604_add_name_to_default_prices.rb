class AddNameToDefaultPrices < ActiveRecord::Migration[7.0]
  def change
    add_column :default_prices, :name, :string

    return unless DefaultPrice.any?

    DefaultPrice.box.order(:id).each_with_index do |default_price, index|
      default_price.update(name: "caja_#{index}")
    end
  end
end
