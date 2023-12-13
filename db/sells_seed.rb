# Sells

if Article.all.any?
  first_article_id = Article.first.id
  last_article_id = Article.last.id
end

def time_rand(from = 0.0, to = Time.now)
  Time.at(from + rand * (to.to_f - from.to_f))
end

for i in 1...50 do
  @sell = Sell.create(date_of_sell: time_rand(Time.local(2023, 8, 15)))

  for i in 1...10 do
    id = rand(first_article_id..last_article_id)

    @sell.article_sells.create(article_id: id, quantity: rand(1...10))
  end
end
