class AddCarrierNameToSells < ActiveRecord::Migration[7.0]
  def change
    add_column :sells, :carrier_name, :string
  end
end
