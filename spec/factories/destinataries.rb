FactoryBot.define do
  factory :destinatary do
    full_name { "MyString" }
    street { "MyString" }
    ext_number { "MyString" }
    int_number { "MyString" }
    neighborhood { "MyString" }
    city { "MyString" }
    state { "MyString" }
    zip_code { "MyString" }
    primary_phone_number { "MyString" }
    secondary_phone_number { "MyString" }
    remitent { nil }
  end
end
