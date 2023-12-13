class AddTotalRevenueToSellsTable < ActiveRecord::Migration[7.0]
  def change
    add_column :sells, :total_revenue, :decimal, default: 0

    Sell.all.each do |sell|
      sell.update!(total_revenue: sell.quantity * sell.article.price)
    end
  end
end
