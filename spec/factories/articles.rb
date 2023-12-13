FactoryBot.define do
  factory :article do
    trait :with_attributes do
      name { 'Play Station 5' }
      # description { 'Short description about this article' }
      price { 399.66 }
    end

    trait :with_second_price do
      price { 3524.31 }
    end

    trait :with_third_price do
      price { 1273.66 }
    end
  end
end
