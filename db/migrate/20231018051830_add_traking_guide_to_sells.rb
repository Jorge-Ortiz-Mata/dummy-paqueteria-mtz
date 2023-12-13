class AddTrakingGuideToSells < ActiveRecord::Migration[7.0]
  def change
    add_column :sells, :tracking_guide, :string
  end
end
