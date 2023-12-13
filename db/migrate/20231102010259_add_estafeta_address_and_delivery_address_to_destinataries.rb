class AddEstafetaAddressAndDeliveryAddressToDestinataries < ActiveRecord::Migration[7.0]
  def change
    add_column :destinataries, :estafeta_office_address, :string
    add_column :destinataries, :delivery_place, :integer
  end
end
