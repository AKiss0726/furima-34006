FactoryBot.define do
  factory :item do
    item_name { 'omuretsu' }
    description { 'aaaa' }
    category_id { 2 }
    condition_id { 2 }
    allocation_id { 2 }
    from_id { 2 }
    to_ship_id { 2 }
    price { 500 }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
