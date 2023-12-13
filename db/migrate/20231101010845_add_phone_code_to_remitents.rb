class AddPhoneCodeToRemitents < ActiveRecord::Migration[7.0]
  def change
    add_column :remitents, :phone_code, :string
  end
end
