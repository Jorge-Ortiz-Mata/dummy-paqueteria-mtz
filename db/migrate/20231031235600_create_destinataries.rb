class CreateDestinataries < ActiveRecord::Migration[7.0]
  def change
    create_table :destinataries do |t|
      t.string :full_name
      t.string :street
      t.string :ext_number
      t.string :int_number
      t.string :neighborhood
      t.string :city
      t.string :state
      t.string :zip_code
      t.string :primary_phone_number
      t.string :secondary_phone_number
      t.references :remitent, null: false, foreign_key: true

      t.timestamps
    end
  end
end
