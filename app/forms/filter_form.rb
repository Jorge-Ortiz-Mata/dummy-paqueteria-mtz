class FilterForm
  include ActiveModel::Model

  attr_accessor :min_price, :max_price

  validate :min_price_is_less_than_max_price

  def save
    return false if invalid?

    true
  end

  def search_process
    articles = Article.all.order(:id)

    articles = by_min_price(articles) if min_price.present?
    articles = by_max_price(articles) if max_price.present?

    articles
  end

  private

  def min_price_is_less_than_max_price
    return unless min_price.present? && max_price.present?

    errors.add(:max_price, :price_is_less_than_min_price) if min_price.to_d > max_price.to_d
  end

  def by_min_price(articles)
    Article.with_min_price(articles, min_price.to_d)
  end

  def by_max_price(articles)
    Article.with_max_price(articles, max_price.to_d)
  end
end
