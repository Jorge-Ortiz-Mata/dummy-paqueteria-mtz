class CreateArticleSells < ActiveRecord::Migration[7.0]
  def change
    create_table :article_sells do |t|
      t.references :article, null: false, foreign_key: true
      t.references :sell, null: false, foreign_key: true

      t.timestamps
    end
  end
end
