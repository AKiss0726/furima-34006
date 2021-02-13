FactoryBot.define do
  factory :user do
    nickname {"Taro"}
    email {Faker::Internet.free_email}
    password { '1a' + Faker::Internet.password(min_length: 6)}
    password_confirmation {password}
    family_name {"田中"}
    first_name {"太朗"}
    furigana_family_name {"タナカ"}
    furigana_first_name {"タロウ"}
    birthday {Faker::Date.between(from: '1970-01-01', to: '2020-12-31')}
  end
end
