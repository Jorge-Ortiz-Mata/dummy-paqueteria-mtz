class EstimatedPrice
  def initialize(params = {})
    @width = params[:width]
    @height = params[:height]
    @length = params[:length]
    @volume = @width.to_i * @height.to_i * @length.to_i
  end

  def calculate
    if @volume < 1728
      price = DefaultPrice.box.find_by(name: 'caja_0').price

    elsif @volume >= 1728 && @volume <= 2304
      price = ((@volume - 1728) / DefaultPrice.box.find_by(name: 'caja_1').difference) + DefaultPrice.box.find_by(name: 'caja_0').price

    elsif @volume > 2304 && @volume <= 5184
      price = ((@volume - 2304) / DefaultPrice.box.find_by(name: 'caja_2').difference) + DefaultPrice.box.find_by(name: 'caja_1').price

    elsif @volume > 5184 && @volume <= 7776
      price = ((@volume - 5184) / DefaultPrice.box.find_by(name: 'caja_3').difference) + DefaultPrice.box.find_by(name: 'caja_2').price

    elsif @volume > 7_776 && @volume <= 10_368
      price = ((@volume - 7776) / DefaultPrice.box.find_by(name: 'caja_4').difference) + DefaultPrice.box.find_by(name: 'caja_3').price

    elsif @volume > 10_368 && @volume <= 10_648
      price = DefaultPrice.box.find_by(name: 'caja_4').price

    elsif @volume > 10_648 && @volume <= 11_520
      price = ((@volume - 10_648) / DefaultPrice.box.find_by(name: 'caja_6').difference) + DefaultPrice.box.find_by(name: 'caja_5').price

    elsif @volume > 11_520 && @volume <= 15_552
      price = ((@volume - 11_520) / DefaultPrice.box.find_by(name: 'caja_7').difference) + DefaultPrice.box.find_by(name: 'caja_6').price

    elsif @volume > 15_552
      price = DefaultPrice.box.find_by(name: 'caja_7').price
    end

    { suggested_volume: @volume, suggested_price: price.round(2) }
  end
end
