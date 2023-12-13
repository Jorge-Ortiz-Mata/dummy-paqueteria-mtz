class AddQuantityToArticles < ActiveRecord::Migration[7.0]
  def change
    add_column :articles, :in_stock, :integer

    Article.all.each do |article|
      article.update(in_stock: 0)
    end
  end
end
