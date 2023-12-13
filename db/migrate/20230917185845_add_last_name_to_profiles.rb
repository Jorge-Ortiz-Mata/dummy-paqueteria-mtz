class AddLastNameToProfiles < ActiveRecord::Migration[7.0]
  def change
    add_column :profiles, :last_name, :string
  end
end
