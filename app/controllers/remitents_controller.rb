class RemitentsController < AuthenticatedController
  before_action :set_sell, only: %i[new create edit update filter]
  before_action :set_remitent, only: %i[edit update]

  def new
    @remitent = Remitent.new
  end

  def edit; end

  def create
    @remitent = Remitent.new remitent_params

    respond_to do |format|
      if @remitent.save
        format.html { redirect_to remitent_destinatary_sell_path(@sell), notice: 'El remitente ha sido añadido exitosamente.' }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace('remitent_form', partial: 'remitents/form', locals: { remitent: @remitent, url: remitents_path(sell_id: @sell.id) }) }
      end
    end
  end

  def update
    respond_to do |format|
      if @remitent.update remitent_params
        format.html { redirect_to remitent_destinatary_sell_path(@sell), notice: 'El remitente ha sido actualizado exitosamente.' }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace('remitent_form', partial: 'remitents/form', locals: { remitent: @remitent, url: remitent_path(@remitent, sell_id: @sell.id) }) }
      end
    end
  end

  def filter
    @remitents = FilteredRemitents.call remitent_params

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.replace('remitents', partial: 'remitents/remitents', locals: { remitents: @remitents, sell: @sell }) }
    end
  end

  private

  def remitent_params
    params.require(:remitent).permit(:name, :phone_number, :phone_code, :address)
  end

  def set_sell
    @sell = Sell.find(params[:sell_id])
  end

  def set_remitent
    @remitent = Remitent.find(params[:id])
  end
end
