class ArticlesController < AuthenticatedController
  before_action :set_article, only: %i[show edit update destroy]

  def index
    @articles = Article.all.order(:created_at)
    @filter_form = FilterForm.new
    authorize @articles
  end

  def show
    authorize @article
  end

  def new
    @article = Article.new
    @box_default_prices = DefaultPrice.box.order(:created_at)
    authorize @article
  end

  def edit
    authorize @article
  end

  def create
    @article = Article.new(article_params)
    authorize @article

    respond_to do |format|
      if @article.save
        format.html { redirect_to article_url(@article), notice: 'El articulo ha sido creado exitosamente' }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace('article-form', partial: 'articles/form', locals: { article: @article, btn_title: 'Crear articulo', cancel_path: articles_path }) }
      end
    end
  end

  def update
    authorize @article

    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to article_url(@article), notice: 'El articulo ha sido actualizado exitosamente' }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace('article-form', partial: 'articles/form', locals: { article: @article, btn_title: 'Actualizar articulo', cancel_path: article_path(@article) }) }
      end
    end
  end

  def destroy
    authorize @article
    @article.destroy

    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'El articulo ha sido eliminado exitosamente.' }
    end
  end

  def search_by_name
    return unless params[:name].present?

    articles = Article.search_with_name(params[:name])

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.replace('articles', partial: 'articles/articles', locals: { articles: articles, filter_form: FilterForm.new }) }
    end
  end

  def filter
    single_filter if params[:attribute].present?
    filter_with_form if params[:filter_form].present?
  end

  def estimate_price
    estimated_price = EstimatedPrice.new estimated_price_params

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.replace('estimated_price', partial: 'articles/estimated_price', locals: { volume: estimated_price.calculate[:suggested_volume], suggested_price: estimated_price.calculate[:suggested_price] }) }
    end
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:name, :price)
  end

  def filter_form_params
    params.require(:filter_form).permit(:min_price, :max_price)
  end

  def estimated_price_params
    params.require(:estimated_price).permit(:width, :length, :height)
  end

  def single_filter
    articles = Article.all.order(params[:attribute])
    @filter_form = FilterForm.new

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.replace('articles', partial: 'articles/articles', locals: { articles: articles, filter_form: FilterForm.new }) }
    end
  end

  def filter_with_form
    filter_form = FilterForm.new(filter_form_params)

    respond_to do |format|
      if filter_form.save
        articles = filter_form.search_process

        format.turbo_stream { render turbo_stream: turbo_stream.replace('articles', partial: 'articles/articles', locals: { articles: articles, filter_form: filter_form }) }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace('filter_form', partial: 'articles/filter_form', locals: { filter_form: filter_form }) }
      end
    end
  end
end
