class DepartureDatesController < AuthenticatedController
  before_action :set_departure_date, only: %i[show edit update destroy export_csv]

  def index
    @next_departure_dates = DepartureDate.equal_or_greater_than_today
    @prev_departure_dates = DepartureDate.less_than_today
    authorize @next_departure_dates
    authorize @prev_departure_dates
  end

  def show
    authorize @departure_date
  end

  def new
    @departure_date = DepartureDate.new
    authorize @departure_date
  end

  def edit
    authorize @departure_date
  end

  def create
    @departure_date = DepartureDate.new(departure_date_params)
    authorize @departure_date

    respond_to do |format|
      if @departure_date.save
        format.html { redirect_to departure_dates_path, notice: 'La fecha de salida ha sido añadida exitosamente.' }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace('new_departure_date_form', partial: 'departure_dates/form', locals: { departure_date: @departure_date, id: 'new_departure_date_form' }) }
      end
    end
  end

  def update
    authorize @departure_date

    respond_to do |format|
      if @departure_date.update(departure_date_params)
        format.html { redirect_to departure_date_path(@departure_date), notice: 'La fecha de salida ha sido actualizada exitosamente.' }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace('edit_departure_date_form', partial: 'departure_dates/form', locals: { departure_date: @departure_date, id: 'edit_departure_date_form' }) }
      end
    end
  end

  def destroy
    authorize @departure_date
    @departure_date.destroy

    respond_to do |format|
      format.html { redirect_to departure_dates_url, notice: 'La fecha de salida ha sido eliminada exitosamente.' }
    end
  end

  def export_csv
    respond_to do |format|
      format.csv { send_data DepartureDate.to_csv(params[:id]), filename: "fecha-de-salida-#{DateTime.now.strftime('%d%m%Y%H%M')}.csv"}
    end
  end

  private

  def set_departure_date
    @departure_date = DepartureDate.find(params[:id])
  end

  def departure_date_params
    params.require(:departure_date).permit(:date)
  end
end
