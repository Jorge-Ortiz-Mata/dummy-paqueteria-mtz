class DefaultPricesController < AuthenticatedController
  before_action :set_default_price, only: %i[edit update]

  def edit; end

  def update
    respond_to do |format|
      if @default_price.update default_price_params
        format.html { redirect_to new_article_path, notice: 'El precio ha sido actualizado correctamente' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_default_price
    @default_price = DefaultPrice.find(params[:id])
  end

  def default_price_params
    params.require(:default_price).permit(:price)
  end
end
