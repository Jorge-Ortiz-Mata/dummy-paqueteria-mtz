class SellsFilter
  include ActiveModel::Model

  attr_accessor :date_min, :date_max

  validate :date_min_less_than_date_max
  validate :date_max_equal_today_date

  def save
    self.date_min = date_min.to_date
    self.date_max = date_max.to_date

    return false if invalid?

    true
  end

  def search
    sells = by_date(Sell.all)

    sells.order(created_at: :desc)
  end

  private

  def date_min_less_than_date_max
    return unless date_min.present? && date_max.present?

    errors.add(:date_max, :less_than_date_min) if date_min > date_max
  end

  def date_max_equal_today_date
    return unless date_max.present?

    errors.add(:date_max, :more_than_today) if date_max.to_date > Date.today
  end

  def by_date(sells)
    sells = Sell.filter_with_date_min(sells, date_min.to_date) if date_min.present?
    sells = Sell.filter_with_date_max(sells, date_max.to_date) if date_max.present?

    sells
  end
end
