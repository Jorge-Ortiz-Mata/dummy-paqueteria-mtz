FactoryBot.define do
  factory :sell do
    trait :with_attributes do
      date_of_sell { '2023-09-09' }
      description { 'It was created yesterday' }
    end
  end
end
