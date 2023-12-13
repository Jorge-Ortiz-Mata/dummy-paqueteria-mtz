class Sell < ApplicationRecord
  scope :filter_with_date_min, ->(sells, date_min) { sells.where('created_at >= ?', date_min) }
  scope :filter_with_date_max, ->(sells, date_max) { sells.where('created_at <= ?', date_max) }

  has_many :article_sells
  has_many :articles, through: :article_sells
  has_rich_text :description

  before_destroy :delete_articles_associations

  belongs_to :departure_date
  belongs_to :remitent, optional: true
  belongs_to :destinatary, optional: true

  CARRIER_PROVIDERS = [
    'CASTORES',
    'DHL',
    'ESTAFETA',
    'FEDEX',
    'OTRO'
  ].freeze

  # def self.revenue_by_day
  #   data = []

  #   for i in 0...30
  #     day_total_revenue = 0
  #     from_date = Date.today - i.day

  #     sells = Sell.where(created_at: from_date.beginning_of_day..from_date.end_of_day)

  #     sells.each do |sell|
  #       sell_revenue = sell.article_sells.sum(:revenue)
  #       day_total_revenue += sell_revenue
  #     end

  #     data << [from_date, day_total_revenue]
  #   end

  #   data
  # end

  def description_text
    return '--' unless description.present?

    description
  end

  def tracking_guide_text
    return '--' unless tracking_guide.present?

    tracking_guide
  end

  def remitent_name
    return '--' unless remitent.present?

    remitent.name
  end

  def remitent_phone_number
    return '--' unless remitent.present?

    "#{remitent.phone_code}#{remitent.phone_number}"
  end

  def remitent_address
    return '--' unless remitent.present? && remitent.address.present?

    remitent.address
  end

  def destinatary_full_name
    return '--' unless destinatary.present?

    destinatary.full_name
  end

  def destinatary_primary_phone_number
    return '--' unless destinatary.present?

    destinatary.primary_phone_number
  end

  def destinatary_secondary_phone_number
    return '--' unless destinatary.present? && destinatary.secondary_phone_number.present?

    destinatary.secondary_phone_number
  end

  def destinatary_street
    return '--' unless destinatary.present?

    destinatary.street
  end

  def destinatary_ext_number
    return '--' unless destinatary.present?

    destinatary.ext_number
  end

  def destinatary_neighborhood
    return '--' unless destinatary.present?

    destinatary.neighborhood
  end

  def destinatary_city
    return '--' unless destinatary.present?

    destinatary.city
  end

  def destinatary_state
    return '--' unless destinatary.present?

    destinatary.state
  end

  def destinatary_zip_code
    return '--' unless destinatary.present?

    destinatary.zip_code
  end

  def destinatary_deliver_place
    return '--' unless destinatary.present?

    if destinatary.home?
      "Calle: #{destinatary.street}, No. ext: #{destinatary.ext_number}, Colonia: #{destinatary.neighborhood}, Ciudad: #{destinatary.city}, Estado: #{destinatary.state}, Código Postal: #{destinatary.zip_code}"
    else
      destinatary.estafeta_office_address
    end
  end

  def carrier_name_text
    return '--' unless carrier_name.present?

    carrier_name
  end

  def shipment_number_text
    return '--' if shipment_number.zero?

    shipment_number
  end

  private

  def delete_articles_associations
    ArticleSell.where(sell_id: id).delete_all
  end
end
