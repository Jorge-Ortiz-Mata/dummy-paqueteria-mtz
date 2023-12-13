FactoryBot.define do
  factory :profile do
    trait :with_attributes do
      first_name { 'Jorge' }
      last_name { 'Ortiz' }
      phone_number { '4441234567' }
    end

    trait :with_user do
      user { create(:user, :with_email, :with_password, :with_password_confirmation) }
    end
  end
end
