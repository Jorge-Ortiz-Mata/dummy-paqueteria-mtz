class ArticleSellsController < AuthenticatedController
  before_action :set_sell, only: %i[create edit update destroy]
  before_action :set_article_sell, only: %i[edit update destroy]

  def edit
    authorize @article_sell
  end

  def create
    @article_sell = @sell.article_sells.build(article_sell_params)
    authorize @article_sell

    respond_to do |format|
      if @article_sell.save
        format.turbo_stream { render turbo_stream: turbo_stream.replace('article_sells', partial: 'article_sells/article_sells', locals: { sell: @sell }) }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace('article_sell_form', partial: 'article_sells/form', locals: { sell: @sell, article_sell: @article_sell, btn_text: 'Añadir articulo' }) }
      end
    end
  end

  def update
    authorize @article_sell

    respond_to do |format|
      if @article_sell.update article_sell_params
        format.turbo_stream { render turbo_stream: turbo_stream.replace('article_sells', partial: 'article_sells/article_sells', locals: { sell: @sell }) }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace("article_sell_#{@article_sell.id}", partial: 'article_sells/forms/edit', locals: { article_sell: @article_sell }) }
      end
    end
  end

  def destroy
    authorize @article_sell
    @article_sell.destroy

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.replace('article_sells', partial: 'article_sells/article_sells', locals: { sell: @sell }) }
    end
  end

  private

  def article_sell_params
    params.require(:article_sell).permit(:article_id, :quantity, :insured_articles, :insurance_policy_id, :special_price)
  end

  def set_sell
    @sell = Sell.find(params[:sell_id])
  end

  def set_article_sell
    @article_sell = ArticleSell.find(params[:id])
  end
end
