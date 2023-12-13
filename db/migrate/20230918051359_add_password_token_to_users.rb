class AddPasswordTokenToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :recover_password_token, :string
  end
end
