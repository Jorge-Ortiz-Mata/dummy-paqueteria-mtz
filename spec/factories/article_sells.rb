FactoryBot.define do
  factory :article_sell do
    trait :with_attributes do
      quantity { 5 }
    end

    trait :with_sell do
      sell { create(:sell, :with_attributes) }
    end

    trait :with_article do
      article { create(:article, :with_attributes) }
    end
  end
end
