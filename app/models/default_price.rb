class DefaultPrice < ApplicationRecord
  enum category: %i[box]

  validates :price, presence: true

  def volume
    return width * length * height if width && length && height

    '--'
  end

  def difference
    prev = DefaultPrice.find(id - 1)

    return if prev.blank?

    price_difference = price - prev.price
    volume_difference = volume - prev.volume

    volume_difference / price_difference
  end
end
