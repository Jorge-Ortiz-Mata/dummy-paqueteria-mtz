class Destinatary < ApplicationRecord
  belongs_to :remitent
  has_many :sells

  validates :full_name, :primary_phone_number, :delivery_place, presence: true
  validates :primary_phone_number, length: { is: 10 }
  validates :primary_phone_number, numericality: { only_integer: true, message: 'debe tener solo números' }
  validates :secondary_phone_number, length: { is: 10 }, if: :secondary_phone_number_is_present?
  validates :secondary_phone_number, numericality: { only_integer: true, message: 'solo debe tener numeros' }, if: :secondary_phone_number_is_present?

  validates :zip_code, numericality: { only_integer: true, message: 'debe tener solo números' }, if: :deliver_at_home?
  validates :zip_code, length: { is: 5 }, if: :deliver_at_home?
  validates :street, :ext_number, :neighborhood, :city, :state, :zip_code, presence: true, if: :deliver_at_home?

  validates :estafeta_office_address, presence: true, if: :deliver_at_office?

  enum delivery_place: %i[home office]

  def full_address
    "Calle: #{street},
    No. ext: #{ext_number},
    Colonia: #{neighborhood},
    Ciudad: #{city},
    Estado: #{state},
    Código Postal: #{zip_code}"
  end

  private

  def secondary_phone_number_is_present?
    return true if secondary_phone_number.present?

    false
  end

  def deliver_at_home?
    return true if delivery_place.present? && delivery_place.eql?('home')

    false
  end

  def deliver_at_office?
    return true if delivery_place.present? && delivery_place.eql?('office')

    false
  end
end
