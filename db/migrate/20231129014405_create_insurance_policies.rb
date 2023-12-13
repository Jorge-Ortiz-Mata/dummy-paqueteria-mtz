class CreateInsurancePolicies < ActiveRecord::Migration[7.0]
  def change
    create_table :insurance_policies do |t|
      t.integer :percentage
      t.integer :price

      t.timestamps
    end
  end
end
