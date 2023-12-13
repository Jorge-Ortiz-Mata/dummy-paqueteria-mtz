class SellsController < AuthenticatedController
  before_action :set_sell, except: %i[index create new]
  before_action :set_destinatary, only: %i[preview_remitent_destinatary update_remitent_destinatary]

  def index
    @departure_date = DepartureDate.equal_or_greater_than_today.first

    return unless @departure_date.present?

    @sells = @departure_date.sells.order(shipment_number: :desc).includes(:articles)
    authorize @sells
  end

  def show
    authorize @sell
    @new_sell = Sell.new
  end

  def new
    @sell = Sell.new
    @departure_date = DepartureDate.equal_or_greater_than_today.first
    authorize @sell
  end

  def edit
    authorize @sell
  end

  def create
    @sell = Sell.new
    @sell.departure_date = DepartureDate.equal_or_greater_than_today.first
    authorize @sell

    respond_to do |format|
      if @sell.save
        format.html { redirect_to sell_url(@sell), notice: 'Se añadido un nuevo envío' }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace('new_sell_form', partial: 'sells/form', locals: { sell: @sell, id: 'new_sell_form', btn_text: 'Crear' }) }
      end
    end
  end

  def update
    authorize @sell

    respond_to do |format|
      if @sell.update(sell_params)
        format.html { redirect_to sell_url(@sell), notice: 'El envío ha sido actualizado exitosamente.' }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace('edit_sell_form', partial: 'sells/form', locals: { sell: @sell, id: 'edit_sell_form', btn_text: 'Actualizar' }) }
      end
    end
  end

  def destroy
    authorize @sell

    @sell.destroy

    respond_to do |format|
      format.html { redirect_to sells_url, notice: 'El envío ha sido eliminado exitosamente.' }
    end
  end

  def filter
    @sells_filter = SellsFilter.new sells_filter_params

    respond_to do |format|
      if @sells_filter.save
        sells_filtered = @sells_filter.search

        format.turbo_stream { render turbo_stream: turbo_stream.replace('sells', partial: 'sells/sells', locals: { sells: sells_filtered, sells_filter: @sells_filter }) }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace('filter_form', partial: 'sells/filter_form', locals: { sells_filter: @sells_filter }) }
      end
    end
  end

  def export_pdf
    authorize @sell

    respond_to do |format|
      format.pdf do
        render pdf: 'file_name', template: 'sells/export_pdf', formats: [:html]
      end
    end
  end

  def estafeta_info
    authorize @sell
    @estafeta_form = Sells::EstafetaForm.new
    @estafeta_form.carrier_name = @sell.carrier_name
    @estafeta_form.tracking_guide = @sell.tracking_guide
  end

  def update_estafeta_info
    @estafeta_form = Sells::EstafetaForm.new estafeta_form_params
    @estafeta_form.sell_id = @sell.id

    respond_to do |format|
      if @estafeta_form.save
        format.html { redirect_to sell_path(@sell), notice: 'La información de la guía ha sido actualizada' }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace('estafeta_form', partial: 'sells/forms/estafeta_form', locals: { estafeta_form: @estafeta_form, sell: @sell }) }
      end
    end
  end

  def whatsapp; end

  def send_whatsapp
    authorize @sell

    account_sid = ENV['WHATSAPP_SID']
    auth_token = ENV['WHATSAPP_AUTH_TOKEN']
    @client = Twilio::REST::Client.new(account_sid, auth_token)

    @client.messages.create(
      body: "Estimado cliente 😀, es un placer saludarle 💁‍♀.\n Le proporcionamos su número de guía: #{@sell.tracking_guide} que tiene como destino: #{@sell.destinatary_deliver_place} \nLe pedimos de favor que lo conserve hasta que su envío llegue a su destino final ⏳📱. \nPor favor espere el siguiente mensaje para que pase a recoger su caja  🏘 . \nSi el envío 📦 lo mandó a domicilio, le solicitamos que de favor espere una semana más después de la fecha de entrega acordada, debido a los tiempos de entrega. \nLos envíos 📦 que van a oficinas de estafeta, se les recuerda que tienen dos días hábiles para pasar por ellos una vez que se les notifique de su llegada. \nSin más por el momento. \nGracias por su preferencia",
      from: 'whatsapp:+19723759446',
      to: "whatsapp:#{@sell.remitent_phone_number}"
    )

    redirect_to sell_path(@sell), notice: 'Se ha enviado el mensaje de whatsapp existosamente'
  end

  def remitent_destinatary
    @remitents = Remitent.all.order(created_at: :desc).limit(3)
  end

  def preview_remitent_destinatary; end

  def update_remitent_destinatary
    @sell.update(remitent: @destinatary.remitent, destinatary: @destinatary)

    redirect_to sell_path(@sell), notice: 'El remitente y destinatario han sido añadidos exitosamente.'
  end

  def shipment_number
    authorize @sell

    return unless @sell.shipment_number.zero?

    @last_sell = @sell.departure_date.sells.order(:shipment_number).last

    @sell.update(shipment_number: @last_sell.shipment_number.to_i + 1)

    redirect_to sell_path(@sell), notice: 'El número de envío ha sido asignado exitosamente exitosamente.'
  end

  private

  def set_sell
    @sell = Sell.find(params[:id])
  end

  def sell_params
    params.require(:sell).permit(:description, :destinatary_id)
  end

  def sells_filter_params
    params.require(:sells_filter).permit(:date_min, :date_max)
  end

  def remitent_destinatary_params
    params.require(:remitent_destinatary).permit(:destinatary_id, :remitent_name, :remitent_phone_number, :remitent_address, :phone_code)
  end

  def estafeta_form_params
    params.require(:sells_estafeta_form).permit(:tracking_guide, :carrier_name)
  end

  def set_destinatary
    @destinatary = Destinatary.find(params[:destinatary_id])
  end
end
