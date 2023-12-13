module SellsHelper
  def humanize_carrier(name)
    return name if name.eql? 'DHL'

    name.humanize
  end
end
