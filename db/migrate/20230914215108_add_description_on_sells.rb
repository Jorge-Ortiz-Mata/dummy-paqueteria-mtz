class AddDescriptionOnSells < ActiveRecord::Migration[7.0]
  def change
    add_column :sells, :description, :string
  end
end
