class PagesController < AuthenticatedController
  def dashboard
    @revenue = ArticleSell.sum(:revenue).round(2)
    @sells = Sell.all.includes(:departure_date)
    @articles = Article.all.includes(:article_sells)
  end
end
