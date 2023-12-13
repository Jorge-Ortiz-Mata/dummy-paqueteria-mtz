module Sells
  class EstafetaForm
    include ActiveModel::Model

    attr_accessor :tracking_guide, :carrier_name, :sell_id

    # validates :tracking_guide, presence: true

    def save
      return false if invalid?

      Sell.find(sell_id).update(tracking_guide: tracking_guide, carrier_name: carrier_name)

      true
    end
  end
end
