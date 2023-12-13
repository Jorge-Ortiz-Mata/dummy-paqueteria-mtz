class ArticleSell < ApplicationRecord
  belongs_to :article
  belongs_to :sell
  belongs_to :insurance_policy, optional: true

  validates :article_id, :quantity, presence: true
  validates :insured_articles, :insurance_policy_id, presence: true, if: :insurance_info_present?
  validates :quantity, numericality: { only_integer: true, message: 'debe tener solo números' }
  validates :quantity, comparison: { greater_than_or_equal_to: 0 }
  validates :insured_articles, numericality: { only_integer: true, message: 'debe tener solo números' }, if: :insurance_info_present?
  validates :insured_articles, comparison: { greater_than_or_equal_to: 0 }, if: :insurance_info_present?
  validate :article_exists?
  validate :insured_articles_with_quantity, if: :insurance_info_present?

  before_save :set_revenue

  def insured_articles_text
    return 'N/A' if insured_articles.blank?

    insured_articles
  end

  def insurance_policy_text
    return 'N/A' if insurance_policy.blank?

    "#{insurance_policy.percentage} %"
  end

  def special_price_text
    return '--' if special_price.blank?

    "$ #{special_price} USD"
  end

  private

  def article_exists?
    errors.add(:article_id, :article_does_not_exist) unless Article.find_by(id: article_id).present?
  end

  def set_revenue
    total_revenue = 0

    if special_price.present?
      total_revenue = quantity.to_d * special_price.to_d
    else
      total_revenue = quantity.to_d * self.article.price.to_d
    end

    return self.revenue = total_revenue unless insurance_policy_id.present?

    insurance_price = insurance_policy.price * insured_articles.to_i
    total_revenue += insurance_price

    self.revenue = total_revenue
  end

  def insurance_info_present?
    return true if insured_articles.present? || insurance_policy_id.present?

    false
  end

  def insured_articles_with_quantity
    return if insured_articles.blank?

    errors.add(:insured_articles, :greater_than_quantity) if quantity < insured_articles
  end
end
