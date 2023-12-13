require 'csv'

class DepartureDate < ApplicationRecord
  scope :less_than_today, -> { where('date < ?', Date.today).order(date: :desc) }
  scope :equal_or_greater_than_today, -> { where('date >= ?', Date.today).order(:date) }

  validates :date, presence: true, uniqueness: true

  has_many :sells

  def self.to_csv(id)
    departure_date = DepartureDate.find(id)
    sells = departure_date.sells.order(shipment_number: :desc)

    CSV.generate do |csv|
      csv << %w[ENVIO GUIA DOMICILIO OCURRE]

      sells.each do |sell|
        row = []

        if sell.shipment_number.zero?
          row << '--'
        else
          row << sell.shipment_number_text
        end

        if sell.tracking_guide.present?
          row << sell.tracking_guide
        else
          row << '--'
        end

        if sell.destinatary.present?
          if sell.destinatary.street.present?
            row << sell.destinatary.full_address
          else
            row << '--'
          end

          if sell.destinatary.estafeta_office_address.present?
            row << sell.destinatary.estafeta_office_address
          else
            row << '--'
          end
        else
          row << '--'
          row << '--'
        end

        csv << row
      end
    end
  end
end
