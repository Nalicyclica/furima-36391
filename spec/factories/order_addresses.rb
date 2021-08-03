FactoryBot.define do
  factory :order_address do
    post_number { "#{Faker::Number.number(digits: 3)}-#{Faker::Number.number(digits: 4)}" }
    prefecture_id { Faker::Number.within(range: 0..46) }
    city {Faker::Address.city}
    address {Faker::Address.street_address}
    apartment {Faker::Address.secondary_address}
    tel {Faker::Number.leading_zero_number(digits: 10)}
    token {"tok_#{Faker::Internet.password(min_length: 20, max_length: 30, mix_case: true, special_characters: true)}"}
  end
end
