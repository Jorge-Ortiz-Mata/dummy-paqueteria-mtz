class AddInsuredArticlesToArticlesSells < ActiveRecord::Migration[7.0]
  def change
    add_reference :article_sells, :insurance_policy, foreign_key: true
    add_column :article_sells, :insured_articles, :integer
  end
end
