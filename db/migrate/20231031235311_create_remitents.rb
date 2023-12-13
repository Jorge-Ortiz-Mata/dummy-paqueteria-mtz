class CreateRemitents < ActiveRecord::Migration[7.0]
  def change
    create_table :remitents do |t|
      t.string :name
      t.string :phone_number
      t.string :address

      t.timestamps
    end
  end
end
