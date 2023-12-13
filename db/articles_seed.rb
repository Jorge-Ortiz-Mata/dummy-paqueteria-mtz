20.times do
  Article.create(name: Faker::Computer.stack, price: rand(10.0...500.0).round(2))
end
