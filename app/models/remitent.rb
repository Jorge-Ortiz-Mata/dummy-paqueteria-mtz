class Remitent < ApplicationRecord
  has_many :destinataries
  has_many :sells

  validates :name, :phone_number, :phone_code, presence: true
  validates :phone_number, numericality: { only_integer: true, message: 'debe tener solo números' }
  validates :phone_number, length: { is: 10 }

  AREA_CODE = ['+1', '+521'].freeze
end
