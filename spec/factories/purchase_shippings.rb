FactoryBot.define do
  factory :purchase_shipping do
    zip { '123-4567'}
    from_id { 2 }
    delivery_municipality { '横浜市港北区' }
    delivery_street { '六浦123' }
    delivery_building { '東京ハウス' }
    tel { '08098765432' }
    token { 'sample' }
    association :user
    association :item 
  end
end
