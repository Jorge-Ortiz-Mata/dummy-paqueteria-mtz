FactoryBot.define do
  factory :user do
    trait :with_email do
      email { 'jorge@gmail.com' }
    end

    trait :with_password do
      password { '123456789' }
    end

    trait :with_password_confirmation do
      password_confirmation { '123456789' }
    end
  end
end
