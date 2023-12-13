class Article < ApplicationRecord
  scope :search_with_name, ->(name) { where("name LIKE '%#{name}%'") }
  scope :with_min_price, ->(articles, min_price) { articles.where('price > ?', min_price) }
  scope :with_max_price, ->(articles, max_price) { articles.where('price < ?', max_price) }

  validates :name, :price, presence: true
  validates :name, uniqueness: true
  validates :price, comparison: { greater_than_or_equal_to: 0 }

  has_many :article_sells
  has_many :sells, through: :article_sells

  before_destroy :delete_articles_associations

  private

  def delete_articles_associations
    ArticleSell.where(article_id: id).delete_all
  end
end
