class AddShipmentNumberToSales < ActiveRecord::Migration[7.0]
  def change
    add_column :sells, :shipment_number, :integer, default: 0
  end
end
