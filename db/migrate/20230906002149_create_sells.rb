class CreateSells < ActiveRecord::Migration[7.0]
  def change
    create_table :sells do |t|
      t.references :article, null: false, foreign_key: true
      t.integer :quantity
      t.string :day
      t.string :comment

      t.timestamps
    end
  end
end
