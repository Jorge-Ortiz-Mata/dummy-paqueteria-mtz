class DestinatariesController < AuthenticatedController
  before_action :set_sell
  before_action :set_remitent
  before_action :set_destinatary, only: %i[edit update]

  def index
    @destinataries = @remitent.destinataries.limit(3).order(:created_at)
  end

  def new
    @destinatary = Destinatary.new
  end

  def edit; end

  def create
    @destinatary = @remitent.destinataries.new destinatary_params

    respond_to do |format|
      if @destinatary.save
        @sell.update(remitent: @remitent, destinatary: @destinatary)
        format.html { redirect_to sell_path(@sell), notice: 'El remitente y destinatario han sido añadidos exitosamente.' }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace('destinatary_form', partial: 'destinataries/form', locals: { remitent: @remitent, url: remitent_destinataries_path(@remitent, sell_id: @sell.id), destinatary: @destinatary }) }
      end
    end
  end

  def update
    respond_to do |format|
      if @destinatary.update destinatary_params
        @sell.update(remitent: @remitent, destinatary: @destinatary)
        format.html { redirect_to sell_path(@sell), notice: 'El remitente y destinatario han sido actualizados exitosamente.' }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace('destinatary_form', partial: 'destinataries/form', locals: { remitent: @remitent, url: remitent_destinatary_path(@remitent, @destinatary, sell_id: @sell.id), destinatary: @destinatary }) }
      end
    end
  end

  def filter
    @destinataries = FilteredDestinataries.call filter_params

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.replace('destinataries_all', partial: 'destinataries/destinataries', locals: { destinataries: @destinataries, sell: @sell, remitent: @remitent }) }
    end
  end

  private

  def destinatary_params
    params.require(:destinatary).permit(
      :full_name,
      :street,
      :int_number,
      :ext_number,
      :neighborhood,
      :city,
      :state,
      :zip_code,
      :primary_phone_number,
      :secondary_phone_number,
      :delivery_place,
      :estafeta_office_address
    )
  end

  def set_remitent
    @remitent = Remitent.find(params[:remitent_id])
  end

  def set_destinatary
    @destinatary = Destinatary.find(params[:id])
  end

  def set_sell
    @sell = Sell.find(params[:sell_id])
  end

  def filter_params
    params.require(:destinatary).permit(:full_name, :remitent_id)
  end
end
