class AddPhoneCodeToSells < ActiveRecord::Migration[7.0]
  def change
    add_column :sells, :phone_code, :string
  end
end
