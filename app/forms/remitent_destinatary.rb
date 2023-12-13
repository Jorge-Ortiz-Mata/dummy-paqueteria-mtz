class RemitentDestinatary
  include ActiveModel::Model

  attr_accessor :sell_id, :destinatary_id, :remitent_name, :remitent_phone_number, :remitent_address, :phone_code

  validates :remitent_name, :remitent_phone_number, :remitent_address, :destinatary_id, :phone_code, presence: true
  validates :remitent_phone_number, length: { is: 10 }

  def save
    return false if invalid?

    Sell.find(sell_id).update(
      destinatary_id: destinatary_id,
      remitent_name: remitent_name,
      remitent_phone_number: remitent_phone_number,
      remitent_address: remitent_address,
      phone_code: phone_code
    )

    true
  end
end
